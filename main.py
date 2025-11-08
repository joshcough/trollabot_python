import os

from app.trollabot.database.base import Base
from app.trollabot.loggo import get_logger
from testcontainers.postgres import PostgresContainer

from bot.trollabot.trollabot import run_bot

logger = get_logger(__name__)


def main():
    """Start the Trollabot with either production or test database."""
    # Check if we should use an external database
    # Uses DATABASE_URL if set, or ENV=prod for backwards compatibility
    if os.getenv("DATABASE_URL") or os.getenv("ENV") == "prod":
        logger.info("Running in PRODUCTION mode with external database")
        run_via_external_db()
    else:
        logger.info("Running in DEVELOPMENT mode with test container")
        run_via_test_container()


def run_via_test_container() -> None:
    """Run bot with a temporary PostgreSQL test container."""
    logger.info("Starting PostgreSQL test container...")
    with PostgresContainer("postgres:latest") as postgres:
        conn_str = postgres.get_connection_url()
        logger.debug(f"Test database ready at {conn_str}")
        run_bot(conn_str, lambda engine: Base.metadata.create_all(engine))


def run_via_external_db() -> None:
    """Run bot with external database from DATABASE_URL env var."""
    database_url = os.getenv('DATABASE_URL')
    if not database_url:
        logger.error("DATABASE_URL environment variable not set!")
        raise ValueError("DATABASE_URL is required in production mode")

    run_bot(database_url, lambda engine: None)


if __name__ == '__main__':
    logger.info("Welcome to Trollabot 2.0")
    main()
