from app.trollabot.channelname import ChannelName

def test_inserts_advance_qid(db_api):
    troll = db_api.streams.insert_stream(ChannelName("test"), "tester")
    daut = db_api.streams.insert_stream(ChannelName("daut"), "tester")

    db_api.quotes.insert_quote(troll.channel_name(), "tester", "hi there", )
    db_api.quotes.insert_quote(daut.channel_name(), "tester", "yo")
    db_api.quotes.insert_quote(troll.channel_name(), "tester", "bye")

    troll_quotes = db_api.quotes.get_all(ChannelName("test"))
    qids = list(map(lambda x: x.qid, troll_quotes))
    assert qids == [1, 2]

def test_get_quote_by_qid(db_api):
    troll = db_api.streams.insert_stream(ChannelName("test"), "tester")
    q1 = db_api.quotes.insert_quote(troll.channel_name(), "tester", "hi there")
    q2 = db_api.quotes.insert_quote(troll.channel_name(), "tester", "bye", )
    assert db_api.quotes.get_quote(ChannelName("test"), q1.qid).text == "hi there"
    assert db_api.quotes.get_quote(ChannelName("test"), q2.qid).text == "bye"

def test_can_delete_quote(db_api):
    troll = db_api.streams.insert_stream(ChannelName("test"), "tester")
    q1 = db_api.quotes.insert_quote(troll.channel_name(), "tester", "hi there")
    assert db_api.quotes.get_quote(ChannelName("test"), q1.qid).text == "hi there"
    db_api.quotes.delete_quote(ChannelName("test"), q1.qid, "tester")
    assert db_api.quotes.get_quote(ChannelName("test"), q1.qid) == None

def test_search_quotes(db_api):
    troll = db_api.streams.insert_stream(ChannelName("test"), "tester")

    db_api.quotes.insert_quote(troll.channel_name(), "tester", "hi there", )
    db_api.quotes.insert_quote(troll.channel_name(), "tester", "bye")
    db_api.quotes.insert_quote(troll.channel_name(), "tester", "hiya karate chop")

    random_quote = db_api.quotes.search_quotes(troll.channel_name(), "hi")
    assert random_quote.qid == 1 or random_quote.qid == 3
