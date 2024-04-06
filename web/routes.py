from flask import Blueprint, render_template, g, request

from app.trollabot.channelname import ChannelName

bp = Blueprint('home', __name__)

@bp.route('/')
def home():
    channel_name = request.args.get('channel_name', 'artofthetroll')
    chan = ChannelName(channel_name)
    score = g.db_api.scores.get_score(chan)
    return render_template('home.html', score=score)
