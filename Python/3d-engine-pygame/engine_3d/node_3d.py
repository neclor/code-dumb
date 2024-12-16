from typing import Optional
import pygame


from .basis import *


class Node3D:
	def __init__(self) -> None:
		self.__euler_rotation: pygame.Vector3 = pygame.Vector3(0, 0, 0)
		self.__scale: pygame.Vector3 = pygame.Vector3(1, 1, 1)

		self.__local_position: pygame.Vector3 = pygame.Vector3(0, 0, 0)
		self.__local_basis: Basis = Basis()

		self.__global_position: pygame.Vector3 = pygame.Vector3(0, 0, 0)
		self.__global_basis: Basis = Basis()

		self.parent: Optional[Node3D] = None
		self.children: list[Node3D] = []


# Basis
	@property
	def rotation(self) -> pygame.Vector3:
		return self.__euler_rotation.copy()


	@rotation.setter
	def rotation(self, new_euler_rotation: pygame.Vector3) -> None:
		self.__euler_rotation = new_euler_rotation.copy()
		self.update_basis()


	@property
	def scale(self) -> pygame.Vector3:
		return self.__scale.copy()


	@scale.setter
	def scale(self, new_scale: pygame.Vector3) -> None:
		self.__scale = new_scale.copy()
		self.update_basis()


	@property
	def local_basis(self) -> Basis:
		return self.__local_basis.copy()


	@property
	def global_basis(self) -> Basis:
		return self.__global_basis.copy()


	def update_basis(self) -> None:
		self.__local_basis.set_euler(self.__euler_rotation)
		self.__local_basis.scale(self.__scale)

		if self.parent is not None:
			self.__global_basis = self.parent.global_basis.mul(self.__local_basis)
		else:
			self.__global_basis = self.__local_basis

		self.__update_children_basis()


	def __update_children_basis(self) -> None:
		for child in self.children:
			child.update_basis()


# Position
	@property
	def position(self) -> pygame.Vector3:
		return self.__local_position.copy()


	@position.setter
	def position(self, new_position: pygame.Vector3) -> None:
		self.__local_position = new_position.copy()
		self.update_global_position()


	@property
	def global_position(self) -> pygame.Vector3:
		return self.__global_position.copy()


	@global_position.setter
	def global_postion(self, new_global_position: pygame.Vector3) -> None:
		self.__global_position = new_global_position.copy()
		if self.parent is not None:
			self.__local_position = self.__global_position - self.parent.global_position

		self.__update_children_position()


	def update_global_position(self) -> None:
		if self.parent is not None:
			self.__global_position = self.parent.global_position + self.__local_position
		else:
			self.__global_position = self.__local_position

		self.__update_children_position()


	def __update_children_position(self) -> None:
		for child in self.children:
			child.update_global_position()


# Children
	def add_child(self, new_child: "Node3D") -> None:
		if not(new_child.parent is None):
			raise Exception("Node already have a parent")

		new_child.parent = self
		self.children.append(new_child)


	def remove_child(self, child: "Node3D") -> None:
		if child.parent != self:
			raise Exception("Node is not a child of this node")

		child.parent = None
		self.children.remove(child)


	def delete(self) -> None:
		for child in self.children:
			child.delete()
		if self.parent is not None:
			self.parent.children.remove(self)
