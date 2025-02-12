from typing import Optional
from typing import Tuple
import pygame
from pygame.locals import *


from .node_3d import *
from .camera_3d import *
from .model_3d import *


class Renderer3D:
	def __init__(self) -> None:
		self.__surface: pygame.Surface
		self.__camera: Optional[Camera3D]
		self.resolution = (1152, 648)


	def draw_node_3d(self, root_node: Node3D) -> None:
		self.__surface.fill((0, 0, 0))
		if self.__camera is not None:
			self.__draw_node_3d_recursive(root_node)
		pygame.display.flip()


	def __draw_node_3d_recursive(self, node: Node3D) -> None:
		if isinstance(node, Model3D):
			self.__draw_model_3d(node)

		for child in node.children:
			self.__draw_node_3d_recursive(child)


	def __draw_model_3d(self, model: Model3D) -> None:
		model
		self.__camera


	for vertice in model.vertices:
		global_vertices.append(model_global_position + vector3_rotate(vertice - model.offset, model_global_rotation))

	x/ -z / tan(fov / 2)

	@property
	def camera(self) -> Optional[Camera3D]:
		return self.__camera


	@camera.setter
	def camera(self, new_camera: Optional[Camera3D]) -> None:
		self.__camera = new_camera
		if not self.__camera is None:
			self.__camera.set_fov(self.__camera.fov_h, self.__surface.get_size())


	@property
	def resolution(self) -> Tuple[int, int]:
		return self.__surface.get_size()


	@resolution.setter
	def resolution(self, new_resolution: Tuple[int, int]) -> None:
		self.__surface = pygame.display.set_mode(new_resolution)
