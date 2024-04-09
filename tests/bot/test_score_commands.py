from app.trollabot.channelname import ChannelName
from app.trollabot.database.scores import Score
from bot.trollabot.commands import process_message
from bot.trollabot.commands.scores import score_command, GetScoreAction, SetScoreAction, SetAllScoreAction
from tests.bot.helpers import to_action, test_stream, test_user, mk_god_message, mk_mod_message

def test_score_parsing():
    res = to_action(score_command, "!score")
    assert res == GetScoreAction(test_stream, test_user)

    res = to_action(score_command, "!score 1 2")
    assert res == SetScoreAction(test_stream, test_user, 1, 2)

    res = to_action(score_command, "!score daut 1 viper 2")
    assert res == SetAllScoreAction(test_stream, test_user, "daut", 1, "viper", 2)

# NOTE: could test the responses here as well. but for me its enough to see that stuff is in the db.
def test_score_command(db_api):
    db_api.scores.session.commit()
    process_message(db_api, mk_god_message("!join test_stream"))
    process_message(db_api, mk_mod_message("!score 1 5"))
    expected_score = Score(channel="test_stream", player1=None, player2=None, player1_score=1, player2_score=5)
    assert expected_score == db_api.scores.get_score(test_stream)

def test_player_and_opponent_commands(db_api):
    process_message(db_api, mk_god_message("!join test_stream"))

    process_message(db_api, mk_mod_message("!player trollaboy", stream=test_stream))
    expected_score = Score(channel=test_stream.value, player1="trollaboy", player2=None, player1_score=0, player2_score=0)
    assert expected_score == db_api.scores.get_score(test_stream)

    process_message(db_api, mk_mod_message("!opponent daut", stream=test_stream))
    expected_score = Score(channel=test_stream.value, player1="trollaboy", player2="daut", player1_score=0, player2_score=0)
    assert expected_score == db_api.scores.get_score(test_stream)

    process_message(db_api, mk_mod_message("!score 4 1", stream=test_stream))
    expected_score = Score(channel=test_stream.value, player1="trollaboy", player2="daut", player1_score=4, player2_score=1)
    assert expected_score == db_api.scores.get_score(test_stream)
