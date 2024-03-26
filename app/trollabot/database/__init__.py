from app.trollabot.database.base import Base
from app.trollabot.database.counters import CountersDB
from app.trollabot.database.quotes import QuotesDB
from app.trollabot.database.scores import ScoresDB
from app.trollabot.database.streams import StreamsDB
from app.trollabot.database.user_commands import UserCommandsDB

class DB_API:
    def __init__(self, db_session):
        self.streams = StreamsDB(db_session)
        self.quotes = QuotesDB(db_session)
        self.counters = CountersDB(db_session)
        self.scores = ScoresDB(db_session)
        self.user_commands = UserCommandsDB(db_session)
