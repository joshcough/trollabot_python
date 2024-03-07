#! /usr/bin/env python
from app.trollabot.commands import process_message, Response, RespondWithResponse, JoinResponse, PartResponse, \
    LogErrResponse
from app.trollabot.database import DB_API
import irc.client
import os

from app.trollabot.messages import message_from_event

class TwitchIRCBot:
    def __init__(self, connection, db_api: DB_API):
        self.connection = connection
        self.db_api = db_api
        self.channels = db_api.streams.get_joined_streams()
        print(f'channels: {self.channels}')

        # Bind event handlers to the connection object
        self.connection.add_global_handler("welcome", self.on_connect)
        self.connection.add_global_handler("disconnect", self.on_disconnect)
        self.connection.add_global_handler("pubmsg", self.on_pubmsg)

    def on_connect(self, connection, event):
        print(f"on_connect {event}")
        connection.cap('REQ', 'twitch.tv/membership')
        connection.cap('REQ', 'twitch.tv/commands')
        connection.cap('REQ', 'twitch.tv/tags')

        for channel in self.channels:
            if irc.client.is_channel(channel.channel_name().as_irc()):
                connection.join(channel.channel_name().as_irc())
                connection.privmsg(channel.channel_name().as_irc(), "hola")

    def on_disconnect(self, connection, event):
        print(f"on_disconnect {connection} {event}")
        raise SystemExit()

    def on_pubmsg(self, connection, event):
        print(f"on_pubmsg {connection} {event} {event.tags}")
        message = message_from_event(event)
        print(f"message: {message}")
        response = process_message(self.db_api, message)
        print(f"response: {response}")
        self.process_response(connection, response)

    def process_response(self, connection, response: Response):
        if isinstance(response, RespondWithResponse):
            connection.privmsg(response.channel_name.as_irc(), response.msg)
        elif isinstance(response, JoinResponse):
            connection.join(response.channel_to_join.as_irc())
            connection.privmsg(response.channel_to_join.as_irc(), "Hola!")
        elif isinstance(response, PartResponse):
            connection.part(response.channel_to_part.as_irc())
        elif isinstance(response, LogErrResponse):
            print(f"ERROR: {response.msg}")

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
