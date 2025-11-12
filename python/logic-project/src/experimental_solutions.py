from pysat.solvers import Glucose3
import time

from solution_template import *


def main() -> None:
    test_function(solution_1)
    #test_function(solution_2)


def test_function(function) -> None:
    start_time = time.time()
    function(8, 8, 0, 0)
    end_time = time.time()
    execution_time = end_time - start_time
    print(f"{function.__name__} - {execution_time:.4f}s")


def solution_1(height: int, width: int, row_0: int, column_0: int) -> tuple[list[list[int]], Glucose3, list[int]]:
    check_bounds(height, width, row_0, column_0)

    solver: Glucose3 = Glucose3()
    add_constraints(solver, height, width)
    solver.add_clause([var_c(height, width, row_0, column_0, 0)])

    solution: list[list[int]] = get_solution(solver, height, width)

    cell_count: int = height * width
    variables: list[int] = [var_i(cell_count, i, turn) for i in range(cell_count) for turn in range(cell_count)]
    return solution, solver, variables


def solution_2(height: int, width: int, row_0: int, column_0: int) -> tuple[list[list[int]], Glucose3, list[int]]:
    check_bounds(height, width, row_0, column_0)

    cell_count: int = height * width
    solver: Glucose3 = Glucose3()

    def var_c(row: int, column: int, turn: int) -> int:
        if not (0 <= row < height and 0 <= column < width): return 0
        return var_i(row * width + column, turn)

    def var_i(index: int, turn: int) -> int:
        if not (0 <= index < cell_count): return 0
        return turn * cell_count + index + 1


    def add_turn_constraints() -> None: # At each turn, only one cell is visited
        for turn in range(cell_count):
            solver.add_clause([var_i(i, turn) for i in range(cell_count)]) # At least one cell is visited

            for i in range(cell_count - 1):
                for j in range(i + 1, cell_count):
                    solver.add_clause([-var_i(i, turn), -var_i(j, turn)]) # At most one cell is visited

    def add_cell_constraints() -> None: # Each cell is visited exactly once
        for i in range(cell_count):
            solver.add_clause([var_i(i, turn) for turn in range(cell_count)]) # Cell is visited at least once

            for turn_1 in range(cell_count - 1):
                for turn_2 in range(turn_1 + 1, cell_count):
                    solver.add_clause([-var_i(i, turn_1), -var_i(i, turn_2)]) # Cell is visited at most once

    def add_knight_move_constraints() -> None: # Moves are valid knight moves
        for turn in range(cell_count - 1):
            for row_1 in range(height):
                for column_1 in range(width):
                    for row_2 in range(height):
                        for column_2 in range(width):
                            delta: tuple[int, int] = (row_2 - row_1, column_2 - column_1)
                            if delta not in KNIGHT_MOVES:
                                solver.add_clause([-var_c(row_1, column_1, turn), -var_c(row_2, column_2, turn + 1)])

    solver.add_clause([var_c(row_0, column_0, 0)])

    add_turn_constraints()
    add_knight_move_constraints()
    add_cell_constraints()

    solution: list[list[int]] = [[-1 for _ in range(width)] for _ in range(height)]

    if solver.solve():
        model: list[int] | None = solver.get_model()
        if model is not None:
            for turn in range(cell_count):
                for row in range(height):
                    for column in range(width):
                        if model[var_c(row, column, turn) - 1] > 0:
                            solution[row][column] = turn

    variables: list[int] = [var_i(i, turn) for i in range(cell_count) for turn in range(cell_count)]
    return solution, solver, variables

if __name__ == '__main__': main()
