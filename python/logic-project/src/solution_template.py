from pysat.solvers import Glucose3
import random

def question1(M: int, N: int, i0: int, j0: int) -> tuple[list[list[int]], Glucose3, list[int]]:
    height: int = M
    width: int = N
    row_0: int = i0
    column_0: int = j0

    if height <= 0: raise ValueError("Height must be positive.")
    if width <= 0: raise ValueError("Width must be positive.")
    if not (0 <= row_0 < height): raise ValueError("Starting row out of bounds.")
    if not (0 <= column_0 < width): raise ValueError("Starting column out of bounds.")




    soluton: list[list[int]] = [[-1 for _ in range(width)] for _ in range(height)]
    solver: Glucose3 = Glucose3()







    # YOUR CODE HERE




    # YOUR CODE HERE

    return solution, solver, variables

def question3():
    nb_sol = 0

    # YOUR CODE HERE

    return nb_sol

def question4():
    nb_sol = 0

    # YOUR CODE HERE

    return nb_sol

def question5(M, N,i0,j0):
    constraints = []

    # YOUR CODE HERE

    return constraints
