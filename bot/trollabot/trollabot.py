#! /usr/bin/env python
import os
import signal
import sys
from threading import Thread

from flask import Flask
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from testcontainers.postgres import PostgresContainer

from app.trollabot.channelname import ChannelName
from app.trollabot.database import Base, DB_API
from bot.trollabot.irc_bot import IrcConfig, TwitchIRCBot, setup_connection
from web import create_app

def run_with_pg_connection_string(conn_str, on_engine_create) -> None:
    if conn_str.startswith("postgres://"):
        conn_str = conn_str.replace("postgres://", "postgresql://", 1)
    run_bot(conn_str, on_engine_create)
    run_webapp(conn_str)

def run_bot(conn_str, on_engine_create):
    print("running bot")
    engine = create_engine(conn_str, isolation_level="REPEATABLE READ")
    on_engine_create(engine)
    Base.metadata.create_all(engine)
    db_session = sessionmaker(autocommit=False, autoflush=False, bind=engine)()
    db_api: DB_API = DB_API(db_session)
    db_api.streams.join(ChannelName("artofthetroll"), "artofthetroll")
    reactor, connection = setup_connection(irc_config=IrcConfig())
    make_shutdown_handler(reactor, db_session)

    _: TwitchIRCBot = TwitchIRCBot(connection, db_api)

    def go():
        print("RUNNING IRC BOT")
        reactor.process_forever()
        db_session.close()
        Base.metadata.drop_all(bind=engine)

    bot_thread: Thread = Thread(target=go)
    bot_thread.daemon = True
    bot_thread.start()

def run_webapp(conn_str):
    if os.getenv("TROLLABOT_WEBAPP") == "enabled":
        app: Flask = create_app(conn_str)
        port: int = int(os.environ.get('PORT', 5000))
        debug_mode: bool = os.getenv("ENV") != "prod"
        print("RUNNING WEBAPP")
        app.run(debug=debug_mode, host='0.0.0.0', port=port)

def run_via_test_container() -> None:
    with PostgresContainer("postgres:latest") as postgres:
        run_with_pg_connection_string(postgres.get_connection_url(),
                                      lambda engine: Base.metadata.create_all(engine))

def run_via_external_db() -> None:
    run_with_pg_connection_string(os.getenv('DATABASE_URL'), lambda engine: None)

def make_shutdown_handler(reactor, db_session):
    def shutdown_handler(signum, frame):
        print('Shutting down gracefully...')
        db_session.close()
        # Optionally, also stop the reactor if you have access to it here
        print('Calling stop on reactor')
        reactor.disconnect_all("Goodnight, cruel world.")
        print('Calling exit')
        sys.exit(0)

    signal.signal(signal.SIGTERM, shutdown_handler)
    signal.signal(signal.SIGINT, shutdown_handler)
