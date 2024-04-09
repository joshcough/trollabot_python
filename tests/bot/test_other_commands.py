from app.trollabot.channelname import ChannelName
from bot.trollabot.commands import Permission
from bot.trollabot.commands.base.response import RespondWithResponse, JoinResponse
from bot.trollabot.commands.quotes import del_quote_command, DelQuoteAction
from bot.trollabot.commands.streams import join_stream_command, part_stream_command, JoinStreamAction, PartStreamAction
from tests.bot.conftest import next_stream_name
from tests.bot.helpers import to_action, test_user

def test_join_stream_parsing(test_stream):
    res = to_action(join_stream_command, "!join other_stream", test_stream.channel)
    assert res == JoinStreamAction(test_stream.channel, test_user, ChannelName("other_stream"))
    res2 = to_action(join_stream_command, "!zzz")
    assert res2 is None

def test_join_stream(db_api, test_stream):
    res = test_stream.send("!join other_stream", Permission.GOD)
    assert res == JoinResponse(channel_to_join=ChannelName(value='other_stream'))

def test_part_stream_parsing():
    stream: ChannelName = next_stream_name()
    res = to_action(part_stream_command, "!part other_stream", stream=stream)
    assert res == PartStreamAction(stream, test_user, ChannelName("other_stream"))
    res2 = to_action(part_stream_command, "!zzz", stream=stream)
    assert res2 is None

def test_commands_work_case_insensitive():
    stream: ChannelName = next_stream_name()
    res = to_action(del_quote_command, "!delQuote 4", stream=stream)
    assert res == DelQuoteAction(stream, test_user, 4)

    res2 = to_action(del_quote_command, "!delquote 5", stream=stream)
    assert res2 == DelQuoteAction(stream, test_user, 5)

    res3 = to_action(del_quote_command, "!dElQuOtE 6", stream=stream)
    assert res3 == DelQuoteAction(stream, test_user, 6)

def test_help_command(db_api, test_stream):
    response = test_stream.send("!help !addQuote", Permission.ANYONE)
    assert response == RespondWithResponse(test_stream.channel, "!addQuote <text>")
    response2 = test_stream.send("!help !help", Permission.ANYONE)
    assert response2 == RespondWithResponse(test_stream.channel,
                                            "!help <command_name>. Examples: !help score, or !help !score")

    response = test_stream.send("!help addQuote", Permission.ANYONE)
    assert response == RespondWithResponse(test_stream.channel, "!addQuote <text>")
    response2 = test_stream.send("!help help", Permission.ANYONE)
    assert response2 == RespondWithResponse(test_stream.channel,
                                            "!help <command_name>. Examples: !help score, or !help !score")

def test_commands_command(db_api, test_stream):
    response = test_stream.send("!commands", Permission.ANYONE)
    expected = "!join, !part, !print_streams, !quote, !addQuote, !delQuote, !score, !player, !opponent, !count, !addCounter, !deleteCounter, !incCounter, !addc, !delc, !help, !commands"
    assert response == RespondWithResponse(test_stream.channel, expected)
