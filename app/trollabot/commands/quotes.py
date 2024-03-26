from dataclasses import dataclass
from typing import Optional

from parsy import any_char

from app.trollabot.commands.base.action import Action
from app.trollabot.commands.base.bot_command import BotCommand, buildCommand
from app.trollabot.commands.base.parsing import int_parser
from app.trollabot.commands.base.permission import Permission
from app.trollabot.commands.base.response import Response, RespondWithResponse
from app.trollabot.database import DB_API
from app.trollabot.messages import ChannelName

@dataclass
class QuoteAction(Action):
    pass

@dataclass
class GetExactQuoteAction(QuoteAction):
    qid: int

    @property
    def permission(self) -> Permission:
        return Permission.ANYONE

    def run(self, db_api: DB_API) -> Response:
        print(f"Getting exact quote {self.qid}")
        quote = db_api.quotes.get_quote(self.channel_name, self.qid)
        return RespondWithResponse(self.channel_name,
                                   f"Quote {quote.qid}: {quote.text}") if quote is not None else None

@dataclass
class GetRandomQuoteAction(QuoteAction):
    @property
    def permission(self):
        return Permission.ANYONE

    def run(self, db_api: DB_API) -> Response:
        print("Getting random quote")
        quote = db_api.quotes.get_random_quote(self.channel_name)
        return RespondWithResponse(self.channel_name,
                                   f"Quote {quote.qid}: {quote.text}") if quote is not None else None

@dataclass
class AddQuoteAction(QuoteAction):
    text: str

    @property
    def permission(self) -> Permission:
        return Permission.MOD

    def run(self, db_api: DB_API) -> Response:
        print(f"Adding quote: {self.text}")
        quote = db_api.quotes.insert_quote(self.channel_name, self.username, self.text)
        return RespondWithResponse(self.channel_name, f"Added quote {quote.qid}: {quote.text}")

@dataclass
class DelQuoteAction(QuoteAction):
    qid: int

    @property
    def permission(self) -> Permission:
        return Permission.MOD

    def run(self, db_api: DB_API) -> Response:
        print(f"Deleting quote {self.qid}")
        db_api.quotes.delete_quote(self.channel_name, self.qid, self.username)
        return RespondWithResponse(self.channel_name, f"Deleted quote {self.qid}")

###
# GET QUOTE CODE
###
def get_quote(channel_name: ChannelName, username: str, qid: Optional[int]) -> Action:
    if qid:
        return GetExactQuoteAction(channel_name, username, qid)
    else:
        return GetRandomQuoteAction(channel_name, username)

get_quote_help = "For a random quote: !quote or for a specific quote: !quote <number>"

get_quote_command: BotCommand = buildCommand("quote", int_parser.optional(), get_quote, get_quote_help)

###
# ADD QUOTE CODE
###
def add_quote(channel_name: ChannelName, username: str, quote_text: str) -> Action:
    return AddQuoteAction(channel_name, username, quote_text)

add_quote_help: str = "!addQuote <text>"

add_quote_command: BotCommand = buildCommand("addQuote", any_char.many().concat(), add_quote, add_quote_help)

###
# DELETE QUOTE CODE
###
def del_quote(channel_name: ChannelName, username: str, qid: int) -> Action:
    return DelQuoteAction(channel_name, username, qid)

del_quote_help: str = "!delQuote <number>"

del_quote_command: BotCommand = buildCommand("delQuote", int_parser, del_quote, del_quote_help)

###
# ALL QUOTE COMMANDS
###
quote_commands: list[BotCommand] = [
    get_quote_command,
    add_quote_command,
    del_quote_command,
]
