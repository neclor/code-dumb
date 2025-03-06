import sys
import random
import pygame


BLACK: pygame.Color = pygame.Color(0, 0, 0)
WHITE: pygame.Color = pygame.Color(255, 255, 255)


RESOLUTION: tuple[int, int] = (800, 800)
FPS: int = 60


clock: pygame.time.Clock
surface: pygame.Surface


line_position_x: int = 400


def main() -> None:
	init()
	run()


def init() -> None:
	global clock, surface
	pygame.init()
	clock = pygame.time.Clock()
	surface = pygame.display.set_mode(RESOLUTION)


def run() -> None:
	global line_position_x
	while True:
		check_exit()
		draw()
		line_position_x += generate_trial() - 100
		update()


def check_exit():
	for event in pygame.event.get():
		if event.type == pygame.QUIT:
			pygame.quit()
			sys.exit()


def generate_trial() -> int:
	sum: int = 0
	for _ in range(200):
		sum += random.randint(0, 1)
	return sum


def draw() -> None:
	surface.fill(BLACK)
	pygame.draw.line(surface, WHITE, (line_position_x, 0), (line_position_x, 800))


def update() -> None:
	pygame.display.set_caption(str(round(clock.get_fps())))
	pygame.display.flip()
	clock.tick(FPS)


if __name__ == "__main__": main()
