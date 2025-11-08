"""Admin commands for bot management and testing."""
from dataclasses import dataclass

from parsy import success

from app.trollabot.channelname import ChannelName
from app.trollabot.database import DB_API
from app.trollabot.loggo import get_logger
from bot.trollabot.commands.base.action import Action
from bot.trollabot.commands.base.bot_command import BotCommand, buildCommand
from bot.trollabot.commands.base.permission import Permission
from bot.trollabot.commands.base.response import Response, RespondWithResponse
from bot.trollabot.notifier import Notifier

logger = get_logger(__name__)


@dataclass
class TestAlertAction(Action):
    """Test the Discord notification system."""

    @property
    def permission(self) -> Permission:
        return Permission.GOD

    def run(self, db_api: DB_API) -> Response:
        logger.info(f"Test alert requested by {self.username}")

        # Create notifier and send test notification
        notifier = Notifier()

        try:
            # Create a fake test error
            test_error = Exception("This is a TEST notification from the !alert command")
            notifier.notify_error(test_error, "Test Alert Command")

            return RespondWithResponse(
                self.channel_name,
                "Test notification sent! Check your Discord."
            )
        except Exception as e:
            logger.error(f"Failed to send test alert: {e}", exc_info=True)
            return RespondWithResponse(
                self.channel_name,
                f"Failed to send test notification: {e}"
            )


###
# ALERT COMMAND
###
def alert_command_body(channel_name: ChannelName, username: str, _: None) -> Action:
    return TestAlertAction(channel_name, username)


alert_help: str = "!alert - Test Discord notifications (God only)"

alert_command: BotCommand = buildCommand("alert", success(None), alert_command_body, alert_help)

###
# ALL ADMIN COMMANDS
###
admin_commands: list[BotCommand] = [
    alert_command,
]
