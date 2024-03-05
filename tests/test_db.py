import pytest
from app.trollabot.database import Base, Quote, Stream, StreamsInterface, QuotesInterface, DB_API
from testcontainers.postgres import PostgresContainer
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker


@pytest.fixture(scope="module")
def db_api():
    with PostgresContainer("postgres:latest") as postgres:
        engine = create_engine(postgres.get_connection_url(), isolation_level="REPEATABLE READ")
        Base.metadata.create_all(engine)
        TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
        db_session = TestingSessionLocal()
        db = DB_API(db_session)
        yield db
        db_session.close()
        Base.metadata.drop_all(bind=engine)


@pytest.fixture(scope="function")
def clean_db(db_api):
    yield
    db_session = db_api.streams.session
    db_session.query(Quote).delete()
    db_session.query(Stream).delete()
    db_session.commit()


def test_insert_and_get_stream(db_api, clean_db):
    new_stream = db_api.streams.insert_stream("test", "tester")
    queried_stream = db_api.streams.get_stream_by_name("test")
    assert queried_stream is not None
    assert queried_stream.name == new_stream.name
    assert queried_stream.added_by == new_stream.added_by


def test_can_join_stream(db_api, clean_db):
    new_stream = db_api.streams.insert_stream("test", "tester")
    queried_stream = db_api.streams.get_stream_by_name(new_stream.name)
    assert not queried_stream.joined
    db_api.streams.join("test")
    queried_stream = db_api.streams.get_stream_by_name(new_stream.name)
    assert queried_stream.joined


def test_inserts_advance_qid(db_api, clean_db):
    troll = db_api.streams.insert_stream("test", "tester")
    daut = db_api.streams.insert_stream("daut", "tester")

    db_api.quotes.insert_quote("hi there", "tester", troll.name)
    db_api.quotes.insert_quote("yo", "tester", daut.name)
    db_api.quotes.insert_quote("bye", "tester", troll.name)

    troll_quotes = db_api.quotes.get_all("test")
    qids = list(map(lambda x: x.qid, troll_quotes))
    assert qids == [1, 2]


def test_get_quote_by_qid(db_api, clean_db):
    troll = db_api.streams.insert_stream("test", "tester")
    q1 = db_api.quotes.insert_quote("hi there", "tester", troll.name)
    q2 = db_api.quotes.insert_quote("bye", "tester", troll.name)
    assert db_api.quotes.get_quote("test", q1.qid).text == "hi there"
    assert db_api.quotes.get_quote("test", q2.qid).text == "bye"


def test_can_delete_quote(db_api, clean_db):
    troll = db_api.streams.insert_stream("test", "tester")
    q1 = db_api.quotes.insert_quote("hi there", "tester", troll.name)
    assert db_api.quotes.get_quote("test", q1.qid).text == "hi there"
    db_api.quotes.delete_quote("test", q1.qid, "tester")
    assert db_api.quotes.get_quote("test", q1.qid) == None
