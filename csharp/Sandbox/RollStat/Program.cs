using System.Text;


namespace RollStat;


internal class Program {

	private static readonly List<int> _data = [];
	private static double _average;
	private static double _median;

	private static void Main() => Run();

	private static void Run() {
		while (true) {
			Draw();
			ReadInt();
		}
	}

	private static void ReadInt() {
		if (!int.TryParse(Console.ReadLine(), out int value)) return;

		_data.Add(value);
		_average = _data.Average();
		_median = CalculateMedian();
	}

	private static void Draw() {
		StringBuilder sb = new();

		sb.AppendLine("Roll Stat");
		sb.AppendLine("--------");
		sb.AppendLine("Rolls: " + string.Join(", ", _data));
		sb.AppendLine("--------");
		sb.AppendLine("Count: " + _data.Count);
		sb.AppendLine("Sum: " + _data.Sum());
		sb.AppendLine("Average: " + _average);
		sb.AppendLine("Median: " + _median);
		sb.AppendLine("--------");
		sb.Append("Enter a number: ");

		Console.Clear();
		Console.SetCursorPosition(0, 0);
		Console.Write(sb.ToString());
	}

	private static double CalculateMedian() {
		int[] sorted = [.. _data.Order()];
		int size = sorted.Length;

		if (size == 0) return 0;

		return size % 2 == 1 ? sorted[size / 2] : (sorted[size / 2 - 1] + sorted[size / 2]) / 2.0;
	}
}

