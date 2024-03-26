from typing import Optional

from sqlalchemy import Column, ForeignKey, Integer, String, Boolean, DateTime, func, select, update
from sqlalchemy.orm import relationship, Session

from app.trollabot.database.base import Base
from app.trollabot.messages import ChannelName

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
