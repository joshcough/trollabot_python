import psycopg2
from testcontainers.postgres import PostgresContainer

def create_streams_table(cursor):
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS streams (
            id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            name character varying NOT NULL,
            joined boolean NOT NULL default false,
            added_by text NOT NULL,
            added_at timestamp NOT NULL default now()
        );
    """)

def create_quotes_table(cursor):
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS quotes (
            id int PRIMARY KEY,
            qid int NOT NULL,
            text character varying NOT NULL,
            stream_id int NOT NULL REFERENCES streams(id),
            added_by text NOT NULL,
            added_at timestamp NOT NULL,
            deleted boolean NOT NULL default false,
            deleted_by text NULL
        );
    """)

def insert_stream(cursor, name):
    cursor.execute("INSERT INTO streams (name, added_by) VALUES (%s, %s)", (name, 'artofthetroll'))

def select_all_streams(cursor):
    cursor.execute("SELECT * FROM streams")
    colnames = [desc[0] for desc in cursor.description]
    streams = [dict(zip(colnames, record)) for record in cursor.fetchall()]
    for stream in streams:
        print(stream)

def main():
    # Define PostgreSQL container with a specific version
    with PostgresContainer("postgres:13.3") as postgres:
        # Connect to the PostgreSQL server
        connection = psycopg2.connect(
            database=postgres.POSTGRES_DB,
            user=postgres.POSTGRES_USER,
            password=postgres.POSTGRES_PASSWORD,
            host=postgres.get_container_host_ip(),
            port=postgres.get_exposed_port("5432")
        )

        cursor = connection.cursor()
        create_streams_table(cursor)
        create_quotes_table(cursor)

        insert_stream(cursor, "artofthetroll")
        select_all_streams(cursor)

        # Commit the transaction and close
        connection.commit()
        cursor.close()
        connection.close()

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
