from abc import ABC
from app.trollabot.database import DB_API
from dataclasses import dataclass
import re
from re import Match as ReMatch, Pattern
from typing import Callable

from app.trollabot.messages import Message, ChannelName

@dataclass
class Action:
    channel_name: ChannelName
    username: str

@dataclass
class StreamsAction(Action):
    pass

@dataclass
class JoinStreamAction(StreamsAction):
    channel_to_join: ChannelName

@dataclass
class PartStreamAction(StreamsAction):
    channel_to_part: ChannelName

@dataclass
class QuoteAction(Action):
    pass

@dataclass
class GetExactQuoteAction(QuoteAction):
    qid: int

@dataclass
class GetRandomQuoteAction(QuoteAction):
    pass

@dataclass
class AddQuoteAction(QuoteAction):
    text: str

@dataclass
class DelQuoteAction(QuoteAction):
    qid: int

@dataclass
class BotCommand(ABC):
    pattern: Pattern
    body: Callable[[ChannelName, str, ReMatch], Action]

    def to_action(self, message: Message):
        match = self.pattern.match(message.text)
        if match:
            return self.body(message.channel_name, message.username, match)
        else:
            return None

###
# JOIN STREAM CODE
###
join_stream_pattern = re.compile(r"^!join\s+(.+)")

def join_stream(channel_name: ChannelName, username: str, match: ReMatch):
    stream_to_join = match.group(1)
    return JoinStreamAction(channel_name, username, stream_to_join)

join_stream_command = BotCommand(join_stream_pattern, join_stream)

###
# PART STREAM CODE
###
part_stream_pattern = re.compile(r"^!part\s+(.+)")

def part_stream(channel_name: ChannelName, username: str, match: ReMatch):
    stream_to_part = match.group(1)
    return PartStreamAction(channel_name, username, stream_to_part)

part_stream_command = BotCommand(part_stream_pattern, part_stream)

###
# GET QUOTE CODE
###
get_quote_pattern = re.compile(r"^!quote(?:\s+(\d+))?$")

def get_quote(channel_name: ChannelName, username: str, match: ReMatch):
    qid = match.group(1)
    if qid:
        return GetExactQuoteAction(channel_name, username, int(qid))
    else:
        return GetRandomQuoteAction(channel_name, username)

get_quote_command = BotCommand(get_quote_pattern, get_quote)

###
# ADD QUOTE CODE
###
add_quote_pattern = re.compile(r"^!addQuote\s+(.+)")

def add_quote(channel_name: ChannelName, username: str, match: ReMatch):
    quote_text = match.group(1)
    return AddQuoteAction(channel_name, username, quote_text)

add_quote_command = BotCommand(add_quote_pattern, add_quote)

###
# DELETE QUOTE CODE
###
del_quote_pattern = re.compile(r"^!delQuote\s+(\d+)$")

def del_quote(channel_name: ChannelName, username: str, match: ReMatch):
    qid = match.group(1)
    return DelQuoteAction(channel_name, username, int(qid))

del_quote_command = BotCommand(del_quote_pattern, del_quote)

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

def run_action(db_api: DB_API, action: Action):
    if isinstance(action, JoinStreamAction):
        print(f"Joining {action.channel_to_join}")
        db_api.streams.join(action.channel_to_join, action.username)
        return JoinResponse(action.channel_to_join)
    elif isinstance(action, PartStreamAction):
        print(f"Parting {action.channel_to_part}")
        db_api.streams.part(action.channel_to_part)
        return PartResponse(action.channel_to_part)
    elif isinstance(action, GetExactQuoteAction):
        print(f"Getting exact quote {action.qid}")
        quote = db_api.quotes.get_quote(action.channel_name, action.qid)
        return RespondWithResponse(action.channel_name, f"Quote {quote.qid}: {quote.text}")
    elif isinstance(action, GetRandomQuoteAction):
        print("Getting random quote")
        quote = db_api.quotes.get_random_quote(action.channel_name)
        return RespondWithResponse(action.channel_name, f"Quote {quote.qid}: {quote.text}")
    elif isinstance(action, AddQuoteAction):
        print(f"Adding quote: {action.text}")
        quote = db_api.quotes.insert_quote(action.channel_name, action.username, action.text)
        return RespondWithResponse(action.channel_name, f"Added quote {quote.qid}: {quote.text}")
    elif isinstance(action, DelQuoteAction):
        print(f"Deleting quote {action.qid}")
        db_api.quotes.delete_quote(action.channel_name, action.username, action.qid)
        return RespondWithResponse(action.channel_name, f"Deleted quote {action.qid}")
    else:
        print("Unknown action")

###
# ALL COMMANDS
###
commands = [
    join_stream_command,
    part_stream_command,
    get_quote_command,
    add_quote_command,
    del_quote_command
]

def process_message(db_api: DB_API, msg: Message) -> Response:
    for command in commands:
        action = command.to_action(msg)
        print(f"action for {command}: {action}")
        if action is not None:
            return run_action(db_api, action)
