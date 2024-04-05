from dataclasses import dataclass

from app.trollabot.channelname import ChannelName

@dataclass
class Response:
    pass

@dataclass
class RespondWithResponse(Response):
    channel_name: ChannelName
    msg: str

@dataclass
class JoinResponse(Response):
    channel_to_join: ChannelName

@dataclass
class PartResponse(Response):
    channel_to_part: ChannelName

@dataclass
class LogErrResponse(Response):
    msg: str
