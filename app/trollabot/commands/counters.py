from dataclasses import dataclass

from app.trollabot.commands.base.parsing import name_parser
from app.trollabot.commands.base.action import Action
from app.trollabot.commands.base.bot_command import BotCommand, buildCommand
from app.trollabot.commands.base.permission import Permission
from app.trollabot.messages import ChannelName

@dataclass
class AddCounterAction(Action):
    name: str

    @property
    def permission(self) -> Permission:
        return Permission.MOD

@dataclass
class IncCounterAction(Action):
    name: str

    @property
    def permission(self) -> Permission:
        return Permission.ANYONE


###
# ADD COUNTER CODE
###
def add_counter(channel_name: ChannelName, username: str, counter_name: str) -> Action:
    return AddCounterAction(channel_name, username, counter_name)

add_counter_help: str = "!addCounter <name>"

add_counter_command: BotCommand = buildCommand("addCounter", name_parser, add_counter, add_counter_help)

###
# INC COUNTER CODE
###
def inc_counter(channel_name: ChannelName, username: str, counter_name: str) -> Action:
    return IncCounterAction(channel_name, username, counter_name)

inc_counter_help: str = "!incCounter <name>"

inc_counter_command: BotCommand = buildCommand("incCounter", name_parser, inc_counter, inc_counter_help)
