from dataclasses import dataclass

from app.trollabot.commands import Response, RespondWithResponse
from app.trollabot.commands.base.action import Action
from app.trollabot.commands.base.bot_command import BotCommand, buildCommand
from app.trollabot.commands.base.parsing import name_parser
from app.trollabot.commands.base.permission import Permission
from app.trollabot.database import DB_API
from app.trollabot.messages import ChannelName

@dataclass
class GetCountAction(Action):
    name: str

    @property
    def permission(self) -> Permission:
        return Permission.ANYONE

    def run(self, db_api: DB_API) -> Response:
        print(f"Getting count for {self.name}")
        counter = db_api.counters.get_counter(self.channel_name, self.name)
        if counter:
            return RespondWithResponse(self.channel_name, f"{self.name}: {counter.count}")
        else:
            return RespondWithResponse(self.channel_name, f"No such counter: {self.name}")

@dataclass
class AddCounterAction(Action):
    name: str

    @property
    def permission(self) -> Permission:
        return Permission.MOD

    def run(self, db_api: DB_API) -> Response:
        print(f"Adding counter {self.name}")
        counter = db_api.counters.insert_counter(self.channel_name, self.username, self.name)
        return RespondWithResponse(self.channel_name, f"{self.name}: {counter.count}")

@dataclass
class DeleteCounterAction(Action):
    name: str

    @property
    def permission(self) -> Permission:
        return Permission.MOD

    def run(self, db_api: DB_API) -> Response:
        print(f"Deleting counter {self.name}")
        db_api.counters.delete_counter(self.channel_name, self.username, self.name)
        return RespondWithResponse(self.channel_name, f"Deleted counter: {self.name}")

@dataclass
class IncCounterAction(Action):
    name: str

    @property
    def permission(self) -> Permission:
        return Permission.ANYONE

    def run(self, db_api: DB_API) -> Response:
        print(f"Incrementing counter {self.name}")
        counter = db_api.counters.inc_counter(self.channel_name, self.name)
        if counter:
            return RespondWithResponse(self.channel_name, f"{self.name}: {counter.count}")
        else:
            return RespondWithResponse(self.channel_name, f"No such counter: {self.name}")

###
# GET COUNT CODE
###
def get_count(channel_name: ChannelName, username: str, counter_name: str) -> Action:
    return GetCountAction(channel_name, username, counter_name)

get_count_help: str = "!count <name>"

get_count_command: BotCommand = buildCommand("count", name_parser, get_count, get_count_help)

###
# ADD COUNTER CODE
###
def add_counter(channel_name: ChannelName, username: str, counter_name: str) -> Action:
    return AddCounterAction(channel_name, username, counter_name)

add_counter_help: str = "!addCounter <name>"

add_counter_command: BotCommand = buildCommand("addCounter", name_parser, add_counter, add_counter_help)

###
# DELETE COUNTER CODE
###
def delete_counter(channel_name: ChannelName, username: str, counter_name: str) -> Action:
    return DeleteCounterAction(channel_name, username, counter_name)

delete_counter_help: str = "!deleteCounter <name>"

delete_counter_command: BotCommand = buildCommand("deleteCounter", name_parser, delete_counter, delete_counter_help)

###
# INC COUNTER CODE
###
def inc_counter(channel_name: ChannelName, username: str, counter_name: str) -> Action:
    return IncCounterAction(channel_name, username, counter_name)

inc_counter_help: str = "!incCounter <name>"

inc_counter_command: BotCommand = buildCommand("incCounter", name_parser, inc_counter, inc_counter_help)

###
# ALL COUNTER COMMANDS
###
counter_commands: list[BotCommand] = [
    get_count_command,
    add_counter_command,
    delete_counter_command,
    inc_counter_command,
]
