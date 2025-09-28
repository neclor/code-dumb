using MathLibrary;


namespace Test;


internal class Program {

	public static void Main() {
		DeterminantTest();
		InverseTest();
		PLUDecompositionTest();
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
		Matrix<float> matrix = new(3, 3, [
				1, 2, 3,
				0, 1, 4,
				5, 6, 0,
			]
		);
		Console.WriteLine("Inverse:");
		Console.WriteLine(matrix);
		Console.WriteLine(matrix.Inverse());
	}

	private static void PLUDecompositionTest() {
		Matrix<float> matrix = new(3, 3, [
				2, 3, 1,
				4, 7, 7,
				6, 18, 22,
			]
		);

		(Matrix<float> p, Matrix<float> l, Matrix<float> u) = matrix.PLUDecomposition();

		Console.WriteLine("PLU Decomposition:");
		Console.WriteLine(matrix);
		Console.WriteLine("PLU Product:");
		Console.WriteLine(p * (l * u));
		Console.WriteLine("P :");
		Console.WriteLine(p);
		Console.WriteLine("L :");
		Console.WriteLine(l);
		Console.WriteLine("U :");
		Console.WriteLine(u);
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
