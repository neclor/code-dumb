namespace LinearSolver;


#pragma warning disable CA1814
internal static class FloatTwoDimensionalArrayExtensions {

	extension(float[,] m) {

		public float[,] SwapRow(int row, int row2) {
			for (int x = 0; x < m.GetLength(1); x++) {
				float temp = m[row, x];
				m[row, x] = m[row2, x];
				m[row2, x] = temp;
			}
			return m;
		}

		public float[,] MulRow(int row, float number) {
			for (int x = 0; x < m.GetLength(1); x++) {
				m[row, x] *= number; 
			}
			return m;
		}

		public float[,] DivRow(int row, float number) {
			for (int x = 0; x < m.GetLength(1); x++) {
				m[row, x] /= number;
			}
			return m;
		}

		public float[,] AddRow(int row, int row2) {
			return m.AddMultipliedRow(row, row2, 1);
		}

		public float[,] SubRow(int row, int row2) {
			for (int x = 0; x < m.GetLength(1); x++) {
				m[row, x] -= m[row2, x];
			}
			return m;
		}

		float[,] AddMultipliedRow(int row, int row2, float factor) {
			for (int x = 0; x < m.GetLength(1); x++) {
				m[row, x] += m[row2, x] * factor;
			}
			return m;
		}

		public float[,] SubMultipliedRow(int row, int row2, float factor) {
			for (int x = 0; x < m.GetLength(1); x++) {
				m[row, x] -= m[row2, x] * factor;
			}
			return m;
		}



	}
}
#pragma warning restore CA1814
