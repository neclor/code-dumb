import logging
from telethon.sync import TelegramClient, events

import config as Config
import status_monitor as StatusMonitor


TELEGRAM_MESSAGE_LIMIT: int = 4096


logger: logging.Logger = logging.getLogger(__name__)


def setup_client(client: TelegramClient) -> None:
    client.on(events.NewMessage(pattern="/help"))(help_handler)
    client.on(events.NewMessage(pattern="/status"))(status_handler)
    client.on(events.NewMessage(pattern="/logs"))(logs_handler)
    client.on(events.NewMessage(pattern="/clearlogs"))(clearlogs_handler)


async def help_handler(event) -> None:
    await event.respond(
"""
Commands:
- /help: Show help
- /status: Show status
- /logs: Show logs
- /clearlogs: Clear logs
"""
    )


async def status_handler(event) -> None:
    await event.respond(StatusMonitor.get_status())


async def logs_handler(event) -> None:
    logs: str = ""
    try:
        with open(Config.LOG_PATH, "r") as log_file:
            logs = log_file.read()
            if len(logs) > TELEGRAM_MESSAGE_LIMIT: logs = logs[-TELEGRAM_MESSAGE_LIMIT:]
    except Exception as e:
        logger.error(f"Logs reading error: {e}")
        await event.respond(f"Logs reading error: {e}")
        return

    await event.respond(Config.LOG_PATH + ":\n" + logs)


async def clearlogs_handler(event) -> None:
    try:
        with open(Config.LOG_PATH, "w") as log_file:
            log_file.write("")
        logger.info("Logs have been cleared")
    except Exception as e:
        await event.respond(f"Logs clearing error: {e}")
        return

    await event.respond("Logs have been cleared")
