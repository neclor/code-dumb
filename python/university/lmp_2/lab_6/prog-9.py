import sys
import math
import pygame


SKY: pygame.Color = pygame.Color("#7fbfff")
BLUE: pygame.Color = pygame.Color("#0000ff")
RED: pygame.Color = pygame.Color("#ff0000")
BLACK: pygame.Color = pygame.Color("#000000")
GRAY: pygame.Color = pygame.Color("#808080")


RESOLUTION: tuple[int, int] = (800, 600)  # (800, 600)
FPS: int = 100


K: int = 0
R: float = 0
L: float = 0

B: pygame.Vector2 = pygame.Vector2(0, 0)


surface: pygame.Surface
clock: pygame.time.Clock
font: pygame.font.Font


motor_angle: float = 0


def main() -> None:
    init()
    run()


def init() -> None:
    global surface, clock, font
    pygame.init()
    clock = pygame.time.Clock()
    surface = pygame.display.set_mode(RESOLUTION)
    font = pygame.font.SysFont("monospace", 16)


def run() -> None:
    while True:
        delta: float = clock.get_time() / 1000
        draw()
        update()
        check_input()


def check_input() -> None:
    global mobile, electric_field, magnetic_field, cyclotron_mode
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
        elif event.type == pygame.KEYDOWN:
            pass


def update() -> None:
    pygame.display.set_caption(str(round(clock.get_fps())))
    pygame.display.flip()
    clock.tick(FPS)


def draw() -> None:
    surface.fill(SKY)
    draw_engine()
    # draw_table()


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
    surface.blit(font.render(f"Electric field: {electric_field.y:.2f} V/m", True, BLACK), (200, 40))
    surface.blit(font.render(f"Magnetic field: {magnetic_field:.2f} T", True, BLACK), (200, 80))

    kinetic_energy: float = mobile.mass * mobile.velocity.length_squared() / 2 * 10 ** 6
    surface.blit(font.render(f"Kinetic energy: {kinetic_energy:.2f} μJ", True, BLACK), (200, 120))




def calculate_laplace_force(i: float) -> float:
    L



    force += electric_field * mobile.charge
    force += mobile.velocity.cross(magnetic_field) * mobile.charge
    return force








if __name__ == "__main__": main()
