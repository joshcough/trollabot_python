from typing import Optional

from app.trollabot.channelname import ChannelName
from app.trollabot.database.scores import Score
from bot.trollabot.commands import process_message, Response
from bot.trollabot.commands.base.response import RespondWithResponse, JoinResponse
from bot.trollabot.commands.quotes import del_quote_command, DelQuoteAction
from bot.trollabot.commands.scores import score_command, GetScoreAction, SetScoreAction, SetAllScoreAction
from bot.trollabot.commands.streams import join_stream_command, part_stream_command, JoinStreamAction, PartStreamAction
from bot.trollabot.commands.user_commands import parse_user_command_body, TextNode, VarNode
from tests.bot.helpers import to_action, test_stream, test_user, mk_god_message, mk_non_mod_message, mk_mod_message

def test_join_stream_parsing():
    res = to_action(join_stream_command, "!join other_stream")
    assert res == JoinStreamAction(test_stream, test_user, ChannelName("other_stream"))
    res2 = to_action(join_stream_command, "!zzz")
    assert res2 is None

def test_join_stream(db_api):
    res = process_message(db_api, mk_god_message("!join other_stream"))
    assert res == JoinResponse(channel_to_join=ChannelName(value='other_stream'))

def test_part_stream_parsing():
    res = to_action(part_stream_command, "!part other_stream")
    assert res == PartStreamAction(test_stream, test_user, ChannelName("other_stream"))
    res2 = to_action(part_stream_command, "!zzz")
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
    process_message(db_api, mk_god_message("!join test_stream"))
    process_message(db_api, mk_mod_message("!score 1 5"))
    expected_score = Score(channel="test_stream", player1=None, player2=None, player1_score=1, player2_score=5)
    assert expected_score == db_api.scores.get_score(test_stream)

def test_help_command(db_api):
    response = process_message(db_api, mk_non_mod_message("!help !addQuote"))
    assert response == RespondWithResponse(test_stream, "!addQuote <text>")
    response2 = process_message(db_api, mk_non_mod_message("!help !help"))
    assert response2 == RespondWithResponse(test_stream, "!help <command_name>. Examples: !help score, or !help !score")

    response = process_message(db_api, mk_non_mod_message("!help addQuote"))
    assert response == RespondWithResponse(test_stream, "!addQuote <text>")
    response2 = process_message(db_api, mk_non_mod_message("!help help"))
    assert response2 == RespondWithResponse(test_stream, "!help <command_name>. Examples: !help score, or !help !score")

def test_commands_command(db_api):
    response = process_message(db_api, mk_non_mod_message("!commands"))
    expected = "!join, !part, !print_streams, !quote, !addQuote, !delQuote, !score, !count, !addCounter, !deleteCounter, !incCounter, !addc, !delc, !help, !commands"
    assert response == RespondWithResponse(test_stream, expected)

def test_counter_commands(db_api):
    process_message(db_api, mk_mod_message("!addCounter c"))
    process_message(db_api, mk_mod_message("!incCounter c"))
    process_message(db_api, mk_mod_message("!incCounter c"))
    assert db_api.counters.get_counter(test_stream, "c").count == 2

    response = process_message(db_api, mk_non_mod_message("!count c"))
    assert response == RespondWithResponse(test_stream, "c: 2")

    process_message(db_api, mk_mod_message("!deleteCounter c"))
    assert db_api.counters.get_counter(test_stream, "c") == None

def test_user_commands(db_api):
    process_message(db_api, mk_god_message("!join test_stream"))

    res1 = process_message(db_api, mk_non_mod_message("!housed"))
    assert res1 == None

    res2 = process_message(db_api, mk_mod_message("!addc housed has been housed ${housed} times"))
    cmd = db_api.user_commands.get_user_command(test_stream, "housed")
    assert res2 == RespondWithResponse(test_stream, msg='housed: has been housed ${housed} times')
    assert cmd.body == "has been housed ${housed} times"

    res3: Optional[Response] = process_message(db_api, mk_non_mod_message("!housed"))
    assert res3 == RespondWithResponse(test_stream, "has been housed 1 times")

def test_user_commands_body_parsing():
    input_string = "Hello ${user}, your balance is ${balance} dollars."
    parsed_nodes = parse_user_command_body(input_string)
    assert parsed_nodes == [TextNode("Hello "), VarNode("user"), TextNode(", your balance is "), VarNode("balance"),
                            TextNode(" dollars.")]
