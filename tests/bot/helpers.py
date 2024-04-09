from app.trollabot.channelname import ChannelName
from bot.trollabot.commands.base.bot_command import BotCommand
from bot.trollabot.messages import Message, Tags

test_stream: ChannelName = ChannelName("test_stream")
test_user = "test-user"
mod_tags = Tags([{'key': 'mod', 'value': '1'}])
not_mod_tags = Tags([{'key': 'mod', 'value': '0'}])

def mk_message(msg: str, user: str = test_user, tags: Tags = not_mod_tags) -> Message:
    return Message(test_stream, user, tags, msg)

def mk_god_message(msg: str) -> Message:
    return mk_message(msg, user="artofthetroll", tags=mod_tags)

def mk_mod_message(msg: str) -> Message:
    return mk_message(msg, user="some_mod", tags=mod_tags)

def mk_non_mod_message(msg: str) -> Message:
    return mk_message(msg, user=test_user, tags=not_mod_tags)

def to_action(command: BotCommand, msg: str) -> object:
    return command.to_action(mk_message(msg))
