from app.trollabot.database import Base, StreamsInterface, QuotesInterface
from app.trollabot.irc_bot import TwitchIRCBot, setup_connection
import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from testcontainers.postgres import PostgresContainer

oauth = os.getenv('BOT_TOKEN')

channels = ['#artofthetroll', '#shutanaoe', '#discernaoe']

def get_args():
    class Args:
        server = 'irc.chat.twitch.tv'
        port = 6667
        nickname = 'trollabot'
        oauth = os.getenv('BOT_TOKEN')
    return Args()

def main():
    print("Welcome to Trollabot 2.0")
    args = get_args()
    reactor, connection = setup_connection(args)

    with PostgresContainer("postgres:latest") as postgres:
        engine = create_engine(postgres.get_connection_url(), isolation_level="REPEATABLE READ")
        Base.metadata.create_all(engine)
        TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
        db_session = TestingSessionLocal()
        streams = StreamsInterface(db_session)
        quotes = QuotesInterface(db_session)

        streams.insert_stream("artofthetroll", "artofthetroll")
        streams.join("artofthetroll")

        bot = TwitchIRCBot(connection, streams, quotes)
        reactor.process_forever()

        db_session.close()
        Base.metadata.drop_all(bind=engine)

if __name__ == '__main__':
    main()


# def get_args():
#     parser = argparse.ArgumentParser()
#     parser.add_argument('-s', '--server', default = 'irc.chat.twitch.tv', type=str)
#     parser.add_argument('-n', '--nickname', default = 'trollabot', type=str)
#     parser.add_argument('-p', '--port', default=6667, type=int)
#     jaraco.logging.add_arguments(parser)
#     res = parser.parse_args()
#     print(res)
#     print(res.server)
#     return res