import pytest
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from testcontainers.postgres import PostgresContainer

from app.trollabot.database import Base, DB_API
from app.trollabot.database.counters import Counter
from app.trollabot.database.quotes import Quote
from app.trollabot.database.scores import Score
from app.trollabot.database.streams import Stream
from app.trollabot.database.user_commands import UserCommand

@pytest.fixture(scope="session")
def db_session():
    with PostgresContainer("postgres:latest") as postgres:
        engine = create_engine(postgres.get_connection_url())
        Base.metadata.create_all(engine)
        TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

        sess = TestingSessionLocal()

        yield sess  # Provide the session for the tests

        # Cleanup
        sess.close()
        Base.metadata.drop_all(bind=engine)

@pytest.fixture(scope="module")
def db_api(db_session) -> DB_API:
    db = DB_API(db_session)
    yield db

@pytest.fixture(scope="function")
def clean_db(db_api: DB_API):
    yield
    db_session = db_api.streams.session
    db_session.query(UserCommand).delete()
    db_session.query(Counter).delete()
    db_session.query(Quote).delete()
    db_session.query(Score).delete()
    db_session.query(Stream).delete()
    db_session.commit()
