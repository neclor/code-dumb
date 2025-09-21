using MathLibrary;


namespace Test;


internal class Program {

	public static void Main() {
		Matrix<float> matrix = new(4, 5, [
			1, 2, 3, 4, 1,
			1, 0, 1, 0, 2,
			0, 1, 2, 2, 3,
			1, -1, 2, 0, 4]
		);


		Console.WriteLine(matrix);
		Console.WriteLine(LinearSolver.Solve(matrix));
	}
}
