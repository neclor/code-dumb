import logging
import subprocess
from telethon.sync import TelegramClient, events, Button

import config as Config
import server_manager as ServerManager


TELEGRAM_MESSAGE_LIMIT: int = 100


logger: logging.Logger = logging.getLogger(__name__)


def setup_client(client: TelegramClient) -> None:
    client.on(events.NewMessage(pattern=r"/help"))(help_handler)
    client.on(events.NewMessage(pattern=r"/status"))(status_handler)
    client.on(events.NewMessage(pattern=r"/logs"))(logs_handler)
    client.on(events.NewMessage(pattern=r"/clearlogs"))(clearlogs_handler)
    client.on(events.NewMessage(pattern=r"/gitpull"))(gitpull_handler)
    client.on(events.NewMessage(pattern=r"/restart"))(restart_handler)


async def help_handler(event) -> None:
    description: str ="""
Commands list:
- /help: Show help
- /status: Show status
- /logs: Show logs
- /clearlogs: Clear logs
- /gitpull: Pull from git
- /restart: Restart bot
"""
    await event.respond(description)


async def status_handler(event) -> None:
    await event.respond(ServerManager.get_status())


async def logs_handler(event) -> None:
    logs: str = ""
    try:
        with open(Config.LOG_PATH, "r") as log_file:
            logs = log_file.read()
            if len(logs) > TELEGRAM_MESSAGE_LIMIT:
                logs = logs[-TELEGRAM_MESSAGE_LIMIT:]
    except Exception as e:
        logger.error(f"Logs reading error: {e}")
        await event.respond(f"Logs reading error: {e}")
        return

    try:
        await event.respond(Config.LOG_PATH + ":\n" + logs)
    except Exception as e:
        logger.error(f"Logs sending error: {e}")
        await event.respond(f"Logs sending error: {e}")
        logger.warning(logs)


async def clearlogs_handler(event) -> None:
    try:
        with open(Config.LOG_PATH, "w") as log_file:
            log_file.write("")
        logger.info("Logs have been cleared")
    except Exception as e:
        logger.error(f"Logs clearing error: {e}")
        await event.respond(f"Logs clearing error: {e}")
        return

    await event.respond("Logs have been cleared")


async def gitpull_handler(event) -> None:
    try:
        result: subprocess.CompletedProcess[str] = ServerManager.git_pull()
        if result.returncode != 0: raise Exception(result.stderr)
        await event.respond("Git pull completed")
    except Exception as e:
        logger.error(f"Git pull error: {e}")
        await event.respond(f"Git pull error: {e}")


async def restart_handler(event) -> None:
    try:
        ServerManager.terminate_service()
    except Exception as e:
        logger.error(f"Service termination error: {e}")
        await event.respond(f"Service termination error: {e}")
