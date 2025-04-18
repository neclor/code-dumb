import asyncio
from datetime import timedelta
import logging
import psutil
import subprocess
import sys
import time

import config as Config


logger: logging.Logger = logging.getLogger(__name__)


def get_status() -> str:
    cpu_percent: float = psutil.cpu_percent(interval=1)
    memory_percent = psutil.virtual_memory().percent
    disk_percent = psutil.disk_usage("/").percent
    uptime = str(timedelta(seconds=int(time.time() - psutil.boot_time())))

    status_message: str = f"""
Server status:
- CPU Usage: {cpu_percent}%
- Memory Usage: {memory_percent}%
- Disk Usage: {disk_percent}%
- Uptime: {uptime}
"""
    return status_message


def git_pull() -> subprocess.CompletedProcess[str]:
    return subprocess.run(["git", "pull"], capture_output=True, text=True)


def terminate_service() -> None:
    loop: asyncio.AbstractEventLoop = asyncio.get_event_loop()
    loop.stop()
    loop.close()
    logger.info("Exit")
    sys.exit()
