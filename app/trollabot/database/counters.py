from typing import Optional

from sqlalchemy import Column, ForeignKey, Integer, String, DateTime, func, update
from sqlalchemy.orm import relationship, Session

from app.trollabot.database import Base
from app.trollabot.messages import ChannelName

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
