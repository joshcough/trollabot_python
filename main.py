import os

from app.trollabot.loggo import get_logger
from bot.trollabot.trollabot import run_via_external_db, run_via_test_container

logger = get_logger(__name__)

def main():
    if os.getenv("ENV") == "prod":
        logger.warn("Running against the prod database!")
        run_via_external_db()
    else:
        logger.debug("Running trollabot with a test container")
        run_via_test_container()

if __name__ == '__main__':
    logger.info("Welcome to Trollabot 2.0")
    main()
