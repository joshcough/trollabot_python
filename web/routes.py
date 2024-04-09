from flask import Blueprint, render_template, g, request

from app.trollabot.channelname import ChannelName
from bot.trollabot.commands import commands_dict

app = Blueprint('home', __name__)

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/score')
def score():
    channel_name = request.args.get('channel_name', 'artofthetroll')
    chan = ChannelName(channel_name)
    s = g.db_api.scores.get_score(chan)
    return render_template('score.html', score=s)

@app.route('/commands')
def commands():
    # Sort commands by name
    sorted_commands = sorted(commands_dict.values(), key=lambda cmd: cmd.name)
    return render_template('commands.html', commands=sorted_commands)