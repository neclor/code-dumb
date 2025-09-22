using System.Numerics;
using System.Text;


namespace MathLibrary;


public class Polynome<T> : IEquatable<Polynome<T>> where T : INumber<T> {

	private readonly T[] _data;

	public int Length => _data.Length;
	public T this[int degree] {
		get => GetValue(degree);
		set => SetValue(degree, value);
	}

	public Polynome(params T[] values) {
		ArgumentNullException.ThrowIfNull(values);
		if (values.Length == 0) throw new ArgumentException("Values array must not be empty", nameof(values));

		_data = (T[])values.Clone();
	}

	public static Polynome<T> operator +(Polynome<T> Polynome) => Polynome?.Clone() ?? throw new ArgumentNullException(nameof(Polynome));
	public static Polynome<T> operator -(Polynome<T> Polynome) => Polynome?.Negate() ?? throw new ArgumentNullException(nameof(Polynome));
	public static Polynome<T> operator +(Polynome<T> a, Polynome<T> b) => a?.Add(b) ?? throw new ArgumentNullException(nameof(a));
	public static Polynome<T> operator -(Polynome<T> a, Polynome<T> b) => a?.Subtract(b) ?? throw new ArgumentNullException(nameof(a));
	public static Polynome<T> operator *(Polynome<T> Polynome, T value) => Polynome?.Multiply(value) ?? throw new ArgumentNullException(nameof(Polynome));
	public static Polynome<T> operator *(T value, Polynome<T> Polynome) => Polynome * value;
	public static Polynome<T> operator *(Polynome<T> a, Polynome<T> b) => a?.Multiply(b) ?? throw new ArgumentNullException(nameof(a));
	public static Polynome<T> operator /(Polynome<T> Polynome, T value) => Polynome?.Divide(value) ?? throw new ArgumentNullException(nameof(Polynome));
	public static bool operator ==(Polynome<T> a, Polynome<T> b) => Equals(a, b);
	public static bool operator !=(Polynome<T> a, Polynome<T> b) => !(a == b);

	public Polynome<T> Clone() => new(_data);

	public T GetValue(int degree) => _data[degree];

	public Polynome<T> SetValue(int degree, T value) {
		CheckBounds(row, column);
		_data[Index(row, column)] = value;
		return this;
	}

	public Polynome<T> Plus() => Clone();

	public Polynome<T> Negate() => Multiply(-T.One);

	public Polynome<T> Add(Polynome<T> other) {
		ArgumentNullException.ThrowIfNull(other);
		if (Rows != other.Rows || Columns != other.Columns) throw new ArgumentException("The Polynome dimensions do not match", nameof(other));

		Polynome<T> result = Clone();
		for (int i = 0; i < Length; i++) {
			result._data[i] += other._data[i];
		}

		return result;
	}

	public Polynome<T> Subtract(Polynome<T> other) {
		ArgumentNullException.ThrowIfNull(other);
		if (Rows != other.Rows || Columns != other.Columns) throw new ArgumentException("The Polynome dimensions do not match", nameof(other));

		Polynome<T> result = Clone();
		for (int i = 0; i < Length; i++) {
			result._data[i] -= other._data[i];
		}

		return result;
	}

	public Polynome<T> Multiply(T value) {
		Polynome<T> result = Clone();
		for (int i = 0; i < Length; i++) {
			result._data[i] *= value;
		}

		return result;
	}

	public Polynome<T> Multiply(Polynome<T> other) {
		ArgumentNullException.ThrowIfNull(other);
		if (Columns != other.Rows) throw new ArgumentException("The Polynome dimensions do not match", nameof(other));

		Polynome<T> result = new(Rows, other.Columns);
		for (int rowA = 0; rowA < Rows; rowA++) {
			for (int columnA = 0; columnA < Columns; columnA++) {
				T valueA = _data[Index(rowA, columnA)];
				for (int columnB = 0; columnB < other.Columns; columnB++) {
					result._data[result.Index(rowA, columnB)] += valueA * other._data[other.Index(columnA, columnB)];
				}
			}
		}

		return result;
	}

	public Polynome<T> Divide(T value) {
		Polynome<T> result = Clone();
		for (int i = 0; i < Length; i++) {
			result._data[i] /= value;
		}

		return result;
	}

	public Polynome<T> Power(int value) {
		if (!IsSquare) throw new ArgumentException("Polynome should be square");
		if (value < 0) throw new ArgumentOutOfRangeException(nameof(value), "Value must be positive.");

		if (value == 0) return Identity(Rows);

		Polynome<T> result = Clone();
		for (int i = 1; i < value; i++) {
			result = result.Multiply(this);
		}

		return result;
	}

	public Polynome<T> SwapRows(int row1, int row2) {
		CheckBoundsRow(row1);
		CheckBoundsRow(row2);
		if (row1 == row2) return Clone();

		Polynome<T> result = Clone();
		for (int column = 0; column < Columns; column++) {
			(result._data[Index(row1, column)], result._data[Index(row2, column)]) = (result._data[Index(row2, column)], result._data[Index(row1, column)]);
		}

		return result;
	}

	public Polynome<T> MultiplyRow(int row, T value) {
		CheckBoundsRow(row);

		Polynome<T> result = Clone();
		for (int i = Index(row, 0); i < Index(row, Columns); i++) {
			result._data[i] *= value;
		}

		return result;
	}

	public Polynome<T> DivideRow(int row, T value) {
		CheckBoundsRow(row);

		Polynome<T> result = Clone();
		for (int i = Index(row, 0); i < Index(row, Columns); i++) {
			result._data[i] /= value;
		}

		return result;
	}

	public Polynome<T> AddMultipliedRow(int row1, int row2, T factor) {
		CheckBoundsRow(row1);
		CheckBoundsRow(row2);

		Polynome<T> result = Clone();
		for (int column = 0; column < Columns; column++) {
			result._data[Index(row1, column)] += result._data[Index(row2, column)] * factor;
		}
		return result;
	}

	public bool Equals(Polynome<T>? other) {
		if (other is null || Rows != other.Rows || Columns != other.Columns) return false;
		for (int row = 0; row < Rows; row++) {
			for (int column = 0; column < Columns; column++) {
				if (_data[Index(row, column)] != other._data[other.Index(row, column)]) return false;
			}
		}
		return true;
	}

	public override bool Equals(object? obj) => Equals(obj as Polynome<T>);

	public override int GetHashCode() {
		HashCode hash = new();

		hash.Add(Rows);
		hash.Add(Columns);

		foreach (T value in _data) {
			hash.Add(value);
		}

		return hash.ToHashCode();
	}

	public override string ToString() {
		StringBuilder stringBuilder = new();

		for (int row = 0; row < Rows; row++) {
			stringBuilder.Append("[ ");

			for (int column = 0; column < Columns; column++) {
				stringBuilder.Append(_data[Index(row, column)]);
				if (column < Columns - 1) stringBuilder.Append(", ");
			}

			stringBuilder.AppendLine(" ]");
		}

		return stringBuilder.ToString();
	}

	private static int Index(int row, int column, int columns) => row * columns + column;

	private int Index(int row, int column) => Index(row, column, Columns);

	private void CheckBounds(int row, int column) {
		CheckBoundsRow(row);
		CheckBoundsColumn(column);
	}

	private void CheckBoundsRow(int row) {
		if (row < 0 || row >= Rows) throw new ArgumentOutOfRangeException(nameof(row), "Row index out of range.");
	}

	private void CheckBoundsColumn(int column) {
		if (column < 0 || column >= Columns) throw new ArgumentOutOfRangeException(nameof(column), "Column index out of range.");
	}






}
