namespace console_winforms_app;

static class Program
{
    static bool bExit;

    static void MyConsoleFun()
    {
        for (int i = 0; !bExit; ++i) {
            Console.Write($" {i}");
            Thread.Sleep(2000);
        }
    }


    [STAThread]
    static void Main()
    {
        new Thread(MyConsoleFun).Start();
        Application.Run(new Form1());
        bExit = true;
    }
}