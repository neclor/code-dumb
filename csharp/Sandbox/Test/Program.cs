using MathLibrary;


namespace Test;


internal class Program {

	public static void Main() {
		DeterminantTest();
		LinearSolverTest();
	}

	private static void DeterminantTest() {
		Matrix<float> matrix = new(4, 4, [
				1, 0, 0, 1,
				0, 1, 0, 0,
				1, 0, 1, 1,
				2, 3, 1, 1
			]
		);
		Console.WriteLine(matrix);
		Console.WriteLine(matrix.Determinant());
	}

	private static void LinearSolverTest() {
		Matrix<float> matrix = new(3, 4, [
				0, 1, 2, 2,
				-1, 2, -3, 3,
				1, 2, 1, 0,
			]
		);

		Console.WriteLine(matrix);
		Console.WriteLine(LinearSolver.Solve(matrix));
	}
}
