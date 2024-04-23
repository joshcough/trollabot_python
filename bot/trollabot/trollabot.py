#! /usr/bin/env python
import os
import signal
import sys
import time
from threading import Thread

from flask import Flask
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from testcontainers.postgres import PostgresContainer

from app.trollabot.channelname import ChannelName
from app.trollabot.database import Base, DB_API
from app.trollabot.loggo import get_logger
from bot.trollabot.irc_bot import IrcConfig, TwitchIRCBot, setup_connection
from web import create_app

logger = get_logger(__name__)

def run_with_pg_connection_string(conn_str, on_engine_create) -> None:
    if conn_str.startswith("postgres://"):
        conn_str = conn_str.replace("postgres://", "postgresql://", 1)
    run_bot(conn_str, on_engine_create)
    run_webapp(conn_str)

def run_bot(conn_str, on_engine_create):
    logger.debug("Initializing bot components...")
    engine = create_engine(conn_str, isolation_level="REPEATABLE READ")
    on_engine_create(engine)
    Base.metadata.create_all(engine)
    db_session = sessionmaker(autocommit=False, autoflush=False, bind=engine)()

    def monitored_bot():
        while True:
            try:
                logger.info("Running bot...")
                db_api = DB_API(db_session)
                db_api.streams.join(ChannelName("artofthetroll"), "artofthetroll")
                reactor, connection = setup_connection(irc_config=IrcConfig())
                make_shutdown_handler(reactor, db_session)

                _: TwitchIRCBot = TwitchIRCBot(connection, db_api)
                reactor.process_forever()
            except Exception as e:
                logger.error(f"Bot encountered an error: {e}", exc_info=True)
                logger.error(f"Error in bot operation: {e}, attempting to restart...")
                db_session.rollback()
                time.sleep(5)  # Delay before restarting to avoid rapid failure loop
            finally:
                logger.info("Cleaning up bot resources...")
                db_session.close()

    bot_thread: Thread = Thread(target=monitored_bot)
    bot_thread.daemon = True
    bot_thread.start()

def run_webapp(conn_str):
    if os.getenv("TROLLABOT_WEBAPP") == "enabled":
        app: Flask = create_app(conn_str)
        port: int = int(os.environ.get('PORT', 5000))
        debug_mode: bool = os.getenv("ENV") != "prod"
        logger.info("RUNNING WEBAPP")
        app.run(debug=debug_mode, host='0.0.0.0', port=port)

def run_via_test_container() -> None:
    with PostgresContainer("postgres:latest") as postgres:
        run_with_pg_connection_string(postgres.get_connection_url(),
                                      lambda engine: Base.metadata.create_all(engine))

def run_via_external_db() -> None:
    run_with_pg_connection_string(os.getenv('DATABASE_URL'), lambda engine: None)

def make_shutdown_handler(reactor, db_session):
    def shutdown_handler(signum, frame):
        logger.info('Shutting down gracefully...')
        db_session.close()
        # Optionally, also stop the reactor if you have access to it here
        logger.info('Calling stop on reactor')
        reactor.disconnect_all("Goodnight, cruel world.")
        logger.info('Calling exit')
        sys.exit(0)

    signal.signal(signal.SIGTERM, shutdown_handler)
    signal.signal(signal.SIGINT, shutdown_handler)
