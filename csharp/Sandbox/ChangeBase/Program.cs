using System.Numerics;
using MathLibrary;

namespace ChangeBase;

internal class Program {

	private static readonly Vector4 _a = new(-1,-1, 0, 5);
	private static readonly Vector4 _b = new(4, 4,-3, 5);
	private static readonly Vector4 _c = new(4,-2, 4, 0);
	private static readonly Vector4 _d = new(-4,-3,-4,-4);

	private static readonly Vector4 _v = new(-3, 4, 4, 1);

	private static void Main() {

		Matrix<float> matrix = new(4, 5, [
				_a.X, _b.X, _c.X, _d.X, _v.X,
				_a.Y, _b.Y, _c.Y, _d.Y, _v.Y,
				_a.Z, _b.Z, _c.Z, _d.Z, _v.Z,
				_a.W, _b.W, _c.W, _d.W, _v.W,
			]
		);

		Console.WriteLine(LinearSolver.Solve(matrix));
	}
}
