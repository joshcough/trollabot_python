from typing import Optional

from sqlalchemy import Column, ForeignKey, Integer, String, Boolean, DateTime, func, select, update
from sqlalchemy.orm import declarative_base
from sqlalchemy.orm import relationship, Session

from app.trollabot.messages import ChannelName

Base = declarative_base()

class Stream(Base):
    __tablename__ = 'streams'
    name = Column(String, nullable=False, primary_key=True)
    joined = Column(Boolean, default=False, nullable=False)
    added_by = Column(String, nullable=False)
    added_at = Column(DateTime, nullable=False, default=func.now())

    quotes = relationship("Quote", order_by="Quote.qid", back_populates="stream")
    counters = relationship("Counter", back_populates="stream")
    score = relationship("Score", back_populates="stream", uselist=False)

    def channel_name(self) -> ChannelName:
        return ChannelName(self.name)

    def __repr__(self) -> str:
        return f"<Stream(name='{self.name}', joined={self.joined}, " \
               f"added_by='{self.added_by}', added_at={self.added_at})>"

class Quote(Base):
    __tablename__ = 'quotes'
    qid = Column(Integer, primary_key=True)
    text = Column(String, nullable=False)
    channel = Column(String, ForeignKey('streams.name'), primary_key=True)
    added_by = Column(String, nullable=False)
    added_at = Column(DateTime, nullable=False, default=func.now())
    deleted = Column(Boolean, default=False, nullable=False)
    deleted_by = Column(String, nullable=True)
    deleted_at = Column(DateTime, nullable=True)

    # Define a relationship (this is optional and for convenience)
    stream = relationship("Stream", back_populates="quotes")

    def __repr__(self):
        return (f"<Quote(qid={self.qid}, text='{self.text}', channel={self.channel}, "
                f"added_by='{self.added_by}', added_at={self.added_at}, deleted={self.deleted}, "
                f"deleted_by='{self.deleted_by}', deleted_at={self.deleted_at})>")

class Counter(Base):
    __tablename__ = 'counters'
    name = Column(String, primary_key=True)
    channel = Column(String, ForeignKey('streams.name'), primary_key=True)
    count = Column("current_count", Integer, nullable=False, default=0)
    added_by = Column(String, nullable=False)
    added_at = Column(DateTime, nullable=False, default=func.now())

    # Define a relationship (this is optional and for convenience)
    stream = relationship("Stream", back_populates="counters")

    def __repr__(self):
        return (f"<Counter(name={self.name}, count='{self.count}', channel={self.channel}, "
                f"added_by='{self.added_by}', added_at={self.added_at})>")

class Score(Base):
    __tablename__ = 'scores'
    channel = Column(String, ForeignKey('streams.name'), primary_key=True)
    player1 = Column(String, nullable=True)
    player2 = Column(String, nullable=True)
    player1_score = Column(Integer, nullable=False, default=0)
    player2_score = Column(Integer, nullable=False, default=0)

    # Define a relationship (this is optional and for convenience)
    stream = relationship("Stream", back_populates="score")

    def __eq__(self, other):
        if not isinstance(other, Score):
            # don't attempt to compare against unrelated types
            return NotImplemented

        return (
                self.channel == other.channel and
                self.player1 == other.player1 and
                self.player2 == other.player2 and
                self.player1_score == other.player1_score and
                self.player2_score == other.player2_score
        )

    def __repr__(self):
        return (f"<Score(player1='{self.player1}', player2='{self.player2}', "
                f"player1_score={self.player1_score}, player2_score={self.player2_score})>")

    def to_irc(self):
        p1 = self.player1 or "player"
        p2 = self.player2 or "opponent"
        return f"{p1} {self.player1_score} - {self.player2_score} {p2}"

class UserCommand(Base):
    __tablename__ = 'user_commands'
    name = Column(String, primary_key=True)
    channel = Column(String, ForeignKey('streams.name'), primary_key=True)
    body = Column(String, nullable=False)
    added_by = Column(String, nullable=False)
    added_at = Column(DateTime, nullable=False, default=func.now())

    def __repr__(self):
        return (f"<UserCommand(name={self.name}, body='{self.body}', channel={self.channel}, "
                f"added_by='{self.added_by}', added_at={self.added_at})>")


class StreamsDB:
    def __init__(self, session):
        self.session = session

    def insert_stream(self, channel_name: ChannelName, username: str) -> Stream:
        new_stream = Stream(name=channel_name.value, added_by=username)
        self.session.add(new_stream)
        self.session.commit()
        self.session.refresh(new_stream)
        return new_stream

    def get_streams(self) -> [Stream]:
        return self.session.query(Stream).all()

    def get_joined_streams(self) -> [Stream]:
        return self.session.query(Stream).filter_by(joined=True).all()

    def get_stream_by_name(self, channel_name: ChannelName) -> Optional[Stream]:
        return self.session.query(Stream).filter_by(name=channel_name.value).first()

    def join(self, channel_name: ChannelName, username: str) -> None:
        existing_stream = self.session.query(Stream).filter_by(name=channel_name.value).first()
        if existing_stream is None:
            self.insert_stream(channel_name, username)
        self.session.execute(update(Stream).where(Stream.name == channel_name.value).values(joined=True))
        self.session.commit()

    def part(self, channel_name: ChannelName) -> None:
        self.session.execute(update(Stream).where(Stream.name == channel_name.value).values(joined=False))
        self.session.commit()

