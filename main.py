import os

from app.trollabot.trollabot import run_via_external_db, run_via_test_container

def main():
    while True:
        print("hello")
        time.sleep(10)
    # print("Welcome to Trollabot 2.0")
    # if os.getenv("ENV") == "local":
    #     run_via_test_container()
    # else:
    #     run_via_external_db()

if __name__ == '__main__':
    main()
