from bot.trollabot.commands import Permission
from bot.trollabot.commands.base.response import RespondWithResponse

def test_counter_commands(db_api, test_stream):
    test_stream.send("!addCounter c", Permission.MOD)
    test_stream.send("!incCounter c", Permission.MOD)
    test_stream.send("!incCounter c", Permission.MOD)
    assert db_api.counters.get_counter(test_stream.channel, "c").count == 2

    response = test_stream.send("!count c", Permission.ANYONE)
    assert response == RespondWithResponse(test_stream.channel, "c: 2")

    test_stream.send("!deleteCounter c", Permission.MOD)
    assert db_api.counters.get_counter(test_stream.channel, "c") == None
