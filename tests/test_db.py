import pytest
from app.trollabot.database import Base, Quote, Stream, StreamsInterface, QuotesInterface
from testcontainers.postgres import PostgresContainer
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

@pytest.fixture(scope="module")
def interfaces():
    with PostgresContainer("postgres:latest") as postgres:
        engine = create_engine(postgres.get_connection_url(), isolation_level="REPEATABLE READ")
        Base.metadata.create_all(engine)
        TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
        db_session = TestingSessionLocal()
        streams = StreamsInterface(db_session)
        quotes = QuotesInterface(db_session)
        yield streams, quotes
        db_session.close()
        Base.metadata.drop_all(bind=engine)

@pytest.fixture(scope="function")
def clean_db(interfaces):
    yield
    streams, quotes = interfaces
    db_session = streams.session
    db_session.query(Quote).delete()
    db_session.query(Stream).delete()
    db_session.commit()

def test_insert_and_get_stream(interfaces, clean_db):
    streams, _ = interfaces
    new_stream = streams.insert_stream("test", "tester")
    queried_stream = streams.get_stream_by_name("test")
    assert queried_stream is not None
    assert queried_stream.name == new_stream.name
    assert queried_stream.added_by == new_stream.added_by

def test_can_join_stream(interfaces, clean_db):
    streams, _ = interfaces
    new_stream = streams.insert_stream("test", "tester")
    queried_stream = streams.get_stream_by_name(new_stream.name)
    assert not queried_stream.joined
    streams.join("test")
    queried_stream = streams.get_stream_by_name(new_stream.name)
    assert queried_stream.joined

def test_inserts_advance_qid(interfaces, clean_db):
    streams, quotes = interfaces
    troll = streams.insert_stream("test", "tester")
    daut = streams.insert_stream("daut", "tester")

    quotes.insert_quote("hi there", "tester", troll.name)
    quotes.insert_quote("yo", "tester", daut.name)
    quotes.insert_quote("bye", "tester", troll.name)

    troll_quotes = quotes.get_all("test")
    qids = list(map(lambda x: x.qid, troll_quotes))
    assert qids == [1,2]

def test_get_quote_by_qid(interfaces, clean_db):
    streams, quotes = interfaces
    troll = streams.insert_stream("test", "tester")
    q1 = quotes.insert_quote("hi there", "tester", troll.name)
    q2 = quotes.insert_quote("bye", "tester", troll.name)
    assert quotes.get_quote("test", q1.qid).text == "hi there"
    assert quotes.get_quote("test", q2.qid).text == "bye"

def test_can_delete_quote(interfaces, clean_db):
    streams, quotes = interfaces
    troll = streams.insert_stream("test", "tester")
    q1 = quotes.insert_quote("hi there", "tester", troll.name)
    assert quotes.get_quote("test", q1.qid).text == "hi there"
    quotes.delete_quote("test", q1.qid, "tester")
    assert quotes.get_quote("test", q1.qid) == None
