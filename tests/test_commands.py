from app.trollabot.commands import process_message
from app.trollabot.commands.scores import score_command, GetScoreAction, SetScoreAction, SetAllScoreAction
from app.trollabot.commands.quotes import add_quote_command, AddQuoteAction, get_quote_command, GetExactQuoteAction, \
    del_quote_command, GetRandomQuoteAction, DelQuoteAction
from app.trollabot.commands.streams import join_stream_command, part_stream_command, JoinStreamAction, PartStreamAction
from app.trollabot.commands.base.bot_command import BotCommand
from app.trollabot.commands.base.response import RespondWithResponse
from app.trollabot.database import Score
from app.trollabot.messages import ChannelName, Tags, Message

test_stream: ChannelName = ChannelName("test_stream")
test_user = "test-user"
mod_tags = Tags([{'key': 'mod', 'value': '1'}])

def mk_message(msg: str, user: str = test_user, tags: Tags = Tags([])) -> Message:
    return Message(test_stream, user, tags, msg)

def to_action(command: BotCommand, msg: str) -> object:
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

def test_help_command(db_api):
    response = process_message(db_api, mk_message("!help !addQuote", user="artofthetroll", tags=mod_tags))
    assert response == RespondWithResponse(test_stream, "!addQuote <text>")
    response2 = process_message(db_api, mk_message("!help !help", user="artofthetroll", tags=mod_tags))
    assert response2 == RespondWithResponse(test_stream, "!help <command_name>. Examples: !help score, or !help !score")

    response = process_message(db_api, mk_message("!help addQuote", user="artofthetroll", tags=mod_tags))
    assert response == RespondWithResponse(test_stream, "!addQuote <text>")
    response2 = process_message(db_api, mk_message("!help help", user="artofthetroll", tags=mod_tags))
    assert response2 == RespondWithResponse(test_stream, "!help <command_name>. Examples: !help score, or !help !score")

def test_commands_command(db_api):
    response = process_message(db_api, mk_message("!commands", user="artofthetroll", tags=mod_tags))
    assert response == RespondWithResponse(test_stream, "!join, !part, !print_streams, !quote, !addQuote, !delQuote, !score, !count, !addCounter, !deleteCounter, !incCounter, !help, !commands")

def test_counter_commands(db_api):
    process_message(db_api, mk_message("!addCounter c", user="artofthetroll", tags=mod_tags))
    process_message(db_api, mk_message("!incCounter c", user="artofthetroll", tags=mod_tags))
    process_message(db_api, mk_message("!incCounter c", user="artofthetroll", tags=mod_tags))
    assert db_api.counters.get_counter(test_stream, "c").count == 2

    response = process_message(db_api, mk_message("!count c", user="artofthetroll", tags=mod_tags))
    assert response == RespondWithResponse(test_stream, "c: 2")

    process_message(db_api, mk_message("!deleteCounter c", user="artofthetroll", tags=mod_tags))
    assert db_api.counters.get_counter(test_stream, "c") == None