class QuotesDB:
    def __init__(self, session: Session):
        self.session = session

    def get_all(self, channel_name: ChannelName) -> [Quote]:
        return self.session.query(Quote). \
            filter(Quote.channel == channel_name.value, Quote.deleted == False). \
            all()

    def get_quote(self, channel_name: ChannelName, qid) -> Optional[Quote]:
        return self.session.query(Quote). \
            filter(Quote.channel == channel_name.value, Quote.qid == qid, Quote.deleted == False). \
            first()

    def get_random_quote(self, channel_name: ChannelName) -> Optional[Quote]:
        return self.session.query(Quote) \
            .filter(Quote.channel == channel_name.value, Quote.deleted == False) \
            .order_by(func.random()) \
            .first()

    def insert_quote(self, channel_name: ChannelName, username, text) -> Quote:
        insert_stmt = Quote.__table__.insert().values(
            qid=select(func.coalesce(func.max(Quote.qid) + 1, 1)).
                where(Quote.stream.has(name=channel_name.value)).
                scalar_subquery(),
            text=text,
            added_by=username,
            channel=channel_name.value,
        ).returning(Quote.qid)

        result = self.session.execute(insert_stmt)
        self.session.commit()

        new_qid = result.fetchone()[0]
        return self.session.get(Quote, {"channel": channel_name.value, "qid": new_qid})

    def delete_quote(self, channel_name: ChannelName, qid, username) -> None:
        self.session.execute(
            update(Quote).
                where(Quote.qid == qid).
                where(Quote.stream.has(name=channel_name.value)).
                values(deleted=True, deleted_at=func.now(), deleted_by=username))
        self.session.commit()

class CountersDB:
    def __init__(self, session: Session):
        self.session = session

    def get_counter(self, channel_name: ChannelName, name: str) -> Optional[Counter]:
        return self.session.query(Counter). \
            filter(Counter.channel == channel_name.value, Counter.name == name). \
            first()

    def insert_counter(self, channel_name: ChannelName, username: str, name: str) -> Counter:
        instance = self.session.query(Counter).filter_by(name=name, channel=channel_name.value).first()
        if instance:
            return instance
        else:
            insert_stmt = Counter.__table__.insert().values(
                name=name,
                added_by=username,
                channel=channel_name.value,
            )
            self.session.execute(insert_stmt)
            self.session.commit()
            return self.session.get(Counter, {"channel": channel_name.value, "name": name})

    def delete_counter(self, channel_name: ChannelName, username: str, name: str) -> None:
        counter_to_delete = self.session.query(Counter).filter_by(name=name, channel=channel_name.value).first()

        if counter_to_delete:
            self.session.delete(counter_to_delete)
            self.session.commit()

    def inc_counter(self, channel_name: ChannelName, name: str) -> Optional[Counter]:
        self.session.execute(
            update(Counter).
                where(Counter.name == name).
                where(Counter.stream.has(name=channel_name.value)).
                values(count=Counter.count + 1).
                execution_options(synchronize_session="fetch")
        )
        self.session.commit()
        return self.session.get(Counter, {"channel": channel_name.value, "name": name})

class ScoresDB:
    def __init__(self, session: Session):
        self.session = session

    def default_score(self, channel_name: ChannelName) -> Score:
        default_score = Score(
            channel=channel_name.value,
            player1="player",
            player2="opponent",
            player1_score=0,
            player2_score=0
        )
        self.session.add(default_score)
        self.session.commit()
        return default_score

    def upsert_score(self, channel_name: ChannelName, player1_score: int, player2_score: int) -> Score:
        new_score = Score(
            channel=channel_name.value,
            player1_score=player1_score,
            player2_score=player2_score
        )
        self.session.merge(new_score)
        self.session.commit()
        return self.get_score(channel_name)

    def upsert_score_all(self, channel_name: ChannelName, player1: str, player1_score: int, player2: str,
                         player2_score: int) -> Score:
        new_score = Score(
            channel=channel_name.value,
            player1=player1,
            player1_score=player1_score,
            player2=player2,
            player2_score=player2_score
        )
        self.session.merge(new_score)
        self.session.commit()
        return self.get_score(channel_name)

    def get_score(self, channel_name: ChannelName) -> Score:
        res = self.session.query(Score).filter_by(channel=channel_name.value).one_or_none()
        return res if res is not None else self.default_score(channel_name)

class UserCommandsDB:
    def __init__(self, session: Session):
        self.session = session

    def get_user_command(self, channel_name: ChannelName, name: str) -> Optional[UserCommand]:
        return self.session.query(UserCommand). \
            filter(UserCommand.channel == channel_name.value, UserCommand.name == name). \
            first()

    def insert_user_command(self, channel_name: ChannelName, username: str, name: str, body: str) -> UserCommand:
        instance = self.session.query(UserCommand).filter_by(name=name, channel=channel_name.value).first()
        if instance:
            return instance
        else:
            insert_stmt = UserCommand.__table__.insert().values(
                name=name,
                body=body,
                added_by=username,
                channel=channel_name.value,
            )
            self.session.execute(insert_stmt)
            self.session.commit()
            return self.session.get(UserCommand, {"channel": channel_name.value, "name": name})

    def delete_user_command(self, channel_name: ChannelName, username: str, name: str) -> None:
        user_command_to_delete = self.session.query(UserCommand).filter_by(name=name, channel=channel_name.value).first()

        if user_command_to_delete:
            self.session.delete(user_command_to_delete)
            self.session.commit()

class DB_API:
    def __init__(self, db_session):
        self.streams = StreamsDB(db_session)
        self.quotes = QuotesDB(db_session)
        self.counters = CountersDB(db_session)
        self.scores = ScoresDB(db_session)
        self.user_commands = UserCommandsDB(db_session)
