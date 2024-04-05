from typing import Optional

from sqlalchemy import Column, String, Boolean, DateTime, func, update
from sqlalchemy.orm import relationship

from app.trollabot.database.base import Base
from app.trollabot.channelname import ChannelName

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
