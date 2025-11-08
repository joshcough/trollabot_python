#! /usr/bin/env python
import os
import sys

import irc.client

from app.trollabot.database import DB_API
from app.trollabot.loggo import get_logger
from bot.trollabot.commands import process_message
from bot.trollabot.commands.base.response import Response, RespondWithResponse, JoinResponse, PartResponse, \
    LogErrResponse
from bot.trollabot.messages import message_from_event

logger = get_logger(__name__)

class TwitchIRCBot:
    def __init__(self, connection, db_api: DB_API, is_first_connect: bool = True):
        self.connection = connection
        self.db_api = db_api
        self.is_first_connect = is_first_connect
        self.channels = db_api.streams.get_joined_streams()
        logger.info(f'channels: {self.channels}')

        # Bind event handlers to the connection object
        self.connection.add_global_handler("welcome", self.on_connect)
        # self.connection.add_global_handler("join", self.on_join)
        self.connection.add_global_handler("disconnect", self.on_disconnect)
        self.connection.add_global_handler("pubmsg", self.on_pubmsg)

    def on_connect(self, connection, event) -> None:
        logger.debug(f"on_connect {event}")
        connection.cap('REQ', 'twitch.tv/membership')
        connection.cap('REQ', 'twitch.tv/commands')
        connection.cap('REQ', 'twitch.tv/tags')

        for channel in self.channels:
            if irc.client.is_channel(channel.channel_name().as_irc()):
                connection.join(channel.channel_name().as_irc())
                # Only greet on first connect, not on auto-reconnects
                if self.is_first_connect:
                    connection.privmsg(channel.channel_name().as_irc(), "Hello ladies, I'm back.")

    # def on_join(connection, event):
    #     logger.error(f"on_join {connection} {event}")
    #     # connection.privmsg(channel, "hola")

    def on_disconnect(self, connection, event) -> None:
        logger.error(f"on_disconnect {connection} {event}")
        raise SystemExit()

    def on_pubmsg(self, connection, event) -> None:
        logger.debug(f"Event: {event}")
        message = message_from_event(event)
        try:
            response: Response = process_message(self.db_api, message)
            if response is not None:
                logger.debug(f"response: {response}")
                self.process_response(connection, response)
        except Exception as e:
            # TODO: maybe we should send an error back to the user. But not sure yet.
            logger.error(f"An error occurred: {e}")

    def process_response(self, connection, response: Response) -> None:
        if isinstance(response, RespondWithResponse):
            logger.debug(f"Responding with: {response.msg}")
            connection.privmsg(response.channel_name.as_irc(), response.msg)
        elif isinstance(response, JoinResponse):
            logger.info(f"Joining {response.channel_to_join.as_irc()}")
            connection.join(response.channel_to_join.as_irc())
            connection.privmsg(response.channel_to_join.as_irc(), "Hola!")
        elif isinstance(response, PartResponse):
            logger.info(f"Parting {response.channel_to_part.as_irc()}")
            connection.part(response.channel_to_part.as_irc())
        elif isinstance(response, LogErrResponse):
            logger.error(f"ERROR: {response.msg}")

class IrcConfig:
    server = 'irc.chat.twitch.tv'
    port = 6667
    nickname = 'trollabot'
    oauth = os.getenv('BOT_TOKEN')

def setup_connection(irc_config):
    """Create and return the IRC connection."""
    reactor = irc.client.Reactor()
    logger.debug(f"irc oauth: {irc_config.oauth}")
    try:
        connection = reactor.server().connect(
            irc_config.server, irc_config.port, irc_config.nickname, password=f'oauth:{irc_config.oauth}')
        logger.debug("made connection!")
        return reactor, connection
    except irc.client.ServerConnectionError as e:
        logger.error(sys.exc_info()[1])
        raise SystemExit(1) from e
