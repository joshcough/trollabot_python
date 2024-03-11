from abc import ABC
from dataclasses import dataclass
from enum import Enum
from typing import Any
from typing import Callable, Optional

from parsy import Parser as ParsyParser, regex, Parser, success, digit, seq, any_char, ParseError, \
    alt

from app.trollabot.database import DB_API
from app.trollabot.messages import Message, ChannelName

class Permission(Enum):
    GOD = (4, "God")
    STREAMER = (3, "Streamer")
    MOD = (2, "Mod")
    ANYONE = (1, "Anyone")

    def __gt__(self, other):
        if self.__class__ is other.__class__:
            return self.value[0] > other.value[0]
        return NotImplemented

    def __ge__(self, other):
        if self.__class__ is other.__class__:
            return self.value[0] >= other.value[0]
        return NotImplemented

    @property
    def label(self) -> str:
        return self.value[1]

@dataclass
class Action:
    channel_name: ChannelName
    username: str

    @property
    def permission(self) -> Permission:
        # TODO: maybe we should raise an error here if a subclass does not override
        return Permission.GOD

@dataclass
class StreamsAction(Action):
    pass

@dataclass
class JoinStreamAction(StreamsAction):
    channel_to_join: ChannelName

    @property
    def permission(self) -> Permission:
        return Permission.GOD

@dataclass
class PartStreamAction(StreamsAction):
    channel_to_part: ChannelName

    @property
    def permission(self) -> Permission:
        return Permission.STREAMER

@dataclass
class PrintStreamsAction(StreamsAction):
    @property
    def permission(self) -> Permission:
        return Permission.GOD

@dataclass
class QuoteAction(Action):
    pass

@dataclass
class GetExactQuoteAction(QuoteAction):
    qid: int

    @property
    def permission(self) -> Permission:
        return Permission.ANYONE

@dataclass
class GetRandomQuoteAction(QuoteAction):
    @property
    def permission(self):
        return Permission.ANYONE

@dataclass
class AddQuoteAction(QuoteAction):
    text: str

    @property
    def permission(self) -> Permission:
        return Permission.MOD

@dataclass
class DelQuoteAction(QuoteAction):
    qid: int

    @property
    def permission(self) -> Permission:
        return Permission.MOD

@dataclass
class AddCounterAction(Action):
    name: str

    @property
    def permission(self) -> Permission:
        return Permission.MOD

@dataclass
class IncCounterAction(Action):
    name: str

    @property
    def permission(self) -> Permission:
        return Permission.ANYONE

@dataclass
class GetScoreAction(Action):
    @property
    def permission(self) -> Permission:
        return Permission.ANYONE

@dataclass
class SetScoreAction(Action):
    p1_score: int
    p2_score: int

    @property
    def permission(self) -> Permission:
        return Permission.MOD

    def __repr__(self) -> str:
        return f"<SetScoreAction(p1_score={self.p1_score}, p2_score={self.p2_score})>"

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

def case_insensitive_str(s):
    return regex(f"(?i){s}")

@dataclass
class BotCommand(ABC):
    name: str
    parser: ParsyParser
    body: Callable[[ChannelName, str, Optional[Any]], Action]

    def to_action(self, message: Message) -> Optional[Action]:
        try:
            parsed_data = self.parser.parse(message.text)
            print(f"Message: {message.text}", "Parsed result:", parsed_data)
        except ParseError as e:
            # print(f"parse error: {e}")
            return None
        return self.body(message.channel_name, message.username, parsed_data)

int_parser: Parser = digit.at_least(1).concat().map(int)
name_parser: Parser = regex("([A-Za-z][A-Za-z0-9_]*)")
channel_name_parser: Parser = name_parser.map(ChannelName)

def token(parser) -> Parser:
    return parser << regex(r"\s+")

def build_parser(command: str, args_parser) -> Parser:
    # Matches the "!" followed by the command name (case insensitive)
    command_prefix = case_insensitive_str(f"!{command}")

    # Matches optional whitespace
    optional_whitespace = regex(r"\s*")

    # Combine the parts into a larger parser
    return command_prefix >> optional_whitespace >> args_parser

def buildCommand(name: str, args_parser: Parser, body) -> BotCommand:
    full_pattern: Parser = build_parser(name, args_parser)
    return BotCommand(f"!{name}", full_pattern, body)

###
# JOIN STREAM CODE
###
def join_stream(channel_name: ChannelName, username: str, channel_to_join: ChannelName) -> Action:
    return JoinStreamAction(channel_name, username, channel_to_join)

join_stream_command: BotCommand = buildCommand("join", channel_name_parser, join_stream)

###
# PART STREAM CODE
###
def part_stream(channel_name: ChannelName, username: str, channel_to_join: ChannelName) -> Action:
    return PartStreamAction(channel_name, username, channel_to_join)

part_stream_command: BotCommand = buildCommand("part", channel_name_parser, part_stream)

###
# PRINT STREAMS CODE
###
def print_streams(channel_name: ChannelName, username: str, _: None) -> Action:
    return PrintStreamsAction(channel_name, username)

print_streams_command: BotCommand = buildCommand("print_streams", success(None), print_streams)

###
# GET QUOTE CODE
###
def get_quote(channel_name: ChannelName, username: str, qid: Optional[int]) -> Action:
    if qid:
        return GetExactQuoteAction(channel_name, username, qid)
    else:
        return GetRandomQuoteAction(channel_name, username)

get_quote_command: BotCommand = buildCommand("quote", int_parser.optional(), get_quote)

###
# ADD QUOTE CODE
###
def add_quote(channel_name: ChannelName, username: str, quote_text: str) -> Action:
    return AddQuoteAction(channel_name, username, quote_text)

