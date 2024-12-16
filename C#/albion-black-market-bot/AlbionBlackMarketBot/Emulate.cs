using System.Runtime.InteropServices;

namespace AlbionBlackMarketBot;

public partial class Emulate
{
    [DllImport("user32.dll", CharSet = CharSet.Auto, CallingConvention = CallingConvention.StdCall)]
    public static extern void mouse_event(uint dwFlags, uint dx, uint dy, uint cButtons, uint dwExtraInfo);

    public static void MouseClick(Point position)
    {
        const int MOUSEEVENTF_LEFTDOWN = 0x0002;
        const int MOUSEEVENTF_LEFTUP = 0x0004;

        Cursor.Position = position;

        Thread.Sleep(10);

        mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);

        Thread.Sleep(200);

        mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);

        Thread.Sleep(1000);
    }

    public static void TextWrite(string text)
    {
        SendKeys.Send(text);
        Thread.Sleep(500);
    }

    public static string CopyText()
    {
        SendKeys.SendWait("^c");

        string text = Clipboard.GetText();

        return text;
    }
}
