import pytest
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from testcontainers.postgres import PostgresContainer

from app.trollabot.database import Base, Quote, Stream, DB_API
from app.trollabot.messages import ChannelName

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
    new_stream = db_api.streams.insert_stream(ChannelName("test"), "tester")
    queried_stream = db_api.streams.get_stream_by_name(ChannelName("test"))
    assert queried_stream is not None
    assert queried_stream.name == new_stream.name
    assert queried_stream.added_by == new_stream.added_by

def test_can_join_stream(db_api, clean_db):
    new_stream = db_api.streams.insert_stream(ChannelName("test"), "tester")
    queried_stream = db_api.streams.get_stream_by_name(new_stream.channel_name())
    assert not queried_stream.joined
    db_api.streams.join(ChannelName("test"), "tester")
    queried_stream = db_api.streams.get_stream_by_name(new_stream.channel_name())
    assert queried_stream.joined

def test_can_join_stream_that_doesnt_exist(db_api, clean_db):
    db_api.streams.join(ChannelName("test"), "tester")
    queried_stream = db_api.streams.get_stream_by_name(ChannelName("test"))
    assert queried_stream.joined

def test_inserts_advance_qid(db_api, clean_db):
    troll = db_api.streams.insert_stream(ChannelName("test"), "tester")
    daut = db_api.streams.insert_stream(ChannelName("daut"), "tester")

    db_api.quotes.insert_quote(troll.channel_name(), "tester", "hi there", )
    db_api.quotes.insert_quote(daut.channel_name(), "tester", "yo")
    db_api.quotes.insert_quote(troll.channel_name(), "tester", "bye")

    troll_quotes = db_api.quotes.get_all(ChannelName("test"))
    qids = list(map(lambda x: x.qid, troll_quotes))
    assert qids == [1, 2]

def test_get_quote_by_qid(db_api, clean_db):
    troll = db_api.streams.insert_stream(ChannelName("test"), "tester")
    q1 = db_api.quotes.insert_quote(troll.channel_name(), "tester", "hi there")
    q2 = db_api.quotes.insert_quote(troll.channel_name(), "tester", "bye", )
    assert db_api.quotes.get_quote(ChannelName("test"), q1.qid).text == "hi there"
    assert db_api.quotes.get_quote(ChannelName("test"), q2.qid).text == "bye"

def test_can_delete_quote(db_api, clean_db):
    troll = db_api.streams.insert_stream(ChannelName("test"), "tester")
    q1 = db_api.quotes.insert_quote(troll.channel_name(), "tester", "hi there")
    assert db_api.quotes.get_quote(ChannelName("test"), q1.qid).text == "hi there"
    db_api.quotes.delete_quote(ChannelName("test"), q1.qid, "tester")
    assert db_api.quotes.get_quote(ChannelName("test"), q1.qid) == None
