from app.trollabot.database.scores import Score
from bot.trollabot.commands import Permission
from bot.trollabot.commands.scores import score_command, GetScoreAction, SetScoreAction, SetAllScoreAction
from tests.bot.helpers import to_action, test_user

def test_score_parsing(test_stream):
    res = to_action(score_command, "!score", stream=test_stream.channel)
    assert res == GetScoreAction(test_stream.channel, test_user)

    res = to_action(score_command, "!score 1 2", stream=test_stream.channel)
    assert res == SetScoreAction(test_stream.channel, test_user, 1, 2)

    res = to_action(score_command, "!score daut 1 viper 2", stream=test_stream.channel)
    assert res == SetAllScoreAction(test_stream.channel, test_user, "daut", 1, "viper", 2)

# NOTE: could test the responses here as well. but for me its enough to see that stuff is in the db.
def test_score_command(db_api, test_stream):
    test_stream.send("!score 1 5", Permission.MOD)
    expected_score = Score.empty_score(test_stream.channel)
    expected_score.player1_score = 1
    expected_score.player2_score = 5
    assert expected_score == db_api.scores.get_score(test_stream.channel)

def test_player_and_opponent_commands(db_api, test_stream):
    expected_score = Score.empty_score(test_stream.channel)
    expected_score.player1 = "trollaboy"
    test_stream.send("!player trollaboy", perm=Permission.MOD)
    assert expected_score == db_api.scores.get_score(test_stream.channel)

    expected_score.player2 = "daut"
    test_stream.send("!opponent daut", perm=Permission.MOD)
    assert expected_score == db_api.scores.get_score(test_stream.channel)

    expected_score.player1_score = 4
    expected_score.player2_score = 1
    test_stream.send("!score 4 1", perm=Permission.MOD)
    assert expected_score == db_api.scores.get_score(test_stream.channel)
