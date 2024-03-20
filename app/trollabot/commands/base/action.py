from dataclasses import dataclass
from abc import ABC, abstractmethod

from app.trollabot.commands.base.response import Response
from app.trollabot.commands.base.permission import Permission
from app.trollabot.database import DB_API
from app.trollabot.messages import ChannelName

@dataclass
class Action(ABC):
    channel_name: ChannelName
    username: str

    @property
    def permission(self) -> Permission:
        # TODO: maybe we should raise an error here if a subclass does not override
        return Permission.GOD

    @abstractmethod
    def run(self, db_api: DB_API) -> Response:
        pass