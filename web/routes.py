from flask import Blueprint, render_template, g, request

from app.trollabot.channelname import ChannelName

bp = Blueprint('home', __name__)

@bp.route('/')
def home():
    return render_template('home.html')

@bp.route('/score')
def score():
    channel_name = request.args.get('channel_name', 'artofthetroll')
    chan = ChannelName(channel_name)
    s = g.db_api.scores.get_score(chan)
    return render_template('score.html', score=s)
