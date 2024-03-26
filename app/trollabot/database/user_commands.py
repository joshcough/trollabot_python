from typing import Optional

from sqlalchemy import Column, ForeignKey, String, DateTime, func
from sqlalchemy.orm import Session

from app.trollabot.database.base import Base
from app.trollabot.messages import ChannelName

class UserCommand(Base):
    __tablename__ = 'user_commands'
    name = Column(String, primary_key=True)
    channel = Column(String, ForeignKey('streams.name'), primary_key=True)
    body = Column(String, nullable=False)
    added_by = Column(String, nullable=False)
    added_at = Column(DateTime, nullable=False, default=func.now())

    def __repr__(self):
        return (f"<UserCommand(name={self.name}, body='{self.body}', channel={self.channel}, "
                f"added_by='{self.added_by}', added_at={self.added_at})>")

class UserCommandsDB:
    def __init__(self, session: Session):
        self.session = session

    def get_user_command(self, channel_name: ChannelName, name: str) -> Optional[UserCommand]:
        return self.session.query(UserCommand). \
            filter(UserCommand.channel == channel_name.value, UserCommand.name == name). \
            first()

    def insert_user_command(self, channel_name: ChannelName, username: str, name: str, body: str) -> UserCommand:
        instance = self.session.query(UserCommand).filter_by(name=name, channel=channel_name.value).first()
        if instance:
            return instance
        else:
            insert_stmt = UserCommand.__table__.insert().values(
                name=name,
                body=body,
                added_by=username,
                channel=channel_name.value,
            )
            self.session.execute(insert_stmt)
            self.session.commit()
            return self.session.get(UserCommand, {"channel": channel_name.value, "name": name})

    def delete_user_command(self, channel_name: ChannelName, username: str, name: str) -> None:
        user_command_to_delete = self.session.query(UserCommand).filter_by(name=name,
                                                                           channel=channel_name.value).first()

        if user_command_to_delete:
            self.session.delete(user_command_to_delete)
            self.session.commit()
