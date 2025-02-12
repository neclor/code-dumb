using System;
using System.ComponentModel;
using System.Drawing;
using System.Numerics;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Threading;

namespace AutoClicker;

internal static class AutoClicker {
    [DllImport("user32.dll", SetLastError = true)]
    private static extern bool SetCursorPos(int X, int Y);

    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    static extern bool GetCursorPos(out POINT lpPoint);

    [DllImport("user32.dll", CharSet = CharSet.Auto, CallingConvention = CallingConvention.StdCall)]
    private static extern void mouse_event(uint dwFlags, uint dx, uint dy, uint cButtons, uint dwExtraInfo);
    private const int MOUSEEVENTF_LEFTDOWN = 0x0002;
    private const int MOUSEEVENTF_LEFTUP = 0x0004;





    private volatile static bool pause = true;
    private static int clickNumber = 0;


    private static List<Vector2> clickPoints = new List<Vector2>();


    static void Main() {
        try {
            Console.CursorVisible = false;
            Thread inputHandler = new Thread(Input);
            InputHandler.Start();
            //InputHandler.Input += ;





            while(true) {
                if(pause) continue;       
                    MouseClick(new Vector2(500, 500));
            }
        }
        catch(Exception error) {
            Console.Error.WriteLine(error.Message);
        }
    }

    private static void Input(InputHandler.Key key) {
        try {
            if (key == InputHandler.Key.Tilde) {
                pause = !pause;
            }
            if(key == InputHandler.Key.LeftMouseButton && pause) {
                clickPoints.Add(new Vector2(500, 500));



            }



                while(true) {
                if(GetAsyncKeyState(VK_ESCAPE) != 0 && !escPressed) {
                    pause = !pause;
                    escPressed = true;
                    Console.WriteLine("Pause: " + pause);
                }
                else if(GetAsyncKeyState(VK_ESCAPE) == 0 && escPressed) {
                    escPressed = false;
                }
            }
        }
        catch(Exception error) {
            Console.Error.WriteLine(error.Message);
        }
    }


    private static void Input() {
        try {
            while(true) {
                if(GetAsyncKeyState(VK_ESCAPE) != 0 && !escPressed) {
                    pause = !pause;
                    escPressed = true;
                    Console.WriteLine("Pause: " + pause);
                }
                else if(GetAsyncKeyState(VK_ESCAPE) == 0 && escPressed) {
                    escPressed = false;
                }
            }
        }
        catch(Exception error) {
            Console.Error.WriteLine(error.Message);
        }



    }






    private static void MouseClick(Vector2 position) {
        if(!SetCursorPos((int)position.X, (int)position.Y)) {
            throw new Win32Exception();
        }
        mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
        mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
        clickNumber++;
        Console.WriteLine(clickNumber);
        Thread.Sleep(50);
    }
}
