import os
import smtplib
import traceback
from datetime import datetime
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from typing import Optional

import requests

from app.trollabot.loggo import get_logger

logger = get_logger(__name__)


class Notifier:
    """Sends notifications when the bot crashes or encounters errors."""

    def __init__(self):
        self.discord_webhook_url = os.getenv('DISCORD_WEBHOOK_URL')
        self.email_enabled = all([
            os.getenv('SMTP_HOST'),
            os.getenv('SMTP_PORT'),
            os.getenv('SMTP_USERNAME'),
            os.getenv('SMTP_PASSWORD'),
            os.getenv('NOTIFICATION_EMAIL')
        ])

        if self.discord_webhook_url:
            logger.info("Discord notifications enabled")
        if self.email_enabled:
            logger.info("Email notifications enabled")

        if not self.discord_webhook_url and not self.email_enabled:
            logger.warning("No notification methods configured")

    def notify_error(self, error: Exception, context: str = "Bot error"):
        """Send notification about an error via all configured channels."""
        error_details = self._format_error(error, context)

        if self.discord_webhook_url:
            self._send_discord(error_details)

        if self.email_enabled:
            self._send_email(error_details, context)

    def notify_restart(self, restart_count: int, last_error: Optional[str] = None):
        """Send notification when bot is attempting to restart."""
        message = f"Bot restart attempt #{restart_count}"
        if last_error:
            message += f"\n\nLast error: {last_error}"

        if self.discord_webhook_url:
            self._send_discord_simple(message, "warning")

    def notify_fatal(self, message: str):
        """Send notification for fatal errors that prevent restart."""
        if self.discord_webhook_url:
            self._send_discord_simple(f"FATAL: {message}", "error")

        if self.email_enabled:
            self._send_email(message, "FATAL ERROR")

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

    def _send_email(self, error_details: str, subject_prefix: str):
        """Send error details via email."""
        try:
            smtp_host = os.getenv('SMTP_HOST')
            smtp_port = int(os.getenv('SMTP_PORT'))
            smtp_username = os.getenv('SMTP_USERNAME')
            smtp_password = os.getenv('SMTP_PASSWORD')
            to_email = os.getenv('NOTIFICATION_EMAIL')

            msg = MIMEMultipart()
            msg['From'] = smtp_username
            msg['To'] = to_email
            msg['Subject'] = f"[Trollabot] {subject_prefix}"

            body = MIMEText(error_details, 'plain')
            msg.attach(body)

            with smtplib.SMTP(smtp_host, smtp_port) as server:
                server.starttls()
                server.login(smtp_username, smtp_password)
                server.send_message(msg)

            logger.debug("Email notification sent")
        except Exception as e:
            logger.error(f"Failed to send email notification: {e}")
