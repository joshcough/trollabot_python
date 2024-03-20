import pytest
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from testcontainers.postgres import PostgresContainer
from app.trollabot.database import Base, Quote, Stream, DB_API, Counter, Score


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
    db_session.query(Counter).delete()
    db_session.query(Quote).delete()
    db_session.query(Score).delete()
    db_session.query(Stream).delete()
    db_session.commit()

