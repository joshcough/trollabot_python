#! /usr/bin/env python
import signal
import sys
import time

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session

from app.trollabot.channelname import ChannelName
from app.trollabot.database import Base, DB_API
from app.trollabot.loggo import get_logger
from bot.trollabot.irc_bot import IrcConfig, TwitchIRCBot, setup_connection
from bot.trollabot.notifier import Notifier

logger = get_logger(__name__)

# Global flag for graceful shutdown
shutdown_requested = False


def signal_handler(signum, frame):
    """Handle shutdown signals gracefully."""
    global shutdown_requested
    logger.info('Shutdown signal received, will stop after current iteration...')
    shutdown_requested = True


def run_bot(conn_str, on_engine_create):
    """
    Run the Twitch IRC bot with automatic restart on failure.

    The bot will:
    - Automatically reconnect on IRC disconnections
    - Restart on crashes with error notifications
    - Create fresh database sessions on each attempt
    - Respect shutdown signals gracefully
    """
    logger.info("Initializing bot...")

    # Setup signal handlers
    signal.signal(signal.SIGTERM, signal_handler)
    signal.signal(signal.SIGINT, signal_handler)

    # Initialize database engine (persistent)
    if conn_str.startswith("postgres://"):
        conn_str = conn_str.replace("postgres://", "postgresql://", 1)

    engine = create_engine(conn_str, isolation_level="REPEATABLE READ")
    on_engine_create(engine)
    Base.metadata.create_all(engine)

    # Initialize notifier
    notifier = Notifier()

    # Track restart attempts
    restart_count = 0
    max_rapid_restarts = 10
    rapid_restart_window = 60  # seconds
    restart_times = []

    while not shutdown_requested:
        db_session: Session = None
        reactor = None

        try:
            restart_count += 1
            current_time = time.time()

            # Check for rapid restart loop (circuit breaker)
            restart_times = [t for t in restart_times if current_time - t < rapid_restart_window]
            restart_times.append(current_time)

            if len(restart_times) > max_rapid_restarts:
                fatal_msg = f"Bot restarted {max_rapid_restarts} times in {rapid_restart_window}s. Giving up."
                logger.error(fatal_msg)
                notifier.notify_fatal(fatal_msg)
                sys.exit(1)

            # Create fresh database session for this attempt
            SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
            db_session = SessionLocal()

            logger.info(f"Starting bot (attempt #{restart_count})...")

            # Initialize database and join channel
            db_api = DB_API(db_session)
            db_api.streams.join(ChannelName("artofthetroll"), "artofthetroll")

            # Setup IRC connection
            reactor, connection = setup_connection(irc_config=IrcConfig())

            # Create bot instance and start (only greet on first connect)
            _: TwitchIRCBot = TwitchIRCBot(connection, db_api, is_first_connect=(restart_count == 1))

            logger.info("Bot connected, processing messages...")
            reactor.process_forever()

            # If we get here, reactor stopped cleanly
            logger.info("Bot stopped cleanly")
            break

        except SystemExit as e:
            # IRC disconnection (raised by on_disconnect handler)
            logger.warning(f"IRC disconnected, will reconnect immediately...")

            if restart_count > 1:  # Don't notify on first connection attempt
                notifier.notify_restart(restart_count, "IRC disconnection")

            # Clean up reactor
            if reactor:
                try:
                    reactor.disconnect_all("Reconnecting...")
                except Exception:
                    pass

            # Rollback any pending transactions
            if db_session:
                try:
                    db_session.rollback()
                except Exception:
                    pass

            # Short delay before reconnecting
            time.sleep(2)

        except Exception as e:
            # Unexpected error - notify and restart with delay
            logger.error(f"Bot crashed with error: {e}", exc_info=True)

            # Send detailed error notification
            notifier.notify_error(e, f"Bot crash (attempt #{restart_count})")

            # Clean up
            if reactor:
                try:
                    reactor.disconnect_all("Error occurred, restarting...")
                except Exception as inner_e:
                    logger.error(f"Failed to disconnect reactor: {inner_e}")

            if db_session:
                try:
                    db_session.rollback()
                except Exception:
                    pass

            # Wait before restarting to avoid rapid failure loops
            logger.info("Waiting 10 seconds before restart...")
            time.sleep(10)

        finally:
            # Always close the database session
            if db_session:
                try:
                    db_session.close()
                    logger.debug("Database session closed")
                except Exception as e:
                    logger.error(f"Error closing database session: {e}")

    logger.info("Bot shutdown complete")
