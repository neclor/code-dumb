from typing import Tuple
import pygame

from .node_3d import *


class Model3D(Node3D):
	def __init__(self) -> None:
		super().__init__()

		self.offset: pygame.Vector3 = pygame.Vector3(0, 0, 0)
		self.vertices: list[pygame.Vector3] = []
		self.polygons: list[Tuple[int, ...]] = []



	# Node3D
	@Node3D.rotation.setter
	def rotation(self, new_euler_rotation: pygame.Vector3) -> None:
		self.__euler_rotation = new_euler_rotation.copy()
		self.update_basis()
