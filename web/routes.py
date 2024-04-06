from flask import Blueprint, render_template, g

from app.trollabot.channelname import ChannelName

bp = Blueprint('home', __name__)

@bp.route('/')
def home():
    score = g.db_api.scores.get_score(ChannelName("artofthetroll"))
    print(f"SCORE: {score}")
    return render_template('home.html', score=score)
