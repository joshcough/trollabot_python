import re
from abc import ABC
from dataclasses import dataclass
from enum import Enum
from re import Match as ReMatch, Pattern
from typing import Callable, Optional

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
class BotCommand(ABC):
    name: str
    pattern: Pattern
    body: Callable[[ChannelName, str, ReMatch], Action]

    def to_action(self, message: Message) -> Optional[Action]:
        match = self.pattern.match(message.text)
        return self.body(message.channel_name, message.username, match) if match is not None else None

name_pattern = "([A-Za-z][A-Za-z0-9_]*)"

def build_pattern(command: str, pattern: str) -> Pattern:
    return re.compile(f"^!{command}(?:\\s+)?{pattern}$", re.IGNORECASE)

def buildCommand(name: str, pat: str, body) -> BotCommand:
    full_pattern: Pattern = build_pattern(name, pat)
    return BotCommand(f"!{name}", full_pattern, body)

###
# JOIN STREAM CODE
###
def join_stream(channel_name: ChannelName, username: str, match: ReMatch) -> Action:
    stream_to_join = match.group(1)
    return JoinStreamAction(channel_name, username, ChannelName(stream_to_join))

join_stream_command: BotCommand = buildCommand("join", name_pattern, join_stream)

###
# PART STREAM CODE
###
def part_stream(channel_name: ChannelName, username: str, match: ReMatch) -> Action:
    stream_to_part = match.group(1)
    return PartStreamAction(channel_name, username, ChannelName(stream_to_part))

part_stream_command: BotCommand = buildCommand("part", name_pattern, part_stream)

###
# PRINT STREAMS CODE
###
def print_streams(channel_name: ChannelName, username: str, match: ReMatch) -> Action:
    return PrintStreamsAction(channel_name, username)

print_streams_command: BotCommand = buildCommand("print_streams", "", print_streams)

###
# GET QUOTE CODE
###
def get_quote(channel_name: ChannelName, username: str, match: ReMatch) -> Action:
    qid = match.group(1)
    if qid:
        return GetExactQuoteAction(channel_name, username, int(qid))
    else:
        return GetRandomQuoteAction(channel_name, username)

get_quote_command: BotCommand = buildCommand("quote", r"(\d+)?", get_quote)

###
# ADD QUOTE CODE
###
def add_quote(channel_name: ChannelName, username: str, match: ReMatch) -> Action:
    quote_text = match.group(1)
    return AddQuoteAction(channel_name, username, quote_text)

add_quote_command: BotCommand = buildCommand("addQuote", "(.+)", add_quote)

###
# DELETE QUOTE CODE
###
def del_quote(channel_name: ChannelName, username: str, match: ReMatch) -> Action:
    qid = match.group(1)
    return DelQuoteAction(channel_name, username, int(qid))

del_quote_command: BotCommand = buildCommand("delQuote", "(\\d+)", del_quote)

###
# ADD COUNTER CODE
###
def add_counter(channel_name: ChannelName, username: str, match: ReMatch) -> Action:
    counter_name = match.group(1)
    return AddCounterAction(channel_name, username, counter_name)

add_counter_command: BotCommand = buildCommand("addCounter", name_pattern, add_counter)

###
# INC COUNTER CODE
###
def inc_counter(channel_name: ChannelName, username: str, match: ReMatch) -> Action:
    counter_name = match.group(1)
    return IncCounterAction(channel_name, username, counter_name)

inc_counter_command: BotCommand = buildCommand("incCounter", name_pattern, inc_counter)

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
    # TODO: search quotes
    # addCounterCommand, incCounterCommand
    # score, player, opponent
    # help, buildInfo
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
