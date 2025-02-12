using System;
using System.IO;
using System.IO.Ports;
using System.Diagnostics;

class Ultrasonic
{
    static void Main()
    {

        using (StreamWriter w = new StreamWriter(@"C:\Users\neclor\Desktop\Ultrasonic.txt")) {
            var port = new SerialPort("COM6");
            port.Open();
            port.ReadLine();
            port.ReadLine();
            while (true) {
                Double distance = Double.Parse(port.ReadLine());
                if (distance < 150) {
                    w.WriteLine(DateTime.Now);
                    w.Flush();
                }
            }
        }
    }
}