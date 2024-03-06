from dataclasses import dataclass

# tags: [
#   {'key': 'badge-info', 'value': 'subscriber/78'},
#   {'key': 'badges', 'value': 'broadcaster/1,subscriber/0,premium/1'},
#   {'key': 'client-nonce', 'value': 'd960873b642707caf626343640403d52'},
#   {'key': 'color', 'value': '#B22222'},
#   {'key': 'display-name', 'value': 'ArtOfTheTroll'},
#   {'key': 'emotes', 'value': None},
#   {'key': 'first-msg', 'value': '0'},
#   {'key': 'flags', 'value': None},
#   {'key': 'id', 'value': '73c6d88a-5ad9-4934-9f93-2118f8f9e670'},
#   {'key': 'mod', 'value': '0'},
#   {'key': 'returning-chatter', 'value': '0'},
#   {'key': 'room-id', 'value': '156467570'},
#   {'key': 'subscriber', 'value': '1'},
#   {'key': 'tmi-sent-ts', 'value': '1709681381034'},
#   {'key': 'turbo', 'value': '0'},
#   {'key': 'user-id', 'value': '156467570'},
#   {'key': 'user-type', 'value': None}
#   ]
class Tags:
    def __init__(self, tags):
        for tag in tags:
            setattr(self, tag['key'], tag['value'])

# source: artofthetroll!artofthetroll@artofthetroll.tmi.twitch.tv,
# target: #artofthetroll,
# arguments: ['hi'],
# tags: [ ... ]   (see Tags)
@dataclass
class Message:
    channel_name: str
    username: str
    tags: Tags
    text: str

    def from_owner(self):
        return self.username == self.channel_name

    def from_mod(self):
        return self.tags.mod == '1'

def message_from_event(event):
    return Message(
        event.target.split('#')[1],
        event.source.split('!')[0],
        Tags(event.tags),
        event.arguments[0]
    )

@dataclass
class ChatUser:
    username: str
    is_mod: bool
    is_owner: bool
