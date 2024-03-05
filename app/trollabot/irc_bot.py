#! /usr/bin/env python

import argparse
import irc.client
import jaraco.logging
import os

oauth = os.getenv('BOT_TOKEN')

channels = ['#artofthetroll', '#discernaoe']
# channels = ['#artofthetroll', '#shutanaoe', '#discernaoe']

def on_connect(connection, event):
    print(f"on_connect {event}")
    connection.cap('REQ', 'twitch.tv/membership')
    connection.cap('REQ', 'twitch.tv/commands')
    connection.cap('REQ', 'twitch.tv/tags')

    for channel in channels:
        if irc.client.is_channel(channel):
            connection.join(channel)

def on_join(connection, event):
    print(f"on_join {connection} {event}")
    connection.privmsg(channel, "hola")

def on_disconnect(connection, event):
    print(f"on_disconnect {connection} {event}")
    raise SystemExit()

def on_pubmsg(connection, event):
    print(f"on_pubmsg {connection} {event}")
    # Print messages received in the channel
    username = event.source.split('!')[0]
    print(f"Message from {username}: {event.arguments[0]}")

def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-s', '--server', default = 'irc.chat.twitch.tv', type=str)
    parser.add_argument('-n', '--nickname', default = 'trollabot_test', type=str)
    parser.add_argument('-p', '--port', default=6667, type=int)
    jaraco.logging.add_arguments(parser)
    res = parser.parse_args()
    print(res)
    print(res.server)
    return res

def main():
    print("Welcome to Trollabot 2.0")

    args = get_args()
    jaraco.logging.setup(args)

    reactor = irc.client.Reactor()
    try:
        c = reactor.server().connect(args.server, args.port, args.nickname, password = f'oauth:{oauth}')

    except irc.client.ServerConnectionError:
        print(sys.exc_info()[1])
        raise SystemExit(1)

    c.add_global_handler("welcome", on_connect)
    c.add_global_handler("join", on_join)
    c.add_global_handler("disconnect", on_disconnect)
    c.add_global_handler("pubmsg", on_pubmsg)

    reactor.process_forever()

if __name__ == '__main__':
    main()