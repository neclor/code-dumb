import logging
import csv


logger = logging.getLogger(__name__)


BIRTHDAYS_LIST: str = "birthdays_list.csv"
BIRTHDAYS_LIST_FIELDNAMES: list[str] = ["name", "username", "datetime", "message"]

CONGRATULATED_TODAY: str = "congartulated_today.csv"


def add_bithday(new_birthday: dict) -> None:
	try:
		birthdays: list[dict] = get_birthdays()
		for birthday in birthdays:
			if new_birthday["name"] == birthday["name"]:
				raise Exception("Name already exist")

		with open(BIRTHDAYS_LIST, mode = "a", newline = "", encoding = "utf-8") as file:
			writer: csv.DictWriter = csv.DictWriter(file, BIRTHDAYS_LIST_FIELDNAMES)
			writer.writerow(new_birthday)

	except Exception as e:
		logger.warning(e)
		raise Exception(e)


def change_birthday(name: str, new_birthday: dict) -> None:
	try:
		birthdays: list[dict] = get_birthdays()
		for i in range(len(birthdays)):
			if name == birthdays[i]["name"]:
				for j in birthdays:
					if new_birthday["name"] != name and new_birthday["name"] == j["name"]:
						raise Exception("New name already exist")

				birthdays[i] = new_birthday
				write_birthdays(birthdays)
				return

		raise Exception("Name not found")
	except Exception as e:
		logger.warning(e)
		raise Exception(e)


def remove_birthday(name: str) -> None:
	try:
		birthdays: list[dict] = get_birthdays()
		for birthday in birthdays:
			if name == birthday["name"]:
				birthdays.remove(birthday)
				write_birthdays(birthdays)
				return

		raise Exception("Name not found")
	except Exception as e:
		logger.warning(e)
		raise Exception(e)


def get_birthdays() -> list[dict]:
	try:
		with open(BIRTHDAYS_LIST, "r", newline = "") as file:
			birthdays: csv.DictReader = csv.DictReader(file)
			return list(birthdays)

	except Exception as e:
		logger.error(e)
		raise Exception(e)


def write_birthdays(birthdays: list[dict]) -> None:
	try:
		with open(BIRTHDAYS_LIST, mode = "w", newline = "", encoding = "utf-8") as file:
			writer: csv.DictWriter = csv.DictWriter(file, BIRTHDAYS_LIST_FIELDNAMES)
			writer.writeheader()
			writer.writerows(birthdays)

	except Exception as e:
		logger.error(e)
		raise Exception(e)


def add_congratulated_today(new_name: str) -> None:
	try:
		names: list[str] = get_congratulated_today()
		for name in names:
			if new_name == name:
				raise Exception("Name already exist")

		with open(CONGRATULATED_TODAY, mode = "a", newline = "") as file:
			writer = csv.writer(file)
			writer.writerow([name])

	except Exception as e:
		logger.warning(e)
		raise Exception(e)


def remove_congratulated_today(name: str) -> None:
	try:
		names: list[str] = get_congratulated_today()
		for i in names:
			if name == i:
				names.remove(i)
				return

		raise Exception("Name not found")
	except Exception as e:
		logger.warning(e)
		raise Exception(e)


def get_congratulated_today() -> list[str]:
	try:
		with open(CONGRATULATED_TODAY, "r", newline = "") as congratulated_today:
			names = csv.reader(congratulated_today)
			return [name[0] for name in names]

	except Exception as e:
		logger.error(e)
		raise Exception(e)


def write_congratulated_today(names: list[str]) -> None:
	try:
		with open(CONGRATULATED_TODAY, mode = "w", newline = "", encoding = "utf-8") as congratulated_today:
			writer = csv.writer(congratulated_today)
			writer.writerows(names)

	except Exception as e:
		logger.error(e)
		raise Exception(e)
