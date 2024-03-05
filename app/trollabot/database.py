from sqlalchemy import Column, ForeignKey, Integer, String, Boolean, DateTime, func, select, update, UniqueConstraint
from sqlalchemy.orm import declarative_base
from sqlalchemy.orm import relationship, Session

Base = declarative_base()

class Stream(Base):
    __tablename__ = 'streams'
    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False, unique=True)
    joined = Column(Boolean, default=False, nullable=False)
    added_by = Column(String, nullable=False)
    added_at = Column(DateTime, nullable=False, default=func.now())

    def irc_name(self):
        return f'#{self.name}'

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

    def insert_stream(self, channel_name, username):
        new_stream = Stream(name=channel_name, added_by=username)
        self.session.add(new_stream)
        self.session.commit()
        self.session.refresh(new_stream)
        return new_stream

    def get_streams(self):
        return self.session.query(Stream).all()

    def get_joined_streams(self):
        return self.session.query(Stream).filter_by(joined=True).all()

    def get_stream_by_name(self, channel_name):
        return self.session.query(Stream).filter_by(name=channel_name).first()

    def join(self, channel_name):
        self.session.execute(update(Stream).where(Stream.name == channel_name).values(joined=True))

class QuotesInterface:
    def __init__(self, session: Session):
        self.session = session

    def get_all(self, channel_name):
        return self.session.query(Quote). \
            join(Stream). \
            filter(Stream.name == channel_name, Quote.deleted == False). \
            all()

    def get_quote(self, channel_name, qid):
        return self.session.query(Quote). \
            join(Stream). \
            filter(Stream.name == channel_name, Quote.qid == qid, Quote.deleted == False). \
            first()

    def get_random_quote(self, channel_name):
        return self.session.query(Quote) \
            .join(Stream) \
            .filter(Stream.name == channel_name, Quote.deleted == False) \
            .order_by(func.random()) \
            .first()

    def insert_quote(self, text, username, channel_name):
        insert_stmt = Quote.__table__.insert().values(
            qid=select(func.coalesce(func.max(Quote.qid) + 1, 1)).
                where(Quote.stream.has(name=channel_name)).
                scalar_subquery(),
            text=text,
            added_by=username,
            stream_id=self.session.query(Stream.id).filter(Stream.name == channel_name).scalar_subquery(),
        )

        result = self.session.execute(insert_stmt)
        self.session.commit()

        inserted_quote_id = result.inserted_primary_key[0]
        return self.session.get(Quote, inserted_quote_id)

    def delete_quote(self, channel_name, qid, username):
        # Execute the statement
        self.session.execute(
            update(Quote).
                where(Quote.qid == qid).
                where(Quote.stream.has(name=channel_name)).
                values(deleted=True, deleted_at=func.now(), deleted_by=username))
        self.session.commit()
