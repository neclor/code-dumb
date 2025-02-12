from typing import Tuple
import math
import pygame


from .node_3d import *


class AABB(Node3D):
	def __init__(self) -> None:
		super().__init__()

		self.layer: int = 0
		self.__min_point: pygame.Vector3 = pygame.Vector3(0, 0, 0)
		self.__max_point: pygame.Vector3 = pygame.Vector3(0, 0, 0)


	def collide(self, aabb: "AABB") -> bool:
		if self.layer != aabb.layer:
			return False
		if not(self.__max_point.x >= aabb.min_point.x and self.__min_point.x <= aabb.max_point.x):
			return False
		if not(self.__max_point.y >= aabb.min_point.y and self.__min_point.y <= aabb.max_point.y):
			return False
		if not(self.__max_point.z >= aabb.min_point.z and self.__min_point.z <= aabb.max_point.z):
			return False
		return True


	@property
	def min_point(self) -> pygame.Vector3:
		return self.__min_point


	@property
	def max_point(self) -> pygame.Vector3:
		return self.__max_point


	def set_points(self, new_points: Tuple[pygame.Vector3, pygame.Vector3]) -> None:
		self.__min_point.x = min(new_points[0].x, new_points[1].x)
		self.__min_point.y = min(new_points[0].y, new_points[1].y)
		self.__min_point.z = min(new_points[0].z, new_points[1].z)

		self.__max_point = new_points[0] + new_points[1] - self.__min_point
