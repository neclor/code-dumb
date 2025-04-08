import sys
import math
import pygame


SKY: pygame.Color = pygame.Color("#7fbfff")
BLUE: pygame.Color = pygame.Color("#0000ff")
RED: pygame.Color = pygame.Color("#ff0000")
BLACK: pygame.Color = pygame.Color("#000000")
GRAY: pygame.Color = pygame.Color("#808080")


RESOLUTION: tuple[int, int] = (800, 600)  # (800, 600)
FPS: int = 25


K: int = 1000
R: float = 0.02
L: float = 0.06
B: float = 0.5


surface: pygame.Surface
clock: pygame.time.Clock
font: pygame.font.Font


motor_angle: float = 0
counter: int = 0
motor_current: float = 0
motor_speed: float = 0


def main() -> None:
    init()
    run()


def init() -> None:
    global surface, clock, font
    pygame.init()
    pygame.key.set_repeat(10, 10)
    clock = pygame.time.Clock()
    surface = pygame.display.set_mode(RESOLUTION)
    font = pygame.font.SysFont("monospace", 16)


def run() -> None:
    while True:
        delta: float = clock.get_time() / 1000
        check_input()
        update_motor(delta)
        draw()
        update()


def check_input() -> None:
    global counter
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
        elif event.type == pygame.KEYDOWN:
            if event.key == pygame.K_SPACE:
                counter = 5

def update() -> None:
    pygame.display.set_caption(str(round(clock.get_fps())))
    pygame.display.flip()
    clock.tick(FPS)


def draw() -> None:
    surface.fill(SKY)
    draw_engine()
    draw_table()


def draw_engine() -> None:
    global motor_angle

    WINDOW_CENTER: tuple[int, int] = (RESOLUTION[0] // 2, RESOLUTION[1] // 2)
    CIRCLE_RADIUS: int = 100
    CIRCLE_OUTLINE: int = 20

    pygame.draw.rect(surface, RED, (WINDOW_CENTER[0] - 2 * CIRCLE_RADIUS, WINDOW_CENTER[1] - CIRCLE_RADIUS, 2 * CIRCLE_RADIUS, 2 * CIRCLE_RADIUS))
    pygame.draw.rect(surface, BLUE, (WINDOW_CENTER[0], WINDOW_CENTER[1] - CIRCLE_RADIUS, 2 * CIRCLE_RADIUS, 2 * CIRCLE_RADIUS))

    pygame.draw.circle(surface, SKY, WINDOW_CENTER, CIRCLE_RADIUS + CIRCLE_OUTLINE)
    pygame.draw.circle(surface, GRAY, WINDOW_CENTER, CIRCLE_RADIUS)

    motor_position: pygame.Vector2 = pygame.Vector2(
        WINDOW_CENTER[0] + math.cos(motor_angle) * (CIRCLE_RADIUS - CIRCLE_OUTLINE),
        WINDOW_CENTER[1] + math.sin(motor_angle) * (CIRCLE_RADIUS - CIRCLE_OUTLINE)
    )

    pygame.draw.circle(surface, BLACK, motor_position, CIRCLE_OUTLINE)


def draw_table() -> None:
    surface.blit(font.render(f"Current: {motor_current:.2f} A", True, BLACK), (50, 40))


def update_motor(delta: float) -> None:
    global motor_current, motor_angle, motor_speed
    update_motor_current()

    J: float = 1
    c: float = 0.2

    torque: float = 2 * R * (get_winding_current() * (K * L) * B) * math.cos(motor_angle)
    torque_friction: float = c * motor_speed

    angular_acceleration: float = (torque - torque_friction) / J
    motor_angle += motor_speed * delta + angular_acceleration * (delta ** 2) / 2
    motor_angle = math.fmod(motor_angle, 2 * math.pi)

    motor_speed += angular_acceleration * delta


def update_motor_current() -> None:
    global counter, motor_current
    if counter == 0:
        motor_current = 0
        return
    counter -= 1
    motor_current = 1


def get_winding_current() -> float:
    HALF_PI: float = math.pi / 2

    if (HALF_PI < motor_angle < 3 * HALF_PI):
        return -motor_current
    return motor_current


if __name__ == "__main__": main()
