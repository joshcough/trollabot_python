from abc import ABC
from dataclasses import dataclass
from typing import List

from parsy import regex, seq, any_char

from app.trollabot.channelname import ChannelName
from app.trollabot.database import DB_API
from app.trollabot.database.user_commands import UserCommand
from bot.trollabot.commands import Response, RespondWithResponse
from bot.trollabot.commands.base.action import Action
from bot.trollabot.commands.base.bot_command import BotCommand, buildCommand
from bot.trollabot.commands.base.parsing import name_parser, token
from bot.trollabot.commands.base.permission import Permission

class ParseNode(ABC):
    def run(self, db_api: DB_API, channel_name: ChannelName, username: str) -> str:
        pass

@dataclass
class TextNode(ParseNode):
    text: str

    def run(self, db_api: DB_API, channel_name: ChannelName, username: str) -> str:
        return self.text

@dataclass
class VarNode(ParseNode):
    varname: str

    def run(self, db_api: DB_API, channel_name: ChannelName, username: str) -> str:
        # note: this returns the counter if it already exists
        # and if it doesn't exist, will create it for us
        # the first time a user command is run, we will need to create counters.
        counter = db_api.counters.insert_counter(channel_name, username, self.varname)
        counter_inced = db_api.counters.inc_counter(channel_name, counter.name)
        return f"{counter_inced.count}"

# Parser for variable names inside ${...}
var_name = regex(r"[a-zA-Z_][a-zA-Z0-9_]*")

# Parser for variable interpolation syntax ${varname}
var_node = seq(regex(r"\$\{"), var_name, regex(r"\}")).combine(lambda _, varname, __: VarNode(varname))

# Parser for plain text
text_node = regex(r"[^$]+").map(TextNode)

# Parser that can parse both text nodes and variable nodes
node_parser = (var_node | text_node).many()

def parse_user_command_body(input_string):
    return node_parser.parse(input_string)

def interpret(nodes: List[ParseNode], db_api: DB_API, channel_name: ChannelName, username: str) -> str:
    # Iterate over each node, call the run method, and concatenate the results
    result_strings = [node.run(db_api, channel_name, username) for node in nodes]
    return ''.join(result_strings)

@dataclass
class RunUserCommandAction(Action):
    cmd: UserCommand

    @property
    def permission(self) -> Permission:
        return Permission.ANYONE

    def run(self, db_api: DB_API) -> Response:
        print(f"Running user command: {self.cmd.name}")
        nodes = parse_user_command_body(self.cmd.body)
        res = interpret(nodes, db_api, self.channel_name, self.username)
        return RespondWithResponse(self.channel_name, res)

@dataclass
class AddUserCommandAction(Action):
    name: str
    body: str

    @property
    def permission(self) -> Permission:
        return Permission.MOD

    def run(self, db_api: DB_API) -> Response:
        print(f"Adding user_command {self.name}")
        user_command = db_api.user_commands.insert_user_command(self.channel_name, self.username, self.name, self.body)
        # TODO: need to interpret the command here.
        return RespondWithResponse(self.channel_name, f"{self.name}: {user_command.body}")

@dataclass
class DeleteUserCommandAction(Action):
    name: str

    @property
    def permission(self) -> Permission:
        return Permission.MOD

    def run(self, db_api: DB_API) -> Response:
        print(f"Deleting user_command {self.name}")
        db_api.user_commands.delete_user_command(self.channel_name, self.username, self.name)
        return RespondWithResponse(self.channel_name, f"Deleted user_command: {self.name}")

###
# ADD USER COMMAND
###
@dataclass
class AddUserCommandParseResult:
    name: str
    body: str

    def __repr__(self) -> str:
        return f"<AddUserCommandParseResult(name='{self.name}', body={self.body})>"

add_user_command_parser = seq(token(name_parser), any_char.many().concat()).map(
    lambda x: AddUserCommandParseResult(x[0], x[1]))

def add_user_command(channel_name: ChannelName, username: str, res: AddUserCommandParseResult) -> Action:
    return AddUserCommandAction(channel_name, username, res.name, res.body)

add_user_command_help: str = "!addc <name> <body>"

# TODO: we should check here if the name is in the built in command names
# and if so, return an error message, because it'll never get run.
add_user_command_command: BotCommand = \
    buildCommand("addc", add_user_command_parser, add_user_command, add_user_command_help)

###
# DELETE USER COMMAND
###
def delete_user_command(channel_name: ChannelName, username: str, user_command_name: str) -> Action:
    return DeleteUserCommandAction(channel_name, username, user_command_name)

delete_user_command_help: str = "!delc <name>"

delete_user_command_command: BotCommand = buildCommand("delc", name_parser, delete_user_command,
                                                       delete_user_command_help)

###
# ALL COUNTER COMMANDS
###
user_commands: list[BotCommand] = [add_user_command_command, delete_user_command_command]
