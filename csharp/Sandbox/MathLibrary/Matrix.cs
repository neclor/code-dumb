using System.Numerics;


namespace MathLibrary;


#pragma warning disable CA1814
public class Matrix<T> : IEquatable<Matrix<T>>, ICloneable where T : INumber<T> {

	private readonly T[,] _data;

	public int Rows { get; }
	public int Columns { get; }

	public Matrix(int rows, int columns) {
		if (rows <= 0) throw new ArgumentOutOfRangeException(nameof(rows), "Number of rows must be positive.");
		if (columns <= 0) throw new ArgumentOutOfRangeException(nameof(columns), "Number of columns must be positive.");

		Rows = rows;
		Columns = columns;
		_data = new T[rows, columns];
	}

	public Matrix(T[,] initialValues) {
		ArgumentNullException.ThrowIfNull(initialValues);
		if (initialValues.GetLength(0) == 0 || initialValues.GetLength(1) == 0) throw new ArgumentException("Initial values array must have positive dimensions.", nameof(initialValues));

		Rows = initialValues.GetLength(0);
		Columns = initialValues.GetLength(1);
		_data = (T[,])initialValues.Clone();
	}

	public Matrix(Matrix<T> other) {
		ArgumentNullException.ThrowIfNull(other);

		Rows = other.Rows;
		Columns = other.Columns;
		_data = (T[,])other._data.Clone();

	}

	public T this[int row, int column] {
		get {
			return row < 0 || row >= Rows
				? throw new ArgumentOutOfRangeException(nameof(row), "Row index out of range.")
				: column < 0 || column >= Columns
				? throw new ArgumentOutOfRangeException(nameof(column), "Column index out of range.")
				: _data[row, column];
		}
		set {
			if (row < 0 || row >= Rows) throw new ArgumentOutOfRangeException(nameof(row), "Row index out of range.");
			if (column < 0 || column >= Columns) throw new ArgumentOutOfRangeException(nameof(column), "Column index out of range.");
			_data[row, column] = value;
		}
	}

	public Matrix<T> SetValue(int row, int column, T value) {
		CheckBounds(row, column);
		Matrix<T> newMatrix = (Matrix<T>)Clone();
		newMatrix._data[row, column] = value;
		return newMatrix;
	}




	public bool Equals(Matrix<T>? other) {




		if (other is null || Rows != other.Rows || Columns != other.Columns) return false;

		for (int y = 0; y < Rows; y++) {
			for (int x = 0; x < Columns; x++) {
				if (_data[y, x] != other._data[y, x]) return false;
			}
		}





		return true;
	}

	public object Clone() {

		return new Matrix<T>(this);

	}









	private void CheckBounds(int row, int column) {
		if (row < 0 || row >= Rows) throw new ArgumentOutOfRangeException(nameof(row), "Row index out of range.");
		if (column < 0 || column >= Columns) throw new ArgumentOutOfRangeException(nameof(column), "Column index out of range.");
	}


}
#pragma warning restore CA1814
