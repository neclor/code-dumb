import sys
import math
import pygame


BLUE: pygame.Color = pygame.Color("#7fbfff")
RED: pygame.Color = pygame.Color("#ff0000")
BLACK: pygame.Color = pygame.Color("#000000")


RESOLUTION: tuple[int, int] = (1600, 900)
FPS: int = 60


K: float = 8.9876 * (10 ** 9)
ABS_OBJECT_CHARGE: float = 10 ** -6
ABS_MOBILE_CHARGE: float = ABS_OBJECT_CHARGE


surface: pygame.Surface
clock: pygame.time.Clock
previous_time: int = 0


objects: list[dict] = []
mobile: dict = {
    "exists": False,
    "position": pygame.Vector2(100, 100),
    "velocity": pygame.Vector2(),
    "charge": ABS_MOBILE_CHARGE,
    "mass": 10 ** -10
}


def main() -> None:
    init()
    run()


def init() -> None:
    global clock, surface
    pygame.init()
    clock = pygame.time.Clock()
    surface = pygame.display.set_mode(RESOLUTION)


def run() -> None:
    while True:
        check_input()
        update()
        draw()


def check_input() -> None:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
        elif event.type == pygame.MOUSEBUTTONDOWN:
            if event.button == 1:
                add_object(pygame.Vector2(event.pos), ABS_OBJECT_CHARGE)
            elif event.button == 3:
                add_object(pygame.Vector2(event.pos), -ABS_OBJECT_CHARGE)
        elif event.type == pygame.KEYDOWN:
            if event.key == pygame.K_p:
                create_mobile(pygame.Vector2(pygame.mouse.get_pos()), ABS_MOBILE_CHARGE)
            elif event.key == pygame.K_n:
                create_mobile(pygame.Vector2(pygame.mouse.get_pos()), -ABS_MOBILE_CHARGE)


def add_object(position: pygame.Vector2, charge: float) -> None:
    objects.append({
        "position": position,
        "charge": charge
    })


def create_mobile(position: pygame.Vector2, charge: float) -> None:
    mobile["exists"] = True
    mobile["position"] = position
    mobile["velocity"] = pygame.Vector2()
    mobile["charge"] = charge



def update_mobile() -> None:
    pass






def update() -> None:
    pygame.display.set_caption(str(round(clock.get_fps())))
    pygame.display.flip()
    clock.tick(FPS)


def draw() -> None:
    def draw_objects() -> None:
        for obj in objects:
            pygame.draw.circle(surface, RED if obj["charge"] > 0 else BLACK, obj["position"], 10)

    def draw_mobile() -> None:
        if not mobile["exists"]: return
        pygame.draw.circle(surface, RED if mobile["charge"] > 0 else BLACK, mobile["position"], 10, 4)

    surface.fill(BLUE)
    draw_objects()
    draw_mobile()


def calculate_coulomb_force(position: pygame.Vector2) -> pygame.Vector2:
    return mobile["charge"] * calculate_field_strength(position)


def calculate_field_strength(position: pygame.Vector2) -> pygame.Vector2:
    field_strength_vector: pygame.Vector2 = pygame.Vector2()
    for obj in objects:
        delta_vector: pygame.Vector2 = position - obj["position"]
        distance: float = delta_vector.length()
        if distance <= 20: continue
        normalized_delta_vector: pygame.Vector2 = delta_vector.normalize()
        field_strength: float = K * obj["charge"] / (distance ** 2)
        field_strength_vector += normalized_delta_vector * field_strength

    return field_strength_vector




if __name__ == "__main__":
    main()
