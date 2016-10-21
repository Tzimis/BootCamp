using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exercise02
{
    class Program
    {
        // ΑΣΚΗΣΗ 2 (Ρωτάει πόσες φορές να παίξει)
        public static void Main(string[] args)
        {
            Random r = new Random();

            int Wins = 0, Losses = 0;

            Console.Write("Please enter the number of turns you want to play (int): ");
            string ChoiceStr = Console.ReadLine();
            int Turns = Int32.Parse(ChoiceStr);

            for (int i = 0; i < Turns; i++)
            {
                Console.Write("Give me a number between 1 and 6: ");
                string NumberStr = Console.ReadLine();
                int Number = Int32.Parse(NumberStr);
                int LotteryNumber = r.Next(1, 7);
                if (Number == LotteryNumber)
                {
                    Wins++;
                    Console.WriteLine("You win");
                }
                else
                {
                    Losses++;
                    Console.WriteLine("You loose. The number was " + LotteryNumber.ToString() + ".");
                }
            }
            Console.WriteLine($"Total turns: {Turns}. Wins: {Wins}({Math.Round((double)Wins / Turns * 100)}%), Losses: {Losses}({Math.Round((double)Losses / Turns * 100)}%).");
            Console.ReadKey();
        }
    }
}
