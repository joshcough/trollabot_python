import os
import traceback
from datetime import datetime
from typing import Optional

import requests

from app.trollabot.loggo import get_logger

logger = get_logger(__name__)


class Notifier:
    """Sends Discord notifications when the bot crashes or encounters errors."""

    def __init__(self):
        self.discord_webhook_url = os.getenv('DISCORD_WEBHOOK_URL')

        if self.discord_webhook_url:
            logger.info("Discord notifications enabled")
        else:
            logger.warning("DISCORD_WEBHOOK_URL not configured - errors will only be logged")

    def notify_error(self, error: Exception, context: str = "Bot error"):
        """Send notification about an error to Discord."""
        if not self.discord_webhook_url:
            return

        error_details = self._format_error(error, context)
        self._send_discord(error_details)

    def notify_restart(self, restart_count: int, last_error: Optional[str] = None):
        """Send notification when bot is attempting to restart."""
        if not self.discord_webhook_url:
            return

        message = f"Bot restart attempt #{restart_count}"
        if last_error:
            message += f"\n\nLast error: {last_error}"

        self._send_discord_simple(message, "warning")

    def notify_fatal(self, message: str):
        """Send notification for fatal errors that prevent restart."""
        if not self.discord_webhook_url:
            return

        self._send_discord_simple(f"FATAL: {message}", "error")

    def _format_error(self, error: Exception, context: str) -> str:
        """Format error with full traceback."""
        tb = ''.join(traceback.format_exception(type(error), error, error.__traceback__))
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        return f"""
{context}
Time: {timestamp}
Error Type: {type(error).__name__}
Error Message: {str(error)}

Traceback:
{tb}
"""

    def _send_discord(self, error_details: str):
        """Send error details to Discord via webhook."""
        try:
            # Discord has a 2000 char limit, truncate if needed
            content = error_details
            if len(content) > 1900:
                content = content[:1900] + "\n... (truncated)"

            payload = {
                "embeds": [{
                    "title": "Trollabot Error",
                    "description": f"```\n{content}\n```",
                    "color": 0xFF0000,  # Red
                    "timestamp": datetime.utcnow().isoformat()
                }]
            }

            response = requests.post(self.discord_webhook_url, json=payload, timeout=10)
            response.raise_for_status()
            logger.debug("Discord notification sent")
        except Exception as e:
            logger.error(f"Failed to send Discord notification: {e}")

    def _send_discord_simple(self, message: str, level: str = "info"):
        """Send a simple message to Discord."""
        try:
            color = {
                "info": 0x0099FF,      # Blue
                "warning": 0xFFCC00,   # Yellow
                "error": 0xFF0000      # Red
            }.get(level, 0x0099FF)

            payload = {
                "embeds": [{
                    "title": "Trollabot Status",
                    "description": message,
                    "color": color,
                    "timestamp": datetime.utcnow().isoformat()
                }]
            }

            response = requests.post(self.discord_webhook_url, json=payload, timeout=10)
            response.raise_for_status()
        except Exception as e:
            logger.error(f"Failed to send Discord notification: {e}")
