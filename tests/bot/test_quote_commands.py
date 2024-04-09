from bot.trollabot.commands import process_message
from bot.trollabot.commands.quotes import add_quote_command, AddQuoteAction, get_quote_command, GetExactQuoteAction, \
    del_quote_command, GetRandomQuoteAction, DelQuoteAction, SearchQuotesAction
from tests.bot.helpers import to_action, test_stream, test_user, mk_god_message, mk_mod_message, mk_non_mod_message

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

    res3 = to_action(get_quote_command, "!quote zzz")
    assert res3 == SearchQuotesAction(test_stream, test_user, "zzz")

def test_delete_quote_parsing():
    res = to_action(del_quote_command, "!delQuote 5")
    assert res == DelQuoteAction(test_stream, test_user, 5)

def test_quote_commands(db_api):
    process_message(db_api, mk_god_message("!join test_stream"))
    process_message(db_api, mk_mod_message("!addQuote hi there"))
    process_message(db_api, mk_mod_message("!addQuote bye"))
    process_message(db_api, mk_mod_message("!addQuote hiya karate chop"))

    res = process_message(db_api, mk_non_mod_message("!quote hi")).msg
    assert res == 'Quote 1: hi there' or res == 'Quote 3: hiya karate chop'
