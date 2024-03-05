from testcontainers.postgres import PostgresContainer
from sqlalchemy import create_engine, Column, ForeignKey, Integer, String, Boolean, DateTime, func
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker

Base = declarative_base()

class Stream(Base):
    __tablename__ = 'streams'
    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    joined = Column(Boolean, default=False, nullable=False)
    added_by = Column(String, nullable=False)
    added_at = Column(DateTime, nullable=False, default=func.now())

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

    # Define a relationship (this is optional and for convenience)
    stream = relationship("Stream", back_populates="quotes")

    def __repr__(self):
        return (f"<Quote(id={self.id}, qid={self.qid}, text='{self.text}', "
                f"stream_id={self.stream_id}, added_by='{self.added_by}', "
                f"added_at={self.added_at}, deleted={self.deleted}, "
                f"deleted_by='{self.deleted_by}')>")

# Add a quotes attribute to the Stream class to complete the bidirectional relationship
Stream.quotes = relationship("Quote", order_by=Quote.id, back_populates="stream")

def select_stream(session, stream_name):
    # Query the database for the stream with the given name
    stream = session.query(Stream).filter_by(name=stream_name).first()
    return stream

def insert_quote(session, stream_id, text, added_by):
    # Find the maximum qid for the given stream_id
    max_qid = session.query(func.max(Quote.qid)).filter_by(stream_id=stream_id).scalar()
    max_qid = max_qid if max_qid is not None else 0  # If no quotes exist, start with 0

    # Create and insert the new quote
    new_quote = Quote(qid=max_qid + 1, stream_id=stream_id, text=text, added_by=added_by)
    session.add(new_quote)
    session.commit()

def main():
    # Define PostgreSQL container with a specific version
    with PostgresContainer("postgres:13.3") as postgres:

        database_url = f"postgresql+psycopg2://{postgres.POSTGRES_USER}:{postgres.POSTGRES_PASSWORD}@{postgres.get_container_host_ip()}:{postgres.get_exposed_port('5432')}/{postgres.POSTGRES_DB}"
        engine = create_engine(database_url)
        Base.metadata.create_all(engine)

        Session = sessionmaker(bind=engine)
        session = Session()

        session.add(Stream(name="artofthetroll", added_by="artofthetroll"))
        session.add(Stream(name="daut", added_by="artofthetroll"))
        stream1 = select_stream(session, "artofthetroll")
        stream2 = select_stream(session, "daut")
        insert_quote(session, stream1.id, "hi there", "artofthetroll")
        insert_quote(session, stream2.id, "yo", "artofthetroll")
        insert_quote(session, stream1.id, "bye", "artofthetroll")
        session.commit()

        for stream in session.query(Stream).all():
            print(f"{stream}")

        for quotes in session.query(Quote).all():
            print(f"{quotes}")

        session.close()

if __name__ == "__main__":
    main()


