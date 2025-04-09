import logging

import asyncio
from telethon.sync import TelegramClient, events

from datetime import datetime

import bot
import birthday_manager


logging.basicConfig(
	#filename = "bot.log",
	level = logging.INFO,
	format = "[%(levelname)s %(asctime)s] %(name)s: %(message)s",
	datefmt='%Y-%m-%d %H:%M:%S',
	handlers = [
        logging.FileHandler("bot.log"),
        logging.StreamHandler()])
logger: logging.Logger = logging.getLogger(__name__)


def launch() -> None:
	logger.info("Launch...")

	loop: asyncio.AbstractEventLoop = asyncio.get_event_loop()
	loop.create_task(bot.connection())

	loop.run_forever()
	logger.info("Finish")


async def happy_birthday() -> None:
	for birthday in birthday_manager.get_birthdays():
		pass

	pass











if __name__ == "__main__":
	launch()
