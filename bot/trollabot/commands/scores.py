from dataclasses import dataclass
from typing import Optional

from parsy import Parser, success, seq, alt

from bot.trollabot.commands.base.action import Action
from bot.trollabot.commands.base.bot_command import BotCommand, buildCommand
from bot.trollabot.commands.base.parsing import token, int_parser, name_parser
from bot.trollabot.commands.base.permission import Permission
from bot.trollabot.commands.base.response import RespondWithResponse, Response
from app.trollabot.database import DB_API
from app.trollabot.channelname import ChannelName

@dataclass
class GetScoreAction(Action):
    @property
    def permission(self) -> Permission:
        return Permission.ANYONE

    def run(self, db_api: DB_API) -> Response:
        print(f"Getting score")
        score = db_api.scores.get_score(self.channel_name)
        return RespondWithResponse(self.channel_name, score.to_irc())

@dataclass
class SetScoreAction(Action):
    p1_score: int
    p2_score: int

    @property
    def permission(self) -> Permission:
        return Permission.MOD

    def __repr__(self) -> str:
        return f"<SetScoreAction(p1_score={self.p1_score}, p2_score={self.p2_score})>"

    def run(self, db_api: DB_API) -> Response:
        print(f"Setting score: {self}")
        score = db_api.scores.upsert_score(self.channel_name, self.p1_score, self.p2_score)
        return RespondWithResponse(self.channel_name, score.to_irc())

@dataclass
class SetAllScoreAction(Action):
    p1: str
    p1_score: int
    p2: str
    p2_score: int

    @property
    def permission(self) -> Permission:
        return Permission.MOD

    def __repr__(self) -> str:
        return f"<SetAllScoreAction(p1='{self.p1}', p1_score={self.p1_score}, " \
               f"p2='{self.p2}', p2_score={self.p2_score})>"

    def run(self, db_api: DB_API) -> Response:
        print(f"Setting score: {self}")
        score = db_api.scores.upsert_score_all(self.channel_name, self.p1, self.p1_score,
                                               self.p2, self.p2_score)
        return RespondWithResponse(self.channel_name, score.to_irc())

class ScoreParseResult:
    pass

class GetScoreParseResult(ScoreParseResult):
    pass

@dataclass
class SetScoreParseResult(ScoreParseResult):
    p1_score: int
    p2_score: int

    def __repr__(self) -> str:
        return f"<SetScoreParseResult(p1_score='{self.p1_score}', p2_score={self.p2_score})>"

@dataclass
class SetAllScoreParseResult(ScoreParseResult):
    p1: str
    p1_score: int
    p2: str
    p2_score: int

# Parser for getting the score (empty input)
get_score_parser: Parser = success(GetScoreParseResult())

# Parser for setting the score with two integers
set_score_parser: Parser = seq(token(int_parser), int_parser).map(lambda x: SetScoreParseResult(x[0], x[1]))

# Parser for setting the score with two names and two integers
set_all_parser: Parser = (seq(token(name_parser), token(int_parser), token(name_parser), int_parser)
                          .map(lambda x: SetAllScoreParseResult(x[0], x[1], x[2], x[3])))

# Full command parser
score_command_parser = alt(set_score_parser, set_all_parser, get_score_parser)

def score_body(channel_name: ChannelName, username: str, res: ScoreParseResult) -> Optional[Action]:
    if isinstance(res, GetScoreParseResult):
        return GetScoreAction(channel_name, username)
    elif isinstance(res, SetScoreParseResult):
        return SetScoreAction(channel_name, username, res.p1_score, res.p2_score)
    elif isinstance(res, SetAllScoreParseResult):
        return SetAllScoreAction(channel_name, username, res.p1, res.p1_score, res.p2, res.p2_score)
    else:
        return None

get_score_help: str = "1. To get the score: !score"
set_score_only_help: str = "2. To set the score without setting player names use: !score <p1Score: number> <p2Score: number>. Example: !score 4 0"
set_players_and_score_help: str = "3. To set the score AND the players use !score <p1: name> <p1Score: number> <p2: name> <p2Score: number>. Example: !score daut 4 viper 0"
score_command_help: str = get_score_help + ", " + set_score_only_help + ", " + set_players_and_score_help

score_command: BotCommand = buildCommand("score", score_command_parser, score_body, score_command_help)

###
# ALL SCORE COMMANDS
###
score_commands: list[BotCommand] = [
    score_command
]
