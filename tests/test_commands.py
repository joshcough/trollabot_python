from app.trollabot.commands import add_quote_command, get_quote_command, AddQuoteAction, GetExactQuoteAction, \
    GetRandomQuoteAction, BotCommand, del_quote_command, DelQuoteAction, join_stream_command, JoinStreamAction, \
    part_stream_command, PartStreamAction
from app.trollabot.messages import Message, Tags

test_stream = "test-stream"
test_user = "test-user"

def run_command(command: BotCommand, msg: str):
    return command.to_action(Message("test-stream", "test-user", Tags([]), msg))

def test_join_stream_parsing():
    res = run_command(join_stream_command, "!join other_stream")
    assert res == JoinStreamAction(test_stream, test_user, "other_stream")
    res2 = run_command(add_quote_command, "!zzz")
    assert res2 is None

def test_part_stream_parsing():
    res = run_command(part_stream_command, "!part other_stream")
    assert res == PartStreamAction(test_stream, test_user, "other_stream")
    res2 = run_command(add_quote_command, "!zzz")
    assert res2 is None

def test_add_quote_parsing():
    res = run_command(add_quote_command, "!addQuote hi")
    assert res == AddQuoteAction(test_stream, test_user, "hi")
    res2 = run_command(add_quote_command, "!zzz")
    assert res2 is None

def test_get_quote_parsing():
    res = run_command(get_quote_command, "!quote 5")
    assert res == GetExactQuoteAction(test_stream, test_user, 5)

    res = run_command(get_quote_command, "!quote")
    assert res == GetRandomQuoteAction(test_stream, test_user)

    res = run_command(get_quote_command, "!quotezzz")
    assert res is None

def test_delete_quote_parsing():
    res = run_command(del_quote_command, "!delQuote 5")
    assert res == DelQuoteAction(test_stream, test_user, 5)

    res = run_command(get_quote_command, "!quotezzz")
    assert res is None
