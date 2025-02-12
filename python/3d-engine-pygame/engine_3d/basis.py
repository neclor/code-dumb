import math
import pygame


class Basis:
	def __init__(self) -> None:
		self.matrix: list[list[float]] = [
			[1, 0, 0],
			[0, 1, 0],
			[0, 0, 1]]


	def set_euler(self, euler_rotation: pygame.Vector3) -> None:
		self.matrix = Basis().matrix
		# Rotation order YXZ
		self.rotate_y(euler_rotation.y)
		self.rotate_x(euler_rotation.x)
		self.rotate_z(euler_rotation.z)


	def scale(self, scale: pygame.Vector3) -> None:
		scale_basis: Basis = Basis()
		scale_basis.matrix = [
			[scale.x, 0, 0],
			[0, scale.y, 0],
			[0, 0, scale.z]]
		self.matrix = scale_basis.mul(self).matrix


	def rotate_x(self, angle_x: float) -> None:
		x_rotation_basis: Basis = Basis()
		x_rotation_basis.matrix = [
			[1, 0, 0],
			[0, math.cos(angle_x), -math.sin(angle_x)],
			[0, math.sin(angle_x), math.cos(angle_x)]]
		self.matrix = self.mul(x_rotation_basis).matrix


	def rotate_y(self, angle_y: float) -> None:
		y_rotation_basis: Basis = Basis()
		y_rotation_basis.matrix = [
			[math.cos(angle_y), 0, math.sin(angle_y)],
			[0, 1, 0],
			[-math.sin(angle_y), 0, math.cos(angle_y)]]
		self.matrix = self.mul(y_rotation_basis).matrix


	def rotate_z(self, angle_z: float) -> None:
		z_rotation_basis: Basis = Basis()
		z_rotation_basis.matrix = [
			[math.cos(angle_z), -math.sin(angle_z), 0],
			[math.sin(angle_z), math.cos(angle_z), 0],
			[0, 0, 1]]
		self.matrix = self.mul(z_rotation_basis).matrix


	def mul(self, basis: "Basis") -> "Basis":
		result: Basis = Basis()
		for i in range(3):
			for j in range(3):
				r: float = 0.0
				for k in range(3):
					r += self.matrix[i][k] * basis.matrix[k][j]
				result.matrix[i][j] = r
		return result


	def mul_vector3(self, vector3: pygame.Vector3) -> pygame.Vector3:
		result: pygame.Vector3 = pygame.Vector3(0, 0, 0)
		for i in range(3):
			r: float = 0.0
			for k in range(3):
				r += self.matrix[i][k] * vector3[k]
			result[i] = r
		return result


	def copy(self) -> "Basis":
		copy: Basis = Basis()
		copy.matrix = self.matrix
		return copy
