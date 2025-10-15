namespace BookManager;

internal class LibraryManager {

	private const string AddCommand = "add";
	private const string RemoveCommand = "remove";
	private const string DisplayCommand = "display";
	private const string FindCommand = "find";
	private const string CheckCommand = "check";
	private const string HelpCommand = "help";
	private const string ExitCommand = "exit";

	private const int MaxBorrowed = 3;

	private static readonly (string Title, bool Borrowed)?[] _books = new (string Title, bool Borrowed)?[5];
	private static int _borrowedCount = 0;

	private static void Main() {
		Init();
		Run();
	}

	private static void Init() {
		Console.WriteLine("LibraryManager");
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

	private static void TryAddBook() {
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
	private static void ShowHelp() => Console.WriteLine($"Commands: {HelpCommand}, {AddCommand}, {RemoveCommand}, " +
		$"{DisplayCommand}, {FindCommand}, {CheckCommand} (for borrow and return), {ExitCommand}");

	private static bool FindBookIndex(string title, out int index) {
		index = Array.FindIndex(_books, b => b?.Title.Equals(title, StringComparison.OrdinalIgnoreCase) ?? false);
		if (index == -1) {
			Console.WriteLine("There is no such book in the library.");
			return false;
		}
		return true;
	}

	private static bool TryReadTitle(out string title) {
		Console.Write("Enter the book title: ");
		string? input = Console.ReadLine()?.Trim();
		if (string.IsNullOrEmpty(input)) {
			Console.WriteLine("Book title cannot be empty.");
			title = "";
			return false;
		}
		title = input;
		return true;
	}
}
