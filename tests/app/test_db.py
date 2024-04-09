from app.trollabot.channelname import ChannelName
from app.trollabot.database.scores import Score

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
    score1 = db_api.scores.get_score(troll.channel_name())
    assert score1 == Score.empty_score(ChannelName("test"))

def test_can_create_user_commands(db_api, clean_db):
    troll = db_api.streams.insert_stream(ChannelName("test"), "tester")

    db_api.user_commands.insert_user_command(troll.channel_name(), "tester", "housed", "has been housed n times")
    cmd = db_api.user_commands.get_user_command(troll.channel_name(), "housed")
    assert cmd.body == "has been housed n times"

    db_api.user_commands.delete_user_command(troll.channel_name(), "tester", "housed")
    cmd = db_api.user_commands.get_user_command(troll.channel_name(), "housed")
    assert cmd == None
