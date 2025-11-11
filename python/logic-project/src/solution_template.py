from pysat.solvers import Glucose3
import random


_KNIGHT_MOVES: list[tuple[int, int]] = [(1, 2), (2, 1), (2, -1), (1, -2), (-1, -2), (-2, -1), (-2, 1), (-1, 2)]


def main() -> None:
    print(question1(5, 5, 0, 0)[0])


def question1(M: int, N: int, i0: int, j0: int) -> tuple[list[list[int]], Glucose3, list[int]]:
    height, width, row_0, column_0 = M, N, i0, j0
    _check_bounds(height, width, row_0, column_0)

    def var_c(row: int, column: int, turn: int = 0) -> int:
        return _variable_by_coords(height, width, row, column, turn)

    def var_i(index: int, turn: int = 0) -> int:
        return _variable_by_index(height, width, index, turn)

    cells_count: int = height * width
    solver: Glucose3 = Glucose3()

    # The starting position is visited
    solver.add_clause([var_c(row_0, column_0, 0)])

    # At each turn, only one cell is visited
    for turn in range(cells_count):
        solver.add_clause([var_i(i, turn) for i in range(cells_count)]) # At least one cell is visited

        for i in range(cells_count - 1):
            for j in range(i + 1, cells_count):
                solver.add_clause([-var_i(i, turn), -var_i(j, turn)]) # At most one cell is visited

    # Each cell is visited exactly once
    for i in range(cells_count):
        solver.add_clause([var_i(i, turn) for turn in range(cells_count)]) # Cell is visited at least in one turn

        for turn_1 in range(cells_count - 1):
            for turn_2 in range(turn_1 + 1, cells_count):
                solver.add_clause([-var_i(i, turn_1), -var_i(i, turn_2)]) # Cell is visited at most once

    # Moves are valid knight moves
    for turn in range(cells_count - 1):
        for row_1 in range(height):
            for column_1 in range(width):
                for row_2 in range(height):
                    for column_2 in range(width):
                        delta: tuple[int, int] = (row_2 - row_1, column_2 - column_1)
                        if delta not in _KNIGHT_MOVES:
                            solver.add_clause([-var_c(row_1, column_1, turn), -var_c(row_2, column_2, turn + 1)])

    solution: list[list[int]] = [[-1 for _ in range(width)] for _ in range(height)]

    if solver.solve():
        model: list[int] | None = solver.get_model()
        if model is not None:
            for turn in range(cells_count):
                for row in range(height):
                    for column in range(width):
                        if model[var_c(row, column, turn) - 1] > 0:
                            solution[row][column] = turn

    variables: list[int] = [var_i(i, turn) for i in range(cells_count) for turn in range(cells_count)]
    return solution, solver, variables


def question3():
    nb_sol = 0

    # YOUR CODE HERE

    return nb_sol


def question4():
    nb_sol = 0

    # YOUR CODE HERE

    return nb_sol


def question5(M: int, N: int, i0: int, j0: int) -> list[list[int]]:
    height, width, row_0, column_0 = M, N, i0, j0
    _check_bounds(height, width, row_0, column_0)

    constraints: list[list[int]] = [[1]]



    # YOUR CODE HERE

    return constraints


#region Helper functions
def _variable_by_coords(height: int, width: int, row: int, column: int, turn: int = 0) -> int:
    if (not (0 <= row < height)) or (not (0 <= column < width)): return 0
    return _variable_by_index(height, width, row * width + column, turn)


def _variable_by_index(height: int, width: int, index: int, turn: int = 0) -> int:
    if not (0 <= index < height * width): return 0
    return turn * height * width + index + 1


def _check_bounds(height: int, width: int, row_0: int, column_0: int) -> None:
    if height <= 0: raise ValueError("Height must be positive.")
    if width <= 0: raise ValueError("Width must be positive.")
    if not (0 <= row_0 < height): raise ValueError("Starting row out of bounds.")
    if not (0 <= column_0 < width): raise ValueError("Starting column out of bounds.")
#endregion


if __name__ == '__main__': main()
