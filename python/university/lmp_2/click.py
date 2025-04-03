import pyautogui
import keyboard
import time


def main() -> None:
    run()


def run() -> None:
    while not keyboard.is_pressed('q'):
        pyautogui.click()
        time.sleep(0.001)


if __name__ == "__main__": main()
