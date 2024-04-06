from flask import Flask, g
from flask_sqlalchemy import SQLAlchemy

from app.trollabot.database import DB_API
from web import routes

db = SQLAlchemy()

def create_app(conn_str):
    app = Flask(__name__)
    app.config['SQLALCHEMY_DATABASE_URI'] = conn_str
    db.init_app(app)

    db_api = DB_API(db.session)

    @app.before_request
    def before_request():
        # Make db_api accessible in the global context of a request
        g.db_api = db_api

    app.register_blueprint(routes.bp)

    return app
