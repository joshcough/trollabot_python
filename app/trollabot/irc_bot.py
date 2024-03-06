#! /usr/bin/env python
from app.trollabot.commands import process_message
from app.trollabot.database import DB_API
from enum import Enum
import irc.client
import os

class Permission(Enum):
    GOD = "God"
    STREAMER = "Streamer"
    MOD = "Mod"
    ANYONE = "Anyone"

class Response:
    pass

class RespondWith(Response):
    def __init__(self, s: str):
        self.s = s

class Join(Response):
    def __init__(self, new_channel: str):  # Assuming ChannelName is a string
        self.new_channel = new_channel

class Part(Response):
    pass

class LogErr(Response):
    def __init__(self, err: str):
        self.err = err

class TwitchIRCBot:
    def __init__(self, connection, db_api: DB_API):
        self.connection = connection
        self.db_api = db_api
        self.channels = db_api.streams.get_joined_streams()
        print(f'channels: {self.channels}')

        # Bind event handlers to the connection object
        self.connection.add_global_handler("welcome", self.on_connect)
        self.connection.add_global_handler("join", self.on_join)
        self.connection.add_global_handler("disconnect", self.on_disconnect)
        self.connection.add_global_handler("pubmsg", self.on_pubmsg)

    def on_connect(self, connection, event):
        print(f"on_connect {event}")
        connection.cap('REQ', 'twitch.tv/membership')
        connection.cap('REQ', 'twitch.tv/commands')
        connection.cap('REQ', 'twitch.tv/tags')

        for channel in self.channels:
            if irc.client.is_channel(channel.irc_name()):
                connection.join(channel.irc_name())
                connection.privmsg(channel.irc_name(), "hola")

    # NOTE: i think this is when another user joins
    def on_join(self, connection, event):
        print(f"on_join {connection} {event}")

    def on_disconnect(self, connection, event):
        print(f"on_disconnect {connection} {event}")
        raise SystemExit()

    def on_pubmsg(self, connection, event):
        print(f"on_pubmsg {connection} {event} {event.tags}")
        message = message_from_event(event)
        print(f"message.channel: {message.channel_name}")
        print(f"message.sender: {message.username}")
        print(f"message.text: {message.text}")
        print(f"message.tags.mod: {message.tags.mod}")
        print(f"message.tags.subscriber: {message.tags.subscriber}")
        process_message(self.db_api, message)

class IrcConfig:
    server = 'irc.chat.twitch.tv'
    port = 6667
    nickname = 'trollabot'
    oauth = os.getenv('BOT_TOKEN')

def setup_connection(irc_config):
    """Create and return the IRC connection."""
    reactor = irc.client.Reactor()
    try:
        connection = reactor.server().connect(
            irc_config.server, irc_config.port, irc_config.nickname, password=f'oauth:{irc_config.oauth}')
        return reactor, connection
    except irc.client.ServerConnectionError as e:
        print(sys.exc_info()[1])
        raise SystemExit(1) from e
