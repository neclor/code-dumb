import logging

import asyncio
from telethon.sync import TelegramClient, events

from datetime import datetime

import birthday_manager

import time
from api_data import *


logger: logging.Logger = logging.getLogger(__name__)

bot: TelegramClient = TelegramClient(MY_SESSION_NAME, API_ID, API_HASH)


async def connection() -> None:
	async with bot:
		try:
			logger.info("Connection...")
			await bot.run_until_disconnected()
		except Exception as e:
			logger.warning(e)
			logger.warning("Connection error, wait 5 seconds...")
			await asyncio.sleep(5)


@bot.on(events.NewMessage(pattern = "/start"))
async def start(event) -> None:
	await event.respond("Birthday commands:\n/add - add new birthday\n/remove - delete birthday")


@bot.on(events.NewMessage(pattern = "/add"))
async def add(event) -> None:
	await event.respond("")


@bot.on(events.NewMessage(pattern = "/remove"))
async def remove(event) -> None:
	await event.respond("")
