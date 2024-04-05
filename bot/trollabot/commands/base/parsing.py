from parsy import regex, Parser, digit

from app.trollabot.channelname import ChannelName

def case_insensitive_str(s):
    return regex(f"(?i){s}")

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
