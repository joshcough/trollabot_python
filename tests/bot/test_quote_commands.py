from bot.trollabot.commands import Permission
from bot.trollabot.commands.quotes import add_quote_command, AddQuoteAction, get_quote_command, GetExactQuoteAction, \
    del_quote_command, GetRandomQuoteAction, DelQuoteAction, SearchQuotesAction
from tests.bot.helpers import to_action, test_user

def test_add_quote_parsing(test_stream):
    res = to_action(add_quote_command, "!addQuote hi", stream=test_stream.channel)
    assert res == AddQuoteAction(test_stream.channel, test_user, "hi")
    res2 = to_action(add_quote_command, "!zzz")
    assert res2 is None

def test_get_quote_parsing(test_stream):
    res = to_action(get_quote_command, "!quote 5", stream=test_stream.channel)
    assert res == GetExactQuoteAction(test_stream.channel, test_user, 5)

    res2 = to_action(get_quote_command, "!quote", stream=test_stream.channel)
    assert res2 == GetRandomQuoteAction(test_stream.channel, test_user)

    res3 = to_action(get_quote_command, "!quote zzz", stream=test_stream.channel)
    assert res3 == SearchQuotesAction(test_stream.channel, test_user, "zzz")

def test_delete_quote_parsing(test_stream):
    res = to_action(del_quote_command, "!delQuote 5", stream=test_stream.channel)
    assert res == DelQuoteAction(test_stream.channel, test_user, 5)

def test_quote_commands(test_stream):
    test_stream.send("!addQuote hi there", Permission.MOD)
    test_stream.send("!addQuote bye", Permission.MOD)
    test_stream.send("!addQuote hiya karate chop", Permission.MOD)

    res = test_stream.send("!quote hi", Permission.ANYONE).msg
    assert res == 'Quote 1: hi there' or res == 'Quote 3: hiya karate chop'
