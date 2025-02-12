from typing import Tuple
import math
import pygame

from .node_3d import *


class Camera3D(Node3D):
	def __init__(self) -> None:
		super().__init__()

		self.__fov: pygame.Vector2 = pygame.Vector2(0, 0)
		self.set_fov(math.pi / 2, (16, 9))


	@property
	def fov_h(self) -> float:
		return self.__fov.x


	def set_fov(self, new_fov_h: float, surface_size: Tuple[int, int]) -> None:
		FOV_MIN_H_ANGLE: float = math.pi / 3
		FOV_MAX_H_ANGLE: float = math.tau / 3

		self.__fov.x = pygame.math.clamp(new_fov_h, FOV_MIN_H_ANGLE, FOV_MAX_H_ANGLE)

		surface_ratio: float = surface_size[0] / surface_size[1]

		self.__fov.x = pygame.math.clamp(new_fov_h, FOV_MIN_H_ANGLE, FOV_MAX_H_ANGLE)
		self.__fov.y = math.atan(math.tan(self.__fov.x / 2) / surface_ratio) * 2
