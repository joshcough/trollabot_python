from dataclasses import dataclass
from typing import Optional

from parsy import regex, Parser, success

from app.trollabot.commands.base.action import Action
from app.trollabot.commands.base.bot_command import BotCommand, buildCommand
from app.trollabot.commands.base.parsing import channel_name_parser, int_parser, name_parser, token
from app.trollabot.commands.base.permission import Permission, get_permission_level
from app.trollabot.commands.base.response import Response, JoinResponse, PartResponse, RespondWithResponse
from app.trollabot.commands.counters import add_counter_command, inc_counter_command, delete_counter_command, \
    get_count_command, counter_commands
from app.trollabot.commands.quotes import get_quote_command, add_quote_command, del_quote_command, quote_commands
from app.trollabot.commands.scores import score_command, score_commands
from app.trollabot.commands.streams import join_stream_command, part_stream_command, print_streams_command, \
    stream_commands
from app.trollabot.database import DB_API
from app.trollabot.messages import ChannelName, Message

@dataclass
class HelpAction(Action):
    command_name: str

    @property
    def permission(self) -> Permission:
        return Permission.ANYONE

    def run(self, db_api: DB_API) -> Response:
        print(f"Getting help for: {self.command_name}")
        cmd: BotCommand = commands_dict[self.command_name]
        if cmd is not None:
            return RespondWithResponse(self.channel_name, cmd.help)
        else:
            return RespondWithResponse(self.channel_name, f"No such command: {self.command_name}")

@dataclass
class GetCommandsAction(Action):
    @property
    def permission(self) -> Permission:
        return Permission.ANYONE

    def run(self, db_api: DB_API) -> Response:
        print("Getting commands")
        return RespondWithResponse(self.channel_name, ", ".join(f"!{item}" for item in list(commands_dict.keys())))


###
# HELP COMMAND
###

help_command_parser: Parser = regex("!").optional() >> name_parser

def help_command_body(channel_name: ChannelName, username: str, command_name: str) -> Action:
    return HelpAction(channel_name, username, command_name)

help_command_help: str = "!help <command_name>. Examples: !help score, or !help !score"

help_command: BotCommand = buildCommand("help", help_command_parser, help_command_body, help_command_help)


###
# COMMANDS COMMAND
###

def commands_command_body(channel_name: ChannelName, username: str, _: None) -> Action:
    return GetCommandsAction(channel_name, username)

commands_command: BotCommand = buildCommand("commands", success(None), commands_command_body, "!commands")

###
# ALL COMMANDS
###
commands: list[BotCommand] = \
    stream_commands + \
    quote_commands + \
    score_commands + \
    counter_commands + \
    [help_command, commands_command]

# TODO:
# Quotes: search quotes,
# Scores: player, opponent
# user commands: addUserCommandCommand, editUserCommandCommand, deleteUserCommandCommand
# other: buildInfo

commands_dict: dict = {commands[i].name: commands[i] for i in range(0, len(commands))}

# TODO: this would be better if we could look up the command by name instead of
# looping through all the commands. fix this. -JC 3/20/24
def process_message(db_api: DB_API, msg: Message) -> Optional[Response]:
    for command in commands:
        action: Action = command.to_action(msg)
        if action is not None:
            print(f"action for {command}: {action}")
            if get_permission_level(msg) >= action.permission:
                return action.run(db_api)
            else:
                errmsg = f"You don't have permission to do that. You need at least {action.permission}"
                return RespondWithResponse(msg.channel_name, errmsg)
