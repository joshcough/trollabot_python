#! /usr/bin/env python

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from testcontainers.postgres import PostgresContainer

from app.trollabot.database import Base, EnvDbConfig, ContainerDbConfig, StreamsInterface, QuotesInterface
from app.trollabot.irc_bot import IrcConfig, TwitchIRCBot, setup_connection


def run_with_pg_connection_string(conn_str):
    engine = create_engine(conn_str, isolation_level="REPEATABLE READ")
    Base.metadata.create_all(engine)
    TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    db_session = TestingSessionLocal()
    streams = StreamsInterface(db_session)
    quotes = QuotesInterface(db_session)

    # TODO: remove these before deploying
    # but not until we write the !join command
    streams.insert_stream("artofthetroll", "artofthetroll")
    streams.join("artofthetroll")

    reactor, connection = setup_connection(irc_config=IrcConfig())
    bot = TwitchIRCBot(connection, streams, quotes)
    reactor.process_forever()

    db_session.close()
    Base.metadata.drop_all(bind=engine)


def run_via_test_container():
    with PostgresContainer("postgres:latest") as postgres:
        config = ContainerDbConfig(postgres)
        run_with_pg_connection_string(config.get_connection_string())


def run_via_external_db():
    config = EnvDbConfig()
    run_with_pg_connection_string(config.get_connection_string())
