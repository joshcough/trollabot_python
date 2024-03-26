from dataclasses import dataclass

from parsy import seq, any_char

from app.trollabot.commands import Response, RespondWithResponse
from app.trollabot.commands.base.action import Action
from app.trollabot.commands.base.bot_command import BotCommand, buildCommand
from app.trollabot.commands.base.parsing import name_parser, token
from app.trollabot.commands.base.permission import Permission
from app.trollabot.database import DB_API, UserCommand
from app.trollabot.messages import ChannelName

@dataclass
class RunUserCommandAction(Action):
    cmd: UserCommand

    @property
    def permission(self) -> Permission:
        return Permission.ANYONE

    def run(self, db_api: DB_API) -> Response:
        print(f"Running user command: {self.cmd.name}")
        # TODO run the interpreter here
        return RespondWithResponse(self.channel_name, f"{self.cmd.body}")

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
user_commands: list[BotCommand] = [ add_user_command_command, delete_user_command_command ]
