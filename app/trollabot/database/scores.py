from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.orm import relationship, Session

from app.trollabot.database.base import Base
from app.trollabot.channelname import ChannelName

class Score(Base):
    __tablename__ = 'scores'
    channel = Column(String, ForeignKey('streams.name'), primary_key=True)
    player1 = Column(String, nullable=True)
    player2 = Column(String, nullable=True)
    player1_score = Column(Integer, nullable=False, default=0)
    player2_score = Column(Integer, nullable=False, default=0)

    # Define a relationship (this is optional and for convenience)
    stream = relationship("Stream", back_populates="score")

    def __eq__(self, other):
        if not isinstance(other, Score):
            # don't attempt to compare against unrelated types
            return NotImplemented

        return (
                self.channel == other.channel and
                self.player1 == other.player1 and
                self.player2 == other.player2 and
                self.player1_score == other.player1_score and
                self.player2_score == other.player2_score
        )

    def __repr__(self):
        return (f"<Score(player1='{self.player1}', player2='{self.player2}', "
                f"player1_score={self.player1_score}, player2_score={self.player2_score})>")

    def to_irc(self):
        p1 = self.player1 or "player"
        p2 = self.player2 or "opponent"
        return f"{p1} {self.player1_score} - {self.player2_score} {p2}"

class ScoresDB:
    def __init__(self, session: Session):
        self.session = session

    def default_score(self, channel_name: ChannelName) -> Score:
        default_score = Score(
            channel=channel_name.value,
            player1="player",
            player2="opponent",
            player1_score=0,
            player2_score=0
        )
        self.session.add(default_score)
        self.session.commit()
        return default_score

    def upsert_score(self, channel_name: ChannelName, player1_score: int, player2_score: int) -> Score:
        new_score = Score(
            channel=channel_name.value,
            player1_score=player1_score,
            player2_score=player2_score
        )
        self.session.merge(new_score)
        self.session.commit()
        return self.get_score(channel_name)

    def upsert_score_all(self, channel_name: ChannelName, player1: str, player1_score: int, player2: str,
                         player2_score: int) -> Score:
        new_score = Score(
            channel=channel_name.value,
            player1=player1,
            player1_score=player1_score,
            player2=player2,
            player2_score=player2_score
        )
        self.session.merge(new_score)
        self.session.commit()
        return self.get_score(channel_name)

    def get_score(self, channel_name: ChannelName) -> Score:
        res = self.session.query(Score).filter_by(channel=channel_name.value).one_or_none()
        return res if res is not None else self.default_score(channel_name)
