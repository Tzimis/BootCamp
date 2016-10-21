using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exc002___Cofee
{
    class Program
    {
        

        public class Cofee
        {
            public enum CofeeSize { Small = 100, Normal = 150, Double = 300 }

            public CofeeSize Size { get; private set; }

            public Cofee(CofeeSize size)
            {
                Size = size;
            }
        }

        public class Order
        {
            public List<Tuple<Cofee, double>> OrderItems { get; private set; }
            public double Cost { get; private set; }


            public Order()
            {
                OrderItems = new List<Tuple<Cofee, double>>();
            }

            public void Add(Cofee cofee, double price)
            {
               OrderItems.Add(Tuple.Create(cofee, price));
            }

            public void Add(Cofee cofee)
            {
                double price;

                switch (cofee.Size)
                {
                    case Cofee.CofeeSize.Small:
                        price = 0.5;
                        break;
                    case Cofee.CofeeSize.Normal:
                        price = 1.5;
                        break;
                    case Cofee.CofeeSize.Double:
                        price = 2.5;
                        break;
                    default:
                        price = 2.5;
                        break;
                }
                OrderItems.Add(Tuple.Create(cofee, price));
            }

            public double CalculateCost()
            {
                Cost = 0;
                foreach (Tuple<Cofee, double> tuple in OrderItems)
                     Cost += tuple.Item2;
                return Cost;
            }

            public void PrintOrderItems() {
                foreach (Tuple<Cofee, double> tuple in OrderItems)
                    Console.WriteLine($"A {tuple.Item1.Size} ({(int)tuple.Item1.Size}ml) cofee:\t{tuple.Item2} euros.");
            }
        }

        static void Main(string[] args)
        {
            Cofee sample = new Cofee(Cofee.CofeeSize.Normal);
            Console.WriteLine($"The \"Sample\" is a {sample.Size} ({(int)sample.Size}ml) cofee.");

            Order order = new Order();
            order.Add(new Cofee(Cofee.CofeeSize.Small), 0.5);
            order.Add(new Cofee(Cofee.CofeeSize.Normal), 1.5);
            order.Add(new Cofee(Cofee.CofeeSize.Double), 2.75);
            order.Add(new Cofee(Cofee.CofeeSize.Small));
            order.Add(new Cofee(Cofee.CofeeSize.Normal));

            Console.WriteLine("\nThe order contains: ");
            order.PrintOrderItems();

            Console.WriteLine($"The order has {order.OrderItems.Count} cofees and costs a total of {order.CalculateCost()} euros (inc VAT).");

            Console.ReadKey();
        }
    }
}
