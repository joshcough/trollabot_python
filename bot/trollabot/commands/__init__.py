from dataclasses import dataclass
from typing import Optional

from parsy import regex, Parser, success, ParseError

from app.trollabot.channelname import ChannelName
from app.trollabot.database import DB_API
from app.trollabot.loggo import get_logger
from bot.trollabot.commands.base.action import Action
from bot.trollabot.commands.base.bot_command import BotCommand, buildCommand
from bot.trollabot.commands.base.parsing import name_parser, case_insensitive_str
from bot.trollabot.commands.base.permission import Permission, get_permission_level
from bot.trollabot.commands.base.response import Response, RespondWithResponse
from bot.trollabot.commands.counters import counter_commands
from bot.trollabot.commands.quotes import quote_commands
from bot.trollabot.commands.scores import score_commands
from bot.trollabot.commands.streams import stream_commands
from bot.trollabot.commands.user_commands import user_commands, RunUserCommandAction
from bot.trollabot.messages import Message

logger = get_logger(__name__)

@dataclass
class HelpAction(Action):
    command_name: str

    @property
    def permission(self) -> Permission:
        return Permission.ANYONE

    def run(self, db_api: DB_API) -> Response:
        logger.debug(f"Getting help for: {self.command_name}")
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
        logger.debug("Getting commands")
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

# TODO:
# Quotes: search quotes,
# Scores: player, opponent
# other: buildInfo

commands: list[BotCommand] = \
    stream_commands + \
    quote_commands + \
    score_commands + \
    counter_commands + \
    user_commands + \
    [help_command, commands_command]

commands_dict: dict = {commands[i].name: commands[i] for i in range(0, len(commands))}

def find_action(db_api: DB_API, msg: Message) -> Optional[Action]:
    try:
        command_name = (case_insensitive_str(f"!") >> (name_parser) << regex(r".*")).parse(msg.text)
        command = commands_dict.get(command_name)
        if command is None:
            user_command = db_api.user_commands.get_user_command(msg.channel_name, command_name)
            if user_command is not None:
                return RunUserCommandAction(msg.channel_name, msg.username, user_command)
            else:
                # TODO: here, we could return "No such command" or something. But that would require
                # a new action, and i dont feel like doing it yet. Sleeping on it.
                return None
        if command is not None:
            return command.to_action(msg)

    except ParseError as e:
        # Here, we couldn't parse a command name, so it's just a normal message.
        return None

# TODO: this would be better if we could look up the command by name instead of
# looping through all the commands. fix this. -JC 3/20/24
def process_message(db_api: DB_API, msg: Message) -> Optional[Response]:
    action = find_action(db_api, msg)
    if action is not None:
        logger.info(f"Asked to run action {action}")
        if get_permission_level(msg) >= action.permission:
            return action.run(db_api)
        else:
            errmsg = f"You don't have permission to do that. You need at least {action.permission}"
            return RespondWithResponse(msg.channel_name, errmsg)
    else:
        return None
