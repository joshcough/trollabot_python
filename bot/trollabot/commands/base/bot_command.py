from abc import ABC
from dataclasses import dataclass
from typing import Any
from typing import Callable, Optional

from parsy import Parser as ParsyParser, ParseError, Parser

from app.trollabot.channelname import ChannelName
from bot.trollabot.commands import Action
from bot.trollabot.commands.base.parsing import build_parser
from bot.trollabot.messages import Message

@dataclass
class BotCommand(ABC):
    name: str
    parser: ParsyParser
    body: Callable[[ChannelName, str, Optional[Any]], Action]
    help: str

    def to_action(self, message: Message) -> Optional[Action]:
        try:
            parsed_data = self.parser.parse(message.text)
            print(f"Message: {message.text}", "Parsed result:", parsed_data)
        except ParseError as e:
            # print(f"parse error: {e}")
            return None
        return self.body(message.channel_name, message.username, parsed_data)

def buildCommand(name: str, args_parser: Parser, body, help: str) -> BotCommand:
    return BotCommand(name, build_parser(name, args_parser), body, help)

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
