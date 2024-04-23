from dataclasses import dataclass

from parsy import any_char, Parser, success

from app.trollabot.channelname import ChannelName
from app.trollabot.database import DB_API
from app.trollabot.loggo import get_logger
from bot.trollabot.commands.base.action import Action
from bot.trollabot.commands.base.bot_command import BotCommand, buildCommand
from bot.trollabot.commands.base.parsing import int_parser
from bot.trollabot.commands.base.permission import Permission
from bot.trollabot.commands.base.response import Response, RespondWithResponse

logger = get_logger(__name__)

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
        logger.debug(f"Getting exact quote {self.qid}")
        quote = db_api.quotes.get_quote(self.channel_name, self.qid)
        return RespondWithResponse(self.channel_name,
                                   f"Quote {quote.qid}: {quote.text}") if quote is not None else None

@dataclass
class GetRandomQuoteAction(QuoteAction):
    @property
    def permission(self):
        return Permission.ANYONE

    def run(self, db_api: DB_API) -> Response:
        logger.debug("Getting random quote")
        quote = db_api.quotes.get_random_quote(self.channel_name)
        return RespondWithResponse(self.channel_name,
                                   f"Quote {quote.qid}: {quote.text}") if quote is not None else None

@dataclass
class SearchQuotesAction(QuoteAction):
    search_str: str

    @property
    def permission(self) -> Permission:
        return Permission.ANYONE

    def run(self, db_api: DB_API) -> Response:
        logger.debug(f"Searching quotes for {self.search_str}")
        quote = db_api.quotes.search_quotes(self.channel_name, self.search_str)
        return RespondWithResponse(self.channel_name,
                                   f"Quote {quote.qid}: {quote.text}") if quote is not None else None

@dataclass
class AddQuoteAction(QuoteAction):
    text: str

    @property
    def permission(self) -> Permission:
        return Permission.MOD

    def run(self, db_api: DB_API) -> Response:
        logger.debug(f"Adding quote: {self.text}")
        quote = db_api.quotes.insert_quote(self.channel_name, self.username, self.text)
        return RespondWithResponse(self.channel_name, f"Added quote {quote.qid}: {quote.text}")

@dataclass
class DelQuoteAction(QuoteAction):
    qid: int

    @property
    def permission(self) -> Permission:
        return Permission.MOD

    def run(self, db_api: DB_API) -> Response:
        logger.debug(f"Deleting quote {self.qid}")
        db_api.quotes.delete_quote(self.channel_name, self.qid, self.username)
        return RespondWithResponse(self.channel_name, f"Deleted quote {self.qid}")

###
# GET QUOTE CODE
###
class GetQuoteParseResult:
    pass

class GetRandomQuoteParseResult(GetQuoteParseResult):
    pass

@dataclass
class GetQuoteByIdParseResult(GetQuoteParseResult):
    qid: int

    def __repr__(self) -> str:
        return f"<GetQuoteByIdParseResult(qid={self.qid})>"

@dataclass
class SearchQuotesParseResult(GetQuoteParseResult):
    search_str: str

    def __repr__(self) -> str:
        return f"<SearchQuoteParseResult(qid='{self.search_str}')>"

get_random_quote_parser: Parser = success(GetRandomQuoteParseResult())

get_quote_by_id_parser: Parser = int_parser.map(lambda x: GetQuoteByIdParseResult(x))

search_quotes_parser: Parser = any_char.at_least(1).concat().map(lambda x: SearchQuotesParseResult(x))

get_quote_parser = get_quote_by_id_parser | search_quotes_parser | get_random_quote_parser

def get_quote(channel_name: ChannelName, username: str, res: GetQuoteParseResult) -> Action:
    if isinstance(res, GetRandomQuoteParseResult):
        return GetRandomQuoteAction(channel_name, username)
    elif isinstance(res, GetQuoteByIdParseResult):
        return GetExactQuoteAction(channel_name, username, res.qid)
    elif isinstance(res, SearchQuotesParseResult):
        return SearchQuotesAction(channel_name, username, res.search_str)

get_quote_help = "For a random quote: !quote. For a specific quote: !quote <number>. To search quotes: !quote <text>"

get_quote_command: BotCommand = buildCommand("quote", get_quote_parser, get_quote, get_quote_help)

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
