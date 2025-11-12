from pysat.solvers import Glucose3
import random


KNIGHT_MOVES: list[tuple[int, int]] = [(1, 2), (2, 1), (2, -1), (1, -2), (-1, -2), (-2, -1), (-2, 1), (-1, 2)]


def question1(M: int, N: int, i0: int, j0: int) -> tuple[list[list[int]], Glucose3, list[int]]:
    height, width, row_0, column_0 = M, N, i0, j0
    check_bounds(height, width, row_0, column_0)

    cells_count: int = height * width
    solver: Glucose3 = Glucose3()

    add_constraints(height, width, solver)
    solver.add_clause([variable_by_coords(height, width, row_0, column_0, 0)])

    solution: list[list[int]] = get_solution(height, width, solver)
    variables: list[int] = [variable_by_index(cells_count, i, turn) for i in range(cells_count) for turn in range(cells_count)]
    return solution, solver, variables


def question3() -> int:
    height: int = 3
    width: int = 4

    solution_count: int = 0

    for row in range(height):
        for column in range(width):
            solver: Glucose3 = Glucose3()
            add_constraints(height, width, solver)
            solver.add_clause([variable_by_coords(height, width, row, column, 0)])
            while True:
                if not solver.solve(): break
                model: list[int] | None = solver.get_model()
                if model is None: break
                solver.add_clause([-var for var in model])
                solution_count += 1

    return solution_count


def question4():
    return question3() / 4


def question5(M: int, N: int, i0: int, j0: int) -> list[list[int]]:
    height, width, row_0, column_0 = M, N, i0, j0
    check_bounds(height, width, row_0, column_0)

    cells_count: int = height * width
    solver: Glucose3 = Glucose3()

    add_constraints(height, width, solver)
    solver.add_clause([variable_by_coords(height, width, row_0, column_0, 0)])




    constraints: list[list[int]] = [[1]]



    # YOUR CODE HERE

    return constraints


#region Helper functions
def get_solution(height: int, width: int, solver: Glucose3) -> list[list[int]]:
    cells_count: int = height * width
    solution: list[list[int]] = [[-1 for _ in range(width)] for _ in range(height)]
    if solver.solve():
        model: list[int] | None = solver.get_model()
        if model is not None:
            for turn in range(cells_count):
                for row in range(height):
                    for column in range(width):
                        if model[variable_by_coords(height, width, row, column, turn) - 1] > 0:
                            solution[row][column] = turn
    return solution


def add_constraints(height: int, width: int, solver: Glucose3) -> None:
    cells_count: int = height * width

    def var_c(row: int, column: int, turn: int = 0) -> int:
        return variable_by_coords(height, width, row, column, turn)

    def var_i(index: int, turn: int = 0) -> int:
        return variable_by_index(cells_count, index, turn)

    def add_turn_constraints() -> None: # At each turn, only one cell is visited
        for turn in range(cells_count):
            solver.add_clause([var_i(i, turn) for i in range(cells_count)]) # At least one cell is visited

            for i in range(cells_count - 1):
                for j in range(i + 1, cells_count):
                    solver.add_clause([-var_i(i, turn), -var_i(j, turn)]) # At most one cell is visited

    def add_cell_constraints() -> None: # Each cell is visited exactly once
        for i in range(cells_count):
            solver.add_clause([var_i(i, turn) for turn in range(cells_count)]) # Cell is visited at least once

            for turn_1 in range(cells_count - 1):
                for turn_2 in range(turn_1 + 1, cells_count):
                    solver.add_clause([-var_i(i, turn_1), -var_i(i, turn_2)]) # Cell is visited at most once

    def add_knight_move_constraints() -> None: # Moves are valid knight moves
        for turn in range(cells_count - 1):

            for row_1 in range(height):
                for column_1 in range(width):

                    next_positions: list[int] = []
                    for delta_row, delta_column in KNIGHT_MOVES:
                        row_2: int = row_1 + delta_row
                        column_2: int = column_1 + delta_column
                        if not (0 <= row_2 < height and 0 <= column_2 < width): continue
                        next_positions.append(var_c(row_2, column_2, turn + 1))

                    solver.add_clause([-var_c(row_1, column_1, turn)] + next_positions)

    add_cell_constraints()
    add_turn_constraints()
    add_knight_move_constraints()


def variable_by_coords(height: int, width: int, row: int, column: int, turn: int = 0) -> int:
    if not (0 <= row < height and 0 <= column < width): return 0
    return variable_by_index(height * width, row * width + column, turn)


def variable_by_index(cells_count: int, index: int, turn: int = 0) -> int:
    if not (0 <= index < cells_count): return 0
    return turn * cells_count + index + 1


def check_bounds(height: int, width: int, row_0: int, column_0: int) -> None:
    if height <= 0: raise ValueError("Height must be positive.")
    if width <= 0: raise ValueError("Width must be positive.")
    if not (0 <= row_0 < height): raise ValueError("Starting row out of bounds.")
    if not (0 <= column_0 < width): raise ValueError("Starting column out of bounds.")
#endregion
