from dataclasses import dataclass

from parsy import success

from app.trollabot.commands.base.action import Action
from app.trollabot.commands.base.bot_command import BotCommand, buildCommand
from app.trollabot.commands.base.parsing import channel_name_parser
from app.trollabot.commands.base.permission import Permission
from app.trollabot.commands.base.response import RespondWithResponse, Response, JoinResponse, PartResponse
from app.trollabot.database import DB_API
from app.trollabot.messages import ChannelName

@dataclass
class StreamsAction(Action):
    pass

@dataclass
class JoinStreamAction(StreamsAction):
    channel_to_join: ChannelName

    @property
    def permission(self) -> Permission:
        return Permission.GOD

    def run(self, db_api: DB_API) -> Response:
        print(f"Joining {self.channel_to_join}")
        db_api.streams.join(self.channel_to_join, self.username)
        return JoinResponse(self.channel_to_join)

@dataclass
class PartStreamAction(StreamsAction):
    channel_to_part: ChannelName

    @property
    def permission(self) -> Permission:
        return Permission.STREAMER

    def run(self, db_api: DB_API) -> Response:
        print(f"Parting {self.channel_to_part}")
        db_api.streams.part(self.channel_to_part)
        return PartResponse(self.channel_to_part)

@dataclass
class PrintStreamsAction(StreamsAction):
    @property
    def permission(self) -> Permission:
        return Permission.GOD

    def run(self, db_api: DB_API) -> Response:
        print(f"Getting streams")
        streams = db_api.streams.get_joined_streams()
        return RespondWithResponse(self.channel_name, ", ".join(list(map(lambda x: x.name, streams))))

###
# JOIN STREAM CODE
###
def join_stream(channel_name: ChannelName, username: str, channel_to_join: ChannelName) -> Action:
    return JoinStreamAction(channel_name, username, channel_to_join)

join_help: str = "!join <stream>"

join_stream_command: BotCommand = buildCommand("join", channel_name_parser, join_stream, join_help)

###
# PART STREAM CODE
###
def part_stream(channel_name: ChannelName, username: str, channel_to_join: ChannelName) -> Action:
    return PartStreamAction(channel_name, username, channel_to_join)

part_help: str = "!part <stream>"

part_stream_command: BotCommand = buildCommand("part", channel_name_parser, part_stream, part_help)

###
# PRINT STREAMS CODE
###
def print_streams(channel_name: ChannelName, username: str, _: None) -> Action:
    return PrintStreamsAction(channel_name, username)

print_streams_help: str = "!print_streams"

print_streams_command: BotCommand = buildCommand("print_streams", success(None), print_streams, print_streams_help)

###
# ALL STREAM COMMANDS
###
stream_commands: list[BotCommand] = [
    join_stream_command,
    part_stream_command,
    print_streams_command,
]
