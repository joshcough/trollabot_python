#! /usr/bin/env python

import irc.client
import os

from app.trollabot.database import DB_API


class TwitchIRCBot:
    def __init__(self, connection, db_api: DB_API):
        self.connection = connection
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
        print(f"on_pubmsg {connection} {event}")
        username = event.source.split('!')[0]
        print(f"Message from {username}: {event.arguments[0]}")


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
