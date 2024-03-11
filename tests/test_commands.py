from app.trollabot.commands import add_quote_command, get_quote_command, AddQuoteAction, GetExactQuoteAction, \
    GetRandomQuoteAction, BotCommand, del_quote_command, DelQuoteAction, join_stream_command, JoinStreamAction, \
    part_stream_command, PartStreamAction, score_command, SetAllScoreAction, process_message, GetScoreAction, \
    SetScoreAction
from app.trollabot.database import Score
from app.trollabot.messages import Message, Tags, ChannelName

test_stream: ChannelName = ChannelName("test_stream")
test_user = "test-user"
mod_tags = Tags([{'key': 'mod', 'value': '1'}])

def mk_message(msg: str, user: str = test_user, tags: Tags = Tags([])) -> Message:
    return Message(test_stream, user, tags, msg)

def to_action(command: BotCommand, msg: str):
    return command.to_action(mk_message(msg))

def test_join_stream_parsing():
    res = to_action(join_stream_command, "!join other_stream")
    assert res == JoinStreamAction(test_stream, test_user, ChannelName("other_stream"))
    res2 = to_action(join_stream_command, "!zzz")
    assert res2 is None

def test_part_stream_parsing():
    res = to_action(part_stream_command, "!part other_stream")
    assert res == PartStreamAction(test_stream, test_user, ChannelName("other_stream"))
    res2 = to_action(part_stream_command, "!zzz")
    assert res2 is None

def test_add_quote_parsing():
    res = to_action(add_quote_command, "!addQuote hi")
    assert res == AddQuoteAction(test_stream, test_user, "hi")
    res2 = to_action(add_quote_command, "!zzz")
    assert res2 is None

def test_get_quote_parsing():
    res = to_action(get_quote_command, "!quote 5")
    assert res == GetExactQuoteAction(test_stream, test_user, 5)

    res2 = to_action(get_quote_command, "!quote")
    assert res2 == GetRandomQuoteAction(test_stream, test_user)

    res3 = to_action(get_quote_command, "!quotezzz")
    assert res3 is None

def test_delete_quote_parsing():
    res = to_action(del_quote_command, "!delQuote 5")
    assert res == DelQuoteAction(test_stream, test_user, 5)

    res2 = to_action(get_quote_command, "!quotezzz")
    assert res2 is None

def test_commands_work_case_insensitive():
    res = to_action(del_quote_command, "!delQuote 4")
    assert res == DelQuoteAction(test_stream, test_user, 4)

    res2 = to_action(del_quote_command, "!delquote 5")
    assert res2 == DelQuoteAction(test_stream, test_user, 5)

    res3 = to_action(del_quote_command, "!dElQuOtE 6")
    assert res3 == DelQuoteAction(test_stream, test_user, 6)

def test_score_parsing():
    res = to_action(score_command, "!score")
    assert res == GetScoreAction(test_stream, test_user)

    res = to_action(score_command, "!score 1 2")
    assert res == SetScoreAction(test_stream, test_user, 1, 2)

    res = to_action(score_command, "!score daut 1 viper 2")
    assert res == SetAllScoreAction(test_stream, test_user, "daut", 1, "viper", 2)

# NOTE: could test the responses here as well. but for me its enough to see that stuff is in the db.
def test_score_command(db_api):
    process_message(db_api, mk_message("!join test_stream", user="artofthetroll", tags=mod_tags))
    process_message(db_api, mk_message("!score 1 5", tags=mod_tags))
    expected_score = Score(channel="test_stream", player1=None, player2=None, player1_score=1, player2_score=5)
    assert expected_score == db_api.scores.get_score(test_stream)
