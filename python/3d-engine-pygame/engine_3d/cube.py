import pygame


from .model_3d import *


def create_cube() -> Model3D:
	size: int = 10
	cube: Model3D = Model3D()
	cube.position = pygame.Vector3(0, 0, -50)
	cube.offset = pygame.Vector3(size / 2, size / 2, size / 2)
	cube.vertices = [
		pygame.Vector3(0, 0, 0),
		pygame.Vector3(size, 0, 0),
		pygame.Vector3(0, size, 0),
		pygame.Vector3(0, 0, size),
		pygame.Vector3(size, size, 0),
		pygame.Vector3(size, 0, size),
		pygame.Vector3(size, 0, size),
		pygame.Vector3(size, size, size)]

	cube.polygons = [
		[1, 2, 4],
		[1, 3, 4],
		[1, 2, 6],
		[1, 5, 6],
		[5, 6, 8],
		[5, 7, 8],
		[8, 4, 3],
		[8, 7, 3],
		[4, 2, 8],
		[2, 8, 6],
		[3, 1, 7],
		[1, 7, 5]]

	return cube
