import sys
import math
import pygame


K: float = 8.9876 * (10 ** 9)
ABS_OBJECT_CHARGE: float = 10 ** -6
ABS_MOBILE_CHARGE: float = ABS_OBJECT_CHARGE


BLUE: pygame.Color = pygame.Color("#7fbfff")
RED: pygame.Color = pygame.Color("#ff0000")
BLACK: pygame.Color = pygame.Color("#000000")


RESOLUTION: tuple[int, int] = (1600, 900)
FPS: int = 60


class Obj:
    def __init__(self: "Obj", new_position: pygame.Vector2, new_charge: float) -> None:
        self.position: pygame.Vector2 = new_position
        self.charge: float = new_charge


    def draw(self: "Obj") -> None:
        pygame.draw.circle(surface, RED if self.charge > 0 else BLACK, self.position, 10)


class Mobile(Obj):
    def __init__(self: "Mobile", new_position: pygame.Vector2, new_charge: float) -> None:
        super().__init__(new_position, new_charge)
        self.velocity: pygame.Vector2 = pygame.Vector2()
        self.mass: float = 10 ** -10


    def draw(self: "Mobile") -> None:
        pygame.draw.circle(surface, RED if self.charge > 0 else BLACK, self.position, 10, 4)


    def update(delta: float) -> None:

        clock.get_time() / 1000

        pass


surface: pygame.Surface
clock: pygame.time.Clock


objects: list[Obj] = []
mobile: Mobile | None = None


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
        if mobile is not None: mobile.update()
        draw()


def check_input() -> None:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
        elif event.type == pygame.MOUSEBUTTONDOWN:
            if event.button == 1:
                objects.append(Obj(pygame.Vector2(event.pos)), ABS_OBJECT_CHARGE)
            elif event.button == 3:
                objects.append(Obj(pygame.Vector2(event.pos)), -ABS_OBJECT_CHARGE)
        elif event.type == pygame.KEYDOWN:
            global mobile
            if event.key == pygame.K_p:
                mobile = Mobile(pygame.mouse.get_pos(), ABS_MOBILE_CHARGE)
            elif event.key == pygame.K_n:
                mobile = Mobile(pygame.mouse.get_pos(), -ABS_MOBILE_CHARGE)


def update() -> None:
    pygame.display.set_caption(str(round(clock.get_fps())))
    pygame.display.flip()
    clock.tick(FPS)


def update_mobile() -> None:
    pass


def draw() -> None:
    surface.fill(BLUE)
    for obj in objects: obj.draw()
    if mobile is not None: mobile.draw()


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
