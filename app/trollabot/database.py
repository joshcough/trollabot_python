import os
from abc import ABC, abstractmethod

from sqlalchemy import Column, ForeignKey, Integer, String, Boolean, DateTime, func, select, update, UniqueConstraint
from sqlalchemy.orm import declarative_base
from sqlalchemy.orm import relationship, Session
from testcontainers.postgres import PostgresContainer

from app.trollabot.messages import ChannelName

Base = declarative_base()

class Stream(Base):
    __tablename__ = 'streams'
    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False, unique=True)
    joined = Column(Boolean, default=False, nullable=False)
    added_by = Column(String, nullable=False)
    added_at = Column(DateTime, nullable=False, default=func.now())

    def channel_name(self):
        return ChannelName(self.name)

    def __repr__(self):
        return f"<Stream(id={self.id}, name='{self.name}', joined={self.joined}, added_by='{self.added_by}', added_at={self.added_at})>"

class Quote(Base):
    __tablename__ = 'quotes'
    id = Column(Integer, primary_key=True)
    qid = Column(Integer, nullable=False)
    text = Column(String, nullable=False)
    stream_id = Column(Integer, ForeignKey('streams.id'), nullable=False)
    added_by = Column(String, nullable=False)
    added_at = Column(DateTime, nullable=False, default=func.now())
    deleted = Column(Boolean, default=False, nullable=False)
    deleted_by = Column(String, nullable=True)
    deleted_at = Column(DateTime, nullable=True)

    # Define a relationship (this is optional and for convenience)
    stream = relationship("Stream", back_populates="quotes")

    __table_args__ = (
        UniqueConstraint('stream_id', 'text', name='_stream_id_text_uc'),
    )

    def __repr__(self):
        return (f"<Quote(id={self.id}, qid={self.qid}, text='{self.text}', "
                f"stream_id={self.stream_id}, added_by='{self.added_by}', "
                f"added_at={self.added_at}, deleted={self.deleted}, "
                f"deleted_by='{self.deleted_by}', deleted_at={self.deleted_at})>")

# Add a quotes attribute to the Stream class to complete the bidirectional relationship
Stream.quotes = relationship("Quote", order_by=Quote.id, back_populates="stream")

class StreamsInterface:
    def __init__(self, session):
        self.session = session

    def insert_stream(self, channel_name: ChannelName, username: str):
        new_stream = Stream(name=channel_name.value, added_by=username)
        self.session.add(new_stream)
        self.session.commit()
        self.session.refresh(new_stream)
        return new_stream

    def get_streams(self):
        return self.session.query(Stream).all()

    def get_joined_streams(self):
        return self.session.query(Stream).filter_by(joined=True).all()

    def get_stream_by_name(self, channel_name: ChannelName):
        return self.session.query(Stream).filter_by(name=channel_name.value).first()

    def join(self, channel_name: ChannelName, username: str):
        existing_stream = self.session.query(Stream).filter_by(name=channel_name.value).first()
        if existing_stream is None:
            self.insert_stream(channel_name, username)
        self.session.execute(update(Stream).where(Stream.name == channel_name.value).values(joined=True))

    def part(self, channel_name: ChannelName):
        self.session.execute(update(Stream).where(Stream.name == channel_name.value).values(joined=False))

class QuotesInterface:
    def __init__(self, session: Session):
        self.session = session

    def get_all(self, channel_name: ChannelName):
        return self.session.query(Quote). \
            join(Stream). \
            filter(Stream.name == channel_name.value, Quote.deleted == False). \
            all()

    def get_quote(self, channel_name: ChannelName, qid):
        return self.session.query(Quote). \
            join(Stream). \
            filter(Stream.name == channel_name.value, Quote.qid == qid, Quote.deleted == False). \
            first()

    def get_random_quote(self, channel_name: ChannelName):
        return self.session.query(Quote) \
            .join(Stream) \
            .filter(Stream.name == channel_name.value, Quote.deleted == False) \
            .order_by(func.random()) \
            .first()

    def insert_quote(self, channel_name: ChannelName, username, text):
        insert_stmt = Quote.__table__.insert().values(
            qid=select(func.coalesce(func.max(Quote.qid) + 1, 1)).
                where(Quote.stream.has(name=channel_name.value)).
                scalar_subquery(),
            text=text,
            added_by=username,
            stream_id=self.session.query(Stream.id).filter(Stream.name == channel_name.value).scalar_subquery(),
        )

        result = self.session.execute(insert_stmt)
        self.session.commit()

        inserted_quote_id = result.inserted_primary_key[0]
        return self.session.get(Quote, inserted_quote_id)

    def delete_quote(self, channel_name: ChannelName, qid, username):
        self.session.execute(
            update(Quote).
                where(Quote.qid == qid).
                where(Quote.stream.has(name=channel_name.value)).
                values(deleted=True, deleted_at=func.now(), deleted_by=username))
        self.session.commit()

class DB_API:
    def __init__(self, db_session):
        self.streams = StreamsInterface(db_session)
        self.quotes = QuotesInterface(db_session)

class DbConfigInterface(ABC):
    @property
    @abstractmethod
    def server(self):
        pass

    @property
    @abstractmethod
    def port(self):
        pass

    @property
    @abstractmethod
    def username(self):
        pass

    @property
    @abstractmethod
    def password(self):
        pass

    @property
    @abstractmethod
    def database(self):
        pass

    def get_connection_string(self):
        """Constructs and returns a PostgreSQL connection string."""
        return f"postgresql://{self.username}:{self.password}@{self.server}:{self.port}/{self.database}"

class EnvDbConfig(DbConfigInterface):
    @property
    def server(self):
        return os.getenv('PG_HOST')

    @property
    def port(self):
        return os.getenv('PG_PORT', '5432')

    @property
    def username(self):
        return os.getenv('PG_USER')

    @property
    def password(self):
        return os.getenv('PG_PASS')

    @property
    def database(self):
        return os.getenv('PG_DATABASE')

class ContainerDbConfig(DbConfigInterface):
    def __init__(self, container: PostgresContainer):
        self.container = container

    @property
    def server(self):
        # Assuming the container object has a method to get the IP
        return self.container.get_container_host_ip()

    @property
    def port(self):
        # Assuming the container object can map the port
        return self.container.get_exposed_port(5432)

    @property
    def username(self):
        return self.container.POSTGRES_USER

    @property
    def password(self):
        return self.container.POSTGRES_PASSWORD

    @property
    def database(self):
        return self.container.POSTGRES_DB
