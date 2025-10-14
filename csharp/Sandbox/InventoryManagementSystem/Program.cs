
namespace InventoryManagementSystem;

internal class Programm {

	static void Main(string[] args) {
		Console.WriteLine("Hello, World!");
	}







}

internal class Inventory() {

	private readonly List<Item> _items = [];


	public void Add(string name, int price, int quantity) {

	}
		pass
	products.Add(new Product(name, price, quantity));


}

internal class Item(string name, int price, int quantity) {

	public string Name { get; set; } = name;
	public int Price { get; set; } = price;
	public int Quantity { get; set; } = quantity;
}
