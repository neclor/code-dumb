using System.Numerics;

namespace MathLibrary;


public static class LinearSolver {

	public static Matrix<T> Solve<T>(Matrix<T> matrix) where T : IFloatingPointIeee754<T> {
		ArgumentNullException.ThrowIfNull(matrix, nameof(matrix));

		for (int column = 0; column < matrix.Columns - 1; column++) {

			bool nonZeroRowExist = false;
			for (int row = column; row < matrix.Rows; row++) {

				if (matrix[row, column] == T.Zero) continue;

				// Console.WriteLine(matrix);

				if (!nonZeroRowExist) {
					nonZeroRowExist = true;
					matrix = matrix.DivideRow(row, matrix[row, column]).SwapRows(column, row);
					continue;
				}

				matrix = matrix.AddMultipliedRow(row, column, -matrix[row, column]);
			}
		}

		for (int column = matrix.Columns - 2; column > 0; column--) {
			for (int row = 0; row < column; row++) {
				matrix = matrix.AddMultipliedRow(row, column, -matrix[row, column]);
			}
		}

		return matrix;
	}
}
