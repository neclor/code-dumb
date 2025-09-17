using MathLibrary;

namespace LinearSolver;


#pragma warning disable CA1814
internal class Program {

	static void Main(string[] args) {



		Matrix<string>? a = null;


		float[,] test = {
			{ 1, 2, 3, 4 },
			{ 1, 0, 1, 0 },
			{ 0, 1, 2, 2 },
			{ 1, -1, 2, 0}
		};




		Console.WriteLine("Hello, World!");

		float[] result = Solve(test);

	}


	float[] Solve(float[,] matrix) {
		List<float> result = new();

		int height = matrix.GetLength(0);
		int width = matrix.GetLength(1);

		float[][] m = new float[height][];

		for (int y = 0; y < height; y++) {
			m[y] = new float[width];
			for (int x = 0; x < width; x++) {
				m[y][x] = matrix[y, x];
			}
		}

		for (int x = 0; x < width; x++) {

			int line = -1;
			for (int y = 0; y < height; y++) {
				if (m[y][x] != 0) {
					line = y;
					break;
				}
			}





		}



		return result.ToArray();
	}


	float[,] SwapLines(float[,] matrix, int a, int b) {
		for (int x = 0; x < matrix.GetLength(1); x++) {
			float temp = matrix[a, x];
			matrix[a, x] = matrix[b, x];
			matrix[b, x] = temp;
		}
		return matrix;
	}

	float[,] MulLine(float[,] matrix, int a, int b)


	float[,] AddLines(float[,] matrix, int a, int b) {
		for (int x = 0; x < matrix.GetLength(1); x++) {
			float temp = matrix[a, x];
			matrix[a, x] = matrix[b, x];
			matrix[b, x] = temp;
		}
		return matrix;
	}



}
#pragma warning restore CA1814
