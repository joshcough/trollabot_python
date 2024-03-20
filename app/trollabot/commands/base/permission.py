from enum import Enum

from app.trollabot.messages import Message

class Permission(Enum):
    GOD = (4, "God")
    STREAMER = (3, "Streamer")
    MOD = (2, "Mod")
    ANYONE = (1, "Anyone")

    def __gt__(self, other):
        if self.__class__ is other.__class__:
            return self.value[0] > other.value[0]
        return NotImplemented

    def __ge__(self, other):
        if self.__class__ is other.__class__:
            return self.value[0] >= other.value[0]
        return NotImplemented

    @property
    def label(self) -> str:
        return self.value[1]

def get_permission_level(msg: Message) -> Permission:
    if msg.from_god():
        return Permission.GOD
    elif msg.from_owner():
        return Permission.STREAMER
    elif msg.from_mod():
        return Permission.MOD
    else:
        return Permission.ANYONE