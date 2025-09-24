using MathLibrary;


namespace Test;


internal class Program {

	public static void Main() {
		DeterminantTest();
		InverseTest();
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
		Console.WriteLine("Determinant:");
		Console.WriteLine(matrix);
		Console.WriteLine(matrix.Determinant());
	}

	private static void InverseTest() {
		Matrix<float> matrix = new(4, 4, [
				2, 3, 2, 2,
				-1, -1, 0, -1,
				-2, -2, -2, -1,
				3, 2, 2, 2
			]
		);
		Console.WriteLine("Inverse:");
		Console.WriteLine(matrix);
		Console.WriteLine(matrix.Inverse());
	}

	private static void LinearSolverTest() {
		Matrix<float> matrix = new(3, 4, [
				1, 1, 1, 1,
				1, 1, 2, 2,
				1, 2, 2, 1,
			]
		);
		Console.WriteLine("LinearSolver:");
		Console.WriteLine(matrix);
		Console.WriteLine(LinearSolver.Solve(matrix));
	}
}