add_quote_command: BotCommand = buildCommand("addQuote", any_char.many().concat(), add_quote)

###
# DELETE QUOTE CODE
###
def del_quote(channel_name: ChannelName, username: str, qid: int) -> Action:
    return DelQuoteAction(channel_name, username, qid)

del_quote_command: BotCommand = buildCommand("delQuote", int_parser, del_quote)

###
# ADD COUNTER CODE
###
def add_counter(channel_name: ChannelName, username: str, counter_name: str) -> Action:
    return AddCounterAction(channel_name, username, counter_name)

add_counter_command: BotCommand = buildCommand("addCounter", name_parser, add_counter)

###
# INC COUNTER CODE
###
def inc_counter(channel_name: ChannelName, username: str, counter_name: str) -> Action:
    return IncCounterAction(channel_name, username, counter_name)

inc_counter_command: BotCommand = buildCommand("incCounter", name_parser, inc_counter)

###
# INC COUNTER CODE
###

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

score_command: BotCommand = buildCommand("score", score_command_parser, score_body)

@dataclass
class Response:
    pass

@dataclass
class RespondWithResponse(Response):
    channel_name: ChannelName
    msg: str

@dataclass
class JoinResponse(Response):
    channel_to_join: ChannelName

@dataclass
class PartResponse(Response):
    channel_to_part: ChannelName

@dataclass
class LogErrResponse(Response):
    msg: str

def run_action(db_api: DB_API, action: Action) -> Optional[Response]:
    if isinstance(action, JoinStreamAction):
        print(f"Joining {action.channel_to_join}")
        db_api.streams.join(action.channel_to_join, action.username)
        return JoinResponse(action.channel_to_join)
    elif isinstance(action, PartStreamAction):
        print(f"Parting {action.channel_to_part}")
        db_api.streams.part(action.channel_to_part)
        return PartResponse(action.channel_to_part)
    elif isinstance(action, PrintStreamsAction):
        streams = db_api.streams
        return RespondWithResponse(f"{streams}")
    elif isinstance(action, GetExactQuoteAction):
        print(f"Getting exact quote {action.qid}")
        quote = db_api.quotes.get_quote(action.channel_name, action.qid)
        return RespondWithResponse(action.channel_name,
                                   f"Quote {quote.qid}: {quote.text}") if quote is not None else None
    elif isinstance(action, GetRandomQuoteAction):
        print("Getting random quote")
        quote = db_api.quotes.get_random_quote(action.channel_name)
        return RespondWithResponse(action.channel_name,
                                   f"Quote {quote.qid}: {quote.text}") if quote is not None else None
    elif isinstance(action, AddQuoteAction):
        print(f"Adding quote: {action.text}")
        quote = db_api.quotes.insert_quote(action.channel_name, action.username, action.text)
        return RespondWithResponse(action.channel_name, f"Added quote {quote.qid}: {quote.text}")
    elif isinstance(action, DelQuoteAction):
        print(f"Deleting quote {action.qid}")
        db_api.quotes.delete_quote(action.channel_name, action.qid, action.username)
        return RespondWithResponse(action.channel_name, f"Deleted quote {action.qid}")
    elif isinstance(action, GetScoreAction):
        print(f"Getting score")
        score = db_api.scores.get_score(action.channel_name)
        return RespondWithResponse(action.channel_name, score.to_irc())
    elif isinstance(action, SetScoreAction):
        print(f"Setting score: {action}")
        score = db_api.scores.upsert_score(action.channel_name, action.p1_score, action.p2_score)
        return RespondWithResponse(action.channel_name, score.to_irc())
    elif isinstance(action, SetAllScoreAction):
        print(f"Setting score: {action}")
        score = db_api.scores.upsert_score_all(action.channel_name, action.p1, action.p1_score,
                                               action.p2, action.p2_score)
        return RespondWithResponse(action.channel_name, score.to_irc())
    else:
        print(f"Unknown action: {action}")
        return None

###
# ALL COMMANDS
###
commands = [
    join_stream_command,
    part_stream_command,
    print_streams_command,
    get_quote_command,
    add_quote_command,
    del_quote_command,
    score_command,
    # TODO: search quotes, player, opponent, help, buildInfo
    # addUserCommandCommand, editUserCommandCommand, deleteUserCommandCommand
]

def get_permission_level(msg: Message) -> Permission:
    if msg.from_god():
        return Permission.GOD
    elif msg.from_owner():
        return Permission.STREAMER
    elif msg.from_mod():
        return Permission.MOD
    else:
        return Permission.ANYONE

def process_message(db_api: DB_API, msg: Message) -> Optional[Response]:
    for command in commands:
        action: Action = command.to_action(msg)
        if action is not None:
            print(f"action for {command}: {action}")
            if get_permission_level(msg) >= action.permission:
                return run_action(db_api, action)
            else:
                errmsg = f"You don't have permission to do that. You need at least {action.permission}"
                return RespondWithResponse(msg.channel_name, errmsg)

# NOTE: maybe we can use some typed stuff like this later:
# T = TypeVar('T')
#
# class ParserT(ABC, Generic[T]):
#     def __init__(self, parser: ParsyParser):
#         self.parser = parser
#
#     def parse(self, text: str) -> Optional[T]:
#         pass
#
# @dataclass
# class BotCommand(ABC):
#     name: str
#     parser: ParserT[T]
#     body: Callable[[ChannelName, str, Optional[T]], Action]
#
#     def to_action(self, message: Message) -> Optional[Action]:
#         parsed_data = self.parser.parse(message.text)
#         return self.body(message.channel_name, message.username, parsed_data)
