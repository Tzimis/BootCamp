using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mobile
{
    delegate int Transformer(int x);
    class Program
    {
        static void Main(string[] args)
        {
            Battery b1 = new Battery(Battery.BatteryType.NiCd, 2510);
            Screen s1 = new Mobile.Screen(728, 1024, 220);
            Device galaxy = new Device("Galaxy 3", "Samsung", 549.99m, s1, b1);
            Device iPhone7 = Device.getIPhone7();
            Device nokia = Device.getNokia();

            Console.WriteLine(galaxy);
            Console.WriteLine(iPhone7);
            Console.WriteLine(nokia);

            Call c1 = new Call(new DateTime(2016, 10, 18, 16, 55, 32), 
                               new DateTime(2016, 10, 18, 17, 04, 22), 
                               Call.CallType.Incoming);
            Call c2 = new Call(new DateTime(2016, 10, 18, 23, 58, 12),
                               new DateTime(2016, 10, 19, 00, 04, 54),
                               Call.CallType.Outgoing);
            Call c3 = new Call(new DateTime(2016, 10, 19, 12, 45, 54),
                               new DateTime(2016, 10, 19, 16, 22, 59),
                               Call.CallType.Incoming);

            Usage galaxyUsage = new Usage(galaxy, "iOS 10.0.2");
            galaxyUsage.AddCall(c1);
            galaxyUsage.AddCall(c2);
            galaxyUsage.AddCall(c3);
            galaxyUsage.NewCall(Call.CallType.Outgoing);
            System.Threading.Thread.Sleep(1340);
            galaxyUsage.EndCall();

            Console.WriteLine("\nUsage Info:");
            Console.WriteLine(galaxyUsage.Device + $" Battery: {galaxyUsage.BatteryPercentage:00.0}%.");
            Console.WriteLine(galaxyUsage.GetCallHistory());


            galaxyUsage.RemoveCall(c1);
            Console.WriteLine("\nUsage Info:");
            Console.WriteLine(galaxyUsage.Device);
            Console.WriteLine(galaxyUsage.GetCallHistory());

            galaxyUsage.ClearHistory();
            Console.WriteLine("\nUsage Info:");
            Console.WriteLine(galaxyUsage.Device);
            Console.WriteLine(galaxyUsage.GetCallHistory());

            Transformer S = Square;
            Console.WriteLine($"Square of 4 is {S(4)}.");

            Console.ReadKey();
        }
        public static int Square(int x) =>  x * x;
    }
}
