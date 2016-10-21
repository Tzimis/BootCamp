using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exercise09
{
    class Program
    {
        public class DoubleDice
        {
            private static Random _r;
            private int Sides { get; set; }
            public int[] Result { get; private set; }


            public DoubleDice()
            {
                _r = new Random();
                Result = new int[2];
                Sides = 6;
            }

            public void Throw()
            {
                for (int i = 0; i < 2; i++)
                    Result[i] = _r.Next(1, Sides + 1);
            }

        }

        static void Main(string[] args)
        {
            DoubleDice dices = new DoubleDice();
            string choiceStr = "";
            while (choiceStr!= "q")
            {
                dices.Throw();
                Console.WriteLine($"Throw result: {dices.Result[0]}, {dices.Result[1]}.");
                Console.Write("Play again? (Enter to play, q to quit): ");
                choiceStr = Console.ReadLine();
            }
            
        }
    }
}
