import asyncio
import logging

import config as Config
import bot.bot as Bot


logging.basicConfig(
    level=logging.WARNING,
    format=Config.LOG_FORMAT,
    datefmt=Config.DATE_FORMAT,
    handlers=[logging.FileHandler(Config.LOG_PATH), logging.StreamHandler()]
)
logger: logging.Logger = logging.getLogger(__name__)


def main() -> None:
    logger.info("Start...")

    loop: asyncio.AbstractEventLoop = asyncio.get_event_loop()

    Bot.init(loop)

    loop.run_forever()


if __name__ == "__main__": main()
