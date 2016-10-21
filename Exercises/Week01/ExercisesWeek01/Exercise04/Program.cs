using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exercise04
{
    public class Dice
    {
        public Random r { get; set; }
        public string Id { get; set; }
        public int Result { get; set; }
        public int Choice { get; set; }
        public bool Success { get; set; }
        public int Sides { get; set; }

        private bool _nowCheat;
        public bool NowCheat
        {
            get
            {
                return _nowCheat;
            }
            set
            {
                if (value && !_nowCheat) Sides++;
                else if (!value && _nowCheat) Sides--;
                _nowCheat = value;
            }
        }

        public Dice(int Sides)
        {
            r = new Random();
            this.Sides = Sides;
        }

        public void Throw(int Number)
        {
            Choice = Number;
            Result = r.Next(1, Sides + 1);
            if (Number == Result)
                Success = true;
            else
                Success = false;
        }

    }

    class Program
    {

        public static void Main(string[] args)
        {
            int Wins = 0, Losses = 0;

            Console.Write("Please enter the number of turns you want to play (int): ");
            string ChoiceStr = Console.ReadLine();
            int Turns = Int32.Parse(ChoiceStr);

            int Sides;
            do
            {
                Console.Write("Please enter the number of sides the dice has (e.g. 6, int): ");
                ChoiceStr = Console.ReadLine();
                Sides = Int32.Parse(ChoiceStr);
                if (Sides < 2) Console.WriteLine("Please select an integer larger than 1.");
            } while (Sides < 2);

            Dice dice = new Dice(Sides);
            dice.NowCheat = true;
            for (int i = 0; i < Turns; i++)
            {
                Console.Write($"Give me a number between 1 and {Sides}: ");
                string NumberStr = Console.ReadLine();
                int Number = Int32.Parse(NumberStr);

                dice.Throw(Number);
                if (dice.Success)
                {
                    Wins++;
                    Console.WriteLine("You win");
                }
                else
                {
                    Losses++;
                    if ((dice.NowCheat) && (dice.Result > Sides))
                    {
                        Random r = new Random();
                        int FalseNumber = 0;
                        do
                        {
                            FalseNumber = r.Next(1, Sides + 1);
                        } while (FalseNumber == Number);
                        Console.WriteLine($"You loose. The number was {FalseNumber} (cheated)");

                    }

                    else
                        Console.WriteLine($"You loose. The number was {dice.Result.ToString()}");
                }
            }

            Console.WriteLine($"Total turns: {Turns}. Wins: {Wins} ({Math.Round((double)Wins / Turns * 100)}%), Losses: {Losses} ({Math.Round((double)Losses / Turns * 100)}%).");
            Console.ReadKey();
        }
    }
}
