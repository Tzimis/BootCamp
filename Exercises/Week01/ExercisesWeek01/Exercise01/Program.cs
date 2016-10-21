using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exercise01
{
    class Program
    {

        // ΑΣΚΗΣΗ 1 (While)
        //Ο παρακάτω κώδικας σε σχόλια κάνει το ίδιο με for-loop.
        public static void Main(string[] args)
        {
            Random r = new Random();

            for (int i = 0; i < 2; i++)
            {
                Console.Write("Give me a number between 1 and 6:");
                string NumberStr = Console.ReadLine();
                int Number = Int32.Parse(NumberStr);
                int LotteryNumber = r.Next(1, 7);
                if (Number == LotteryNumber)
                    Console.WriteLine("You win");
                else
                    Console.WriteLine("You loose. The number was " + LotteryNumber.ToString());
            }
            Console.ReadKey();

           
        }

        ////Ο παρακάτω κώδικας σε σχόλια κάνει το ίδιο με while.
        //public static void Main(string[] args)
        //{
        //    Random r = new Random();

        //    int i = 0;
        //    while (i < 2)
        //    {
        //        Console.Write("Give me a number between 1 and 6:");
        //        string NumberStr = Console.ReadLine();
        //        int Number = Int32.Parse(NumberStr);
        //        int LotteryNumber = r.Next(1, 7);
        //        if (Number == LotteryNumber)
        //            Console.WriteLine("You win");
        //        else
        //            Console.WriteLine("You loose. The number was " + LotteryNumber.ToString());
        //        i++;
        //    }
        //    Console.ReadKey();
        //}

        ////Ο παρακάτω κώδικας σε σχόλια κάνει το ίδιο με repeat.
        //public static void Main(string[] args)
        //{
        //    Random r = new Random();

        //    int i = 0;
        //    do
        //    {
        //        Console.Write("Give me a number between 1 and 6:");
        //        string NumberStr = Console.ReadLine();
        //        int Number = Int32.Parse(NumberStr);
        //        int LotteryNumber = r.Next(1, 7);
        //        if (Number == LotteryNumber)
        //            Console.WriteLine("You win");
        //        else
        //            Console.WriteLine("You loose. The number was " + LotteryNumber.ToString());
        //        i++;
        //    } while (i < 2);
        //    Console.ReadKey();
        //}

    }
}
