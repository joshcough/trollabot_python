from sqlite3 import IntegrityError

from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.orm import relationship, Session

from app.trollabot.channelname import ChannelName
from app.trollabot.database.base import Base

class Score(Base):
    __tablename__ = 'scores'
    channel = Column(String, ForeignKey('streams.name'), primary_key=True)
    player1 = Column(String, nullable=True)
    player2 = Column(String, nullable=True)
    player1_score = Column(Integer, nullable=False, default=0)
    player2_score = Column(Integer, nullable=False, default=0)

    @classmethod
    def empty_score(cls, channel_name: ChannelName):
        return cls(
            channel=channel_name.value,
            player1=None,
            player2=None,
            player1_score=0,
            player2_score=0
        )

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

    def player1_name(self):
        return self.player1 or "player"

    def player2_name(self):
        return self.player2 or "opponent"

    def to_irc(self):
        return f"{self.player1_name()} {self.player1_score} - {self.player2_score} {self.player2_name()}"

class ScoresDB:
    def __init__(self, session: Session):
        self.session = session

    def upsert_score(self, channel_name: ChannelName, player1_score: int, player2_score: int) -> Score:
        score = self.get_or_create_score(channel_name)
        score.player1_score = player1_score
        score.player2_score = player2_score
        self.session.commit()
        return score

    def upsert_score_all(self, channel_name: ChannelName, player1: str, player1_score: int, player2: str,
                         player2_score: int) -> Score:
        score = self.get_or_create_score(channel_name)
        score.player1_score = player1_score
        score.player1 = player1
        score.player2_score = player2_score
        score.player2 = player2
        self.session.merge(score)
        self.session.commit()
        return self.get_score(channel_name)

    def get_score(self, channel_name: ChannelName) -> Score:
        res = self.session.query(Score).filter_by(channel=channel_name.value).one_or_none()
        return res if res is not None else Score.empty_score(channel_name)

    def get_or_create_score(self, channel_name: ChannelName) -> Score:
        # Attempt to fetch the existing score
        existing_score = self.session.query(Score).filter_by(channel=channel_name.value).one_or_none()
        if existing_score is not None:
            return existing_score

        # No existing score found; attempt to create a new one
        new_score = Score.empty_score(channel_name)
        self.session.add(new_score)
        try:
            self.session.commit()
            return new_score
        except IntegrityError:
            self.session.rollback()
            # Score may have been created in another concurrent session; fetch and return it
            return self.session.query(Score).filter_by(channel=channel_name.value).one()
