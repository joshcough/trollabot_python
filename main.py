import os

from bot.trollabot.trollabot import run_via_external_db, run_via_test_container
from threading import Thread
from webapp import app  # Import the Flask app

def run_bot():
    if os.getenv("ENV") == "local":
        run_via_test_container()
    else:
        run_via_external_db()

def run_webapp():
    app.run(debug=False, use_reloader=False)

if __name__ == '__main__':
    print("Welcome to Trollabot 2.0")

    # bot_thread = Thread(target=run_bot)
    webapp_thread = Thread(target=run_webapp)

    # bot_thread.start()
    webapp_thread.start()
