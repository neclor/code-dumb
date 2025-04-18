import asyncio
from datetime import datetime
import logging
from telethon.sync import TelegramClient

from api_keys import *
import bot.command_handler as CommandHandler
import server_manager as StatusMonitor


RETRY_DEALY: int = 30
STATUS_UPDATE_DELAY: int = 5 * 60


logger: logging.Logger = logging.getLogger(__name__)


bot: TelegramClient = TelegramClient(MY_SESSION_NAME, API_ID, API_HASH)
last_status_message_id: int | None = None


def init(loop: asyncio.AbstractEventLoop) -> None:
    CommandHandler.setup_client(bot)

    loop.create_task(connect())
    loop.create_task(update_status())


async def connect() -> None:
    while True:
        try:
            logger.info("Connecting...")
            async with bot:
                logger.info("Connected successfully")
                await bot.run_until_disconnected()
        except Exception as e:
            logger.warning(f"Connection error: {e}: wait {RETRY_DEALY} seconds...")
            await asyncio.sleep(RETRY_DEALY)


async def update_status() -> None:
    global last_status_message_id
    while True:
        try:
            status_message = await bot.send_message("me", StatusMonitor.get_status())

            try:
                if last_status_message_id is not None: await bot.delete_messages("me", last_status_message_id)
            except Exception as e:
                logger.warning(f"Deleting message error: {e}")

            last_status_message_id = status_message.id
        except Exception as e:
            logger.warning(f"Error updating status: {e}")

        await asyncio.sleep(STATUS_UPDATE_DELAY)
