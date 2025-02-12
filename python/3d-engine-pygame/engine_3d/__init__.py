import sys
import pygame
from pygame.locals import *


from renderer_3d import *
from .basis import *
from .node_3d import *
from .camera_3d import *
from .model_3d import *
from .aabb import *


class Engine3D:
	def __init__(self) -> None:
		pygame.init()

		self.__clock: pygame.time.Clock = pygame.time.Clock()
		self.__renderer_3d = Renderer3D()
		self.root_node: Node3D = Node3D()

		self.fps: int = 60


	def update(self) -> None:
		self.__check_events()
		pygame.display.set_caption(str(round(self.__clock.get_fps())))
		self.__renderer_3d.update()
		self.__clock.tick(self.fps)


	def __check_events(self) -> None:
		for event in pygame.event.get():
			if event.type == pygame.QUIT or pygame.K_ESCAPE:
				pygame.quit()
				sys.exit()
			elif event.type == pygame.K_F11:
				pygame.display.toggle_fullscreen()