# package com.joshcough.trollabot.api
#
# import cats.Show
# import cats.effect.MonadCancelThrow
# import cats.implicits._
# import com.joshcough.trollabot.{ChannelName, ChatUserName}
# import com.joshcough.trollabot.db.queries.{Quotes => QuoteQueries}
# import doobie._
# import doobie.implicits._
# import doobie.util.transactor.Transactor
#
# import java.sql.Timestamp
#
# case class Quote(
#     qid: Int,
#     text: String,
#     channel: ChannelName,
#     addedBy: ChatUserName,
#     addedAt: Timestamp,
#     deleted: Boolean,
#     deletedBy: Option[ChatUserName],
#     deletedAt: Option[Timestamp]
# ) {
#   def display: String = s"Quote #$qid: $text"
# }
#
# object Quote {
#   implicit val quoteShow: Show[Quote] = Show.fromToString
# }
#
# trait Quotes[F[_]] {
#   def getQuote(channelName: ChannelName, qid: Int): F[Option[Quote]]
#   def getRandomQuote(channelName: ChannelName): F[Option[Quote]]
#   def getQuotes(channelName: ChannelName): fs2.Stream[F, Quote]
#   def searchQuotes(channelName: ChannelName, like: String): fs2.Stream[F, Quote]
#   def searchQuotes_Random(channelName: ChannelName, like: String): F[Option[Quote]]
#
#   /**
#     * Tries to insert a new quote, but first checks if a quote with that text already exists.
#     * If it does, it returns Left of that quote (which most importantly, contains its qid)
#     * If it does not, it returns Right of the new quote.
#     * @param text the body of the new quote
#     * @param username the user adding the quote
#     * @param channelName the stream the quote is being added to.
#     * @return Either ExistingQuote NewQuote
#     */
#   def insertQuote(
#       text: String,
#       username: ChatUserName,
#       channelName: ChannelName
#   ): F[Either[Quote, Quote]]
#   def deleteQuote(channelName: ChannelName, qid: Int, userName: ChatUserName): F[Boolean]
#
#   def countQuotes: F[Count]
#   def countQuotesInStream(channelName: ChannelName): F[Count]
# }
#
# object Quotes {
#   def impl[F[_]: MonadCancelThrow](xa: Transactor[F]): Quotes[F] =
#     new Quotes[F] {
#       def getQuote(channelName: ChannelName, qid: Int): F[Option[Quote]] =
#         QuotesDb.getQuote(channelName, qid).transact(xa)
#
#       def getRandomQuote(channelName: ChannelName): F[Option[Quote]] =
#         QuotesDb.getRandomQuote(channelName).transact(xa)
#
#       def getQuotes(channelName: ChannelName): fs2.Stream[F, Quote] =
#         QuotesDb.getQuotes(channelName).transact(xa)
#
#       def searchQuotes(channelName: ChannelName, like: String): fs2.Stream[F, Quote] =
#         QuotesDb.searchQuotes(channelName, like).transact(xa)
#
#       def searchQuotes_Random(channelName: ChannelName, like: String): F[Option[Quote]] =
#         QuotesDb.searchQuotes_Random(channelName, like).transact(xa)
#
#       def insertQuote(
#           text: String,
#           username: ChatUserName,
#           channelName: ChannelName
#       ): F[Either[Quote, Quote]] =
#         QuotesDb.insertQuote(text, username, channelName).transact(xa)
#
#       def deleteQuote(channelName: ChannelName, qid: Int, userName: ChatUserName): F[Boolean] =
#         QuotesDb.deleteQuote(channelName, qid, userName).transact(xa)
#
#       def countQuotes: F[Count] = QuotesDb.countQuotes.transact(xa)
#
#       def countQuotesInStream(channelName: ChannelName): F[Count] =
#         QuotesDb.countQuotesInStream(channelName).transact(xa)
#     }
# }
#
# object QuotesDb extends Quotes[ConnectionIO] {
#   def getQuote(channelName: ChannelName, qid: Int): ConnectionIO[Option[Quote]] =
#     QuoteQueries.getQuoteByQid(channelName, qid).option
#
#   def getRandomQuote(channelName: ChannelName): ConnectionIO[Option[Quote]] =
#     QuoteQueries.getRandomQuoteForStream(channelName).option
#
#   def getQuotes(channelName: ChannelName): fs2.Stream[ConnectionIO, Quote] =
#     QuoteQueries.getAllQuotesForStream(channelName).stream
#
#   def searchQuotes(channelName: ChannelName, like: String): fs2.Stream[ConnectionIO, Quote] =
#     QuoteQueries.searchQuotesForStream(channelName, like).stream
#
#   def searchQuotes_Random(channelName: ChannelName, like: String): ConnectionIO[Option[Quote]] =
#     QuoteQueries.searchQuotesForStream_Random(channelName, like).option
#
#   def insertQuote(
#       text: String,
#       username: ChatUserName,
#       channelName: ChannelName
#   ): ConnectionIO[Either[Quote, Quote]] =
#     for {
#       o <- QuoteQueries.getQuoteByText(channelName, text).option
#       r <- o match {
#         case None    => QuoteQueries.insertQuote(text, username, channelName).unique.map(Right(_))
#         case Some(q) => Left(q).pure[ConnectionIO]
#       }
#     } yield r
#
#   def deleteQuote(
#       channelName: ChannelName,
#       qid: Int,
#       userName: ChatUserName
#   ): ConnectionIO[Boolean] =
#     QuoteQueries.deleteQuote(channelName, qid, userName).run.map(_ > 0)
#
#   def countQuotes: ConnectionIO[Count] = QuoteQueries.countQuotes.unique.map(Count)
#
#   def countQuotesInStream(channelName: ChannelName): ConnectionIO[Count] =
#     QuoteQueries.countQuotesInStream(channelName).unique.map(Count)
# }