import sys
import math
import pygame







class Complex:
	def __init__(self: "Complex", real: float = 0, imaginary: float = 0) -> None:
		self.r: float = real
		self.i: float = imaginary


	def __add__(self: "Complex", other: "Complex") -> "Complex":
		return Complex(self.r + other.r, self.i + other.i)


	def __mul__(self: "Complex", other: "Complex") -> "Complex":
		return Complex(self.r * other.r - self.i * other.i, self.r * other.i + self.i * other.r)


	def __truediv__(self: "Complex", other: "Complex") -> "Complex":
		pass
		return Complex()


	def conj(self: "Complex") -> "Complex":
		return Complex(self.r, -self.i)


	def abs(self: "Complex") -> float:
		pass
		return 0


	def from_polar(self: "Complex"):
		pass

