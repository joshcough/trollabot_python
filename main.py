import os

from bot.trollabot.trollabot import run_via_external_db, run_via_test_container

def main():
    if os.getenv("ENV") == "prod":
        print("NOTICE: Running against the prod database!")
        run_via_external_db()
    else:
        print("Running trollabot with a test container")
        run_via_test_container()

if __name__ == '__main__':
    print("Welcome to Trollabot 2.0")
    main()
