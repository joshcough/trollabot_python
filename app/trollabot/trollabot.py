#! /usr/bin/env python
import os

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from testcontainers.postgres import PostgresContainer

from app.trollabot.database import Base, DB_API
from app.trollabot.irc_bot import IrcConfig, TwitchIRCBot, setup_connection
from app.trollabot.messages import ChannelName

def run_with_pg_connection_string(conn_str):
    engine = create_engine(conn_str, isolation_level="REPEATABLE READ")
    Base.metadata.create_all(engine)
    TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    db_session = TestingSessionLocal()
    db_api = DB_API(db_session)

    # TODO: remove these before deploying
    # but not until we write the !join command
    db_api.streams.insert_stream(ChannelName("artofthetroll"), "artofthetroll")
    db_api.streams.join(ChannelName("artofthetroll"), "artofthetroll")

    reactor, connection = setup_connection(irc_config=IrcConfig())
    bot = TwitchIRCBot(connection, db_api)
    reactor.process_forever()

    db_session.close()
    Base.metadata.drop_all(bind=engine)

def run_via_test_container():
    with PostgresContainer("postgres:latest") as postgres:
        run_with_pg_connection_string(postgres.get_connection_url())

def run_via_external_db():
    run_with_pg_connection_string(os.getenv('DATABASE_URL'))
