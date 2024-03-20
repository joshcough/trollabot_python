from app.trollabot.database import Score
from app.trollabot.messages import ChannelName

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

def test_can_create_and_increment_counters(db_api, clean_db):
    troll = db_api.streams.insert_stream(ChannelName("test"), "tester")

    db_api.counters.insert_counter(troll.channel_name(), "tester", "housed")
    db_api.counters.inc_counter(troll.channel_name(), "housed")
    db_api.counters.inc_counter(troll.channel_name(), "housed")
    db_api.counters.inc_counter(troll.channel_name(), "housed")
    counter = db_api.counters.get_counter(troll.channel_name(), "housed")
    assert counter.count == 3

    db_api.counters.insert_counter(troll.channel_name(), "tester", "z")
    db_api.counters.inc_counter(troll.channel_name(), "z")
    db_api.counters.inc_counter(troll.channel_name(), "z")
    counterz = db_api.counters.get_counter(troll.channel_name(), "z")

    assert counterz.count == 2

def test_scores(db_api, clean_db):
    troll = db_api.streams.insert_stream(ChannelName("test"), "tester")

    default_score = Score(
        channel="test",
        player1="player",
        player2="opponent",
        player1_score=0,
        player2_score=0
    )

    score1 = db_api.scores.get_score(troll.channel_name())
    assert score1 == default_score

