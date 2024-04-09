from dataclasses import dataclass
from typing import Optional

from app.trollabot.channelname import ChannelName
from app.trollabot.database import DB_API
from bot.trollabot.commands import Permission, process_message, Response
from bot.trollabot.commands.base.bot_command import BotCommand
from bot.trollabot.messages import Message, Tags

test_stream_xxx: ChannelName = ChannelName("test_stream")
test_user = "test-user"
mod_tags = Tags([{'key': 'mod', 'value': '1'}])
not_mod_tags = Tags([{'key': 'mod', 'value': '0'}])

def to_action(command: BotCommand, msg: str,
              stream: ChannelName = test_stream_xxx,
              user: str = test_user,
              tags: Tags = not_mod_tags) -> object:
    return command.to_action(Message(stream, user, tags, msg))

@dataclass
class TestStream:
    channel: ChannelName
    db_api: DB_API

    def join(self) -> 'TestStream':
        self.send(f"!join {self.channel.value}", perm=Permission.GOD)
        return self

    def send(self, msg_text: str, perm: Permission) -> Optional[Response]:
        msg = None
        if perm == Permission.GOD:
            msg = Message(self.channel, "artofthetroll", mod_tags, msg_text)
        elif perm == Permission.STREAMER:
            msg = Message(self.channel, self.channel.value, mod_tags, msg_text)
        elif perm == Permission.MOD:
            msg = Message(self.channel, "some_mod", mod_tags, msg_text)
        elif perm == Permission.ANYONE:
            msg = Message(self.channel, test_user, not_mod_tags, msg_text)

        return process_message(self.db_api, msg)
