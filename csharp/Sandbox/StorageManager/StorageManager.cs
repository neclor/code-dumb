using System.Text;

namespace StorageManager;

internal class LibraryManager {

	private const string AddCommand = "add";
	private const string UpdateCommand = "add";
	private const string RemoveCommand = "remove";
	private const string ListCommand = "list";
	private const string HelpCommand = "help";
	private const string ExitCommand = "exit";

	private static readonly Storage _stroage = new();

	private static void Main() {
		Init();
		Run();
	}

	private static void Init() {
		Console.WriteLine("StorageManager");
		ShowHelp();
		Console.WriteLine("-------");
	}

	private static void Run() {
		while (true) {
			ReadCommand();
		}
	}

	private static void ReadCommand() {
		Console.Write("> ");
		switch (Console.ReadLine()?.Trim().ToLower()) {
			case AddCommand:
				TryAddBook();
				break;
			case RemoveCommand:
				TryRemoveBook();
				break;
			case DisplayCommand:
				DisplayBooks();
				break;
			case FindCommand:
				FindBook();
				break;
			case CheckCommand:
				CheckBook();
				break;
			case HelpCommand:
				ShowHelp();
				break;
			case ExitCommand:
				Environment.Exit(0);
				break;
			default:
				Console.WriteLine("Wrong command, try again");
				break;
		}
	}


	private static void TryAdd() {
		if (!TryReadName(out string name)) return;








		int index = Array.IndexOf(_books, null);

		if (index == -1) {
			Console.WriteLine("Library is full. Cannot add more books.");
			return;
		}

		if (!TryReadTitle(out string title)) return;

		_books[index] = (title, false);
		Console.WriteLine($"\"{title}\" added.");
	}

	private static void TryRemoveBook() {
		if (_books.All(s => s is null)) {
			Console.WriteLine("Library is empty.");
			return;
		}

		if (!TryReadTitle(out string title)) return;
		if (!FindBookIndex(title, out int index)) return;

		if (_books[index]!.Value.Borrowed) _borrowedCount--;
		_books[index] = null;
		Console.WriteLine($"\"{title}\" removed.");
	}

	private static void DisplayBooks() {
		if (_books.All(s => s is null)) {
			Console.WriteLine("Library is empty.");
			return;
		}

		foreach (var book in _books) {
			if (book is null) continue;
			Console.WriteLine($"\"{book.Value.Title}\" {(book.Value.Borrowed ? "Borrowed" : "")}");
		}
	}

	private static void FindBook() {
		if (!TryReadTitle(out string title)) return;
		if (!FindBookIndex(title, out int index)) return;

		Console.WriteLine($"Book in the library {(_books[index]!.Value.Borrowed ? "and borrowed" : "")}");
	}

	private static void CheckBook() {
		if (!TryReadTitle(out string title)) return;
		if (!FindBookIndex(title, out int index)) return;

		var temp = _books[index]!.Value;
		temp.Borrowed = !temp.Borrowed;

		if (_books[index]!.Value.Borrowed) {
			_borrowedCount--;
			_books[index] = temp;
			Console.WriteLine($"\"{title}\" has been returned");
			return;
		}

		if (_borrowedCount >= MaxBorrowed) {
			Console.WriteLine($"You have already borrowed the maximum number ({MaxBorrowed}) of books.");
			return;
		}

		_borrowedCount++;
		_books[index] = temp;
		Console.WriteLine($"\"{title}\" has been borrowed");
	}

	private static bool FindBookIndex(string title, out int index) {
		index = Array.FindIndex(_books, b => b?.Title.Equals(title, StringComparison.OrdinalIgnoreCase) ?? false);
		if (index == -1) {
			Console.WriteLine("There is no such book in the library.");
			return false;
		}
		return true;
	}




	private static void ShowHelp() => Console.WriteLine($"Commands: {HelpCommand}, {AddCommand}, " +
		$"{UpdateCommand}, {ListCommand}, {ExitCommand}");

	private static bool TryReadName(out string name) {
		Console.Write("Enter the name: ");
		string? input = Console.ReadLine()?.Trim();
		if (string.IsNullOrEmpty(input)) {
			Console.WriteLine("Name cannot be empty.");
			name = "";
			return false;
		}
		name = input;
		return true;
	}

	private static bool TryReadInt(string prompt, out int value) {
		Console.Write(prompt);
		string? input = Console.ReadLine()?.Trim();
		if (!int.TryParse(input, out value)) {
			Console.WriteLine("Invalid number.");
			value = 0;
			return false;
		}
		return true;
	}
}


internal class Storage {

	private readonly List<Product> _products = [];

	public bool TryAddProduct(string name, uint price = 1, uint quantity = 1) {
		if (Contains(name)) return false;

		_products.Add(new(name, price, quantity));
		return true;
	}

	public bool Contains(string name) => FindIndex(name) != -1;

	public int FindIndex(string name) => _products.FindIndex(p => string.Equals(name, p.Name, StringComparison.OrdinalIgnoreCase));

	public bool RemoveProduct(string name) {
		int index = FindIndex(name);
		if (index == -1) return false;
		_products.RemoveAt(index);
		return true;
	}

	public override string ToString() {
		StringBuilder sb = new();
		foreach (Product p in _products) {
			sb.AppendLine(p.ToString());
		}
		return sb.ToString();
	}

	private class Product(string name, int price, int quantity) {

		public string Name { get; set; } = name;
		public int Price { get; set; } = price;
		public int Quantity { get; set; } = quantity;

		public override string ToString() => $"{{Name: {Name}, Price: {Price}, Quantity: {Quantity}}}";
	}
}
