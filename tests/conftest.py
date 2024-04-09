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
def db_container():
    with PostgresContainer("postgres:latest") as postgres:
        yield postgres

@pytest.fixture(scope="session")
def db_engine(db_container):
    engine = create_engine(db_container.get_connection_url())
    Base.metadata.create_all(engine)
    yield engine
    Base.metadata.drop_all(bind=engine)

@pytest.fixture(scope="session")
def db_session(db_engine):
    TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=db_engine)

    session = TestingSessionLocal()
    yield session  # Provide the session for the tests

    # Cleanup
    session.close()

@pytest.fixture(scope="function")
def db_api(db_session) -> DB_API:
    db = DB_API(db_session)
    yield db
    db_session.query(UserCommand).delete()
    db_session.query(Counter).delete()
    db_session.query(Quote).delete()
    db_session.query(Score).delete()
    db_session.query(Stream).delete()
    db_session.commit()

