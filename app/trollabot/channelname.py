from dataclasses import dataclass

@dataclass
class ChannelName:
    value: str

    def as_irc(self):
        return f"#{self.value}"
