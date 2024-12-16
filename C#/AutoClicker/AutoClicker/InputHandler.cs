using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace AutoClicker;

internal static class InputHandler {
    [DllImport("user32.dll")]
    private static extern short GetAsyncKeyState(int vKey);

    internal enum Key {
        Tilde = 0xC0,
        LeftMouseButton = 0x01,
    }
    private static readonly Dictionary<Key, bool> keyState = new Dictionary<Key, bool>() {
        {Key.Tilde, false},
        {Key.LeftMouseButton, false},
    };

    internal delegate void InputEvent(object sender, Key key);
    internal static event InputEvent Input;

    internal static void Start() {
        Thread inputHandler = new Thread(CheckInput);
        inputHandler.Start();
    }

    internal static void CheckInput() {
        try {
            while(true) {
                foreach(int key in Enum.GetValues(typeof(Key))) {


                    if (GetAsyncKeyState(key) != 0 && keyState[Key.GetName(typeof(int), key)]) {



                    }
                }


                if(GetAsyncKeyState(VK_TILDE) != 0 && !escPressed) {
                    pause = !pause;
                    escPressed = true;
                    Console.WriteLine("Pause: " + pause);
                }
                else if(GetAsyncKeyState(VK_TILDE) == 0 && escPressed) {
                    escPressed = false;
                }

                if(GetAsyncKeyState(VK_TILDE) != 0 && !escPressed) {
                    pause = !pause;
                    escPressed = true;
                    Console.WriteLine("Pause: " + pause);
                }
                else if(GetAsyncKeyState(VK_TILDE) == 0 && escPressed) {
                    escPressed = false;
                }






            }
        }
        catch(Exception error) {
            Console.Error.WriteLine(error.Message);
        }


        static void CheckKey(int VK) {
            if(GetAsyncKeyState(VK) != 0 && !escPressed) {
                pause = !pause;
                escPressed = true;
                Console.WriteLine("Pause: " + pause);
            }


        }




}

}
