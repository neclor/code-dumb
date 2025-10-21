namespace JACounter;

internal class Program {



	private const String Ja = """
     _   _    
    | | / \   
 _  | |/ _ \  
| |_| / ___ \ 
 \___/_/   \_\

""";

	private static void Main() {
		int counter = 0;

		while (true) {
			Console.SetCursorPosition(0, 0);
			Console.WriteLine($"JA: {counter}");
			ConsoleKeyInfo key = Console.ReadKey(true);
			if (key.Key == ConsoleKey.Enter) {
				counter++;
			}
			if (key.Key == ConsoleKey.OemMinus) {
				counter = int.Max(0, counter - 1);
			}

			Console.WriteLine(Ja);

		}
	}
}
