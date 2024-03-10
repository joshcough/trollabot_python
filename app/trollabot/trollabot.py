#! /usr/bin/env python
import os
import signal

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from testcontainers.postgres import PostgresContainer

from app.trollabot.database import Base, DB_API
from app.trollabot.irc_bot import IrcConfig, TwitchIRCBot, setup_connection
from app.trollabot.messages import ChannelName

def run_with_pg_connection_string(conn_str, on_engine_create) -> None:
    if conn_str.startswith("postgres://"):
        conn_str = conn_str.replace("postgres://", "postgresql://", 1)

    engine = create_engine(conn_str, isolation_level="REPEATABLE READ")
    on_engine_create(engine)
    Base.metadata.create_all(engine)
    db_session = sessionmaker(autocommit=False, autoflush=False, bind=engine)()
    db_api: DB_API = DB_API(db_session)

    reactor, connection = setup_connection(irc_config=IrcConfig())
    make_shutdown_handler(reactor, db_session)

    bot: TwitchIRCBot = TwitchIRCBot(connection, db_api)
    reactor.process_forever()

    db_session.close()
    Base.metadata.drop_all(bind=engine)

def run_via_test_container() -> None:
    with PostgresContainer("postgres:latest") as postgres:
        run_with_pg_connection_string(postgres.get_connection_url(),
                                      lambda engine: Base.metadata.create_all(engine))

def run_via_external_db() -> None:
    run_with_pg_connection_string(os.getenv('DATABASE_URL'), lambda engine: None)

def make_shutdown_handler(db_session, reactor):
    def shutdown_handler(signum, frame):
        print('Shutting down gracefully...')
        db_session.close()
        # Optionally, also stop the reactor if you have access to it here
        reactor.stop()

    signal.signal(signal.SIGTERM, shutdown_handler)
    signal.signal(signal.SIGINT, shutdown_handler)
