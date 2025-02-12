using System.Diagnostics;
using CsvHelper;

namespace AlbionBlackMarketBot;

internal static class Program
{
    public static Point screenSize;

    /// <summary>
    ///  The main entry point for the application.
    /// </summary>
    [STAThread]
    static void Main()
    {
        Init();
        // To customize application configuration such as set high DPI settings or default font,
        // see https://aka.ms/applicationconfiguration.
        ApplicationConfiguration.Initialize();
        Application.Run(new MainForm());
    }

    static void Init()
    {
        Console.WriteLine("Start");
        DataFunction.CreateItemPrice();
        DataFunction.LoadItemPrice();

        Console.WriteLine("Loaded price:");
        foreach(var (key, val) in Data.itemPrice)
        {
            Console.WriteLine($"{key}, {val[0]}, {val[1]}, {val[2]}, {val[3]}, {val[4]}");
        }
    }
}
