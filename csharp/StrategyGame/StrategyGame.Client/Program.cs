using Microsoft.AspNetCore.Components.WebAssembly.Hosting;

namespace StrategyGame.Client;

internal class Program {

	private static async Task Main(string[] args) {
		WebAssemblyHostBuilder builder = WebAssemblyHostBuilder.CreateDefault(args);
		await builder.Build().RunAsync();
	}
}
