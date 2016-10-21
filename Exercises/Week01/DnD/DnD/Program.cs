using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DnD
{
    class Program
    {
        static void Main(string[] args)
        {

            Dice d4 = new Dice(4);
            Dice d8 = new Dice(8);
            Dice d12 = new Dice(12);
            Dice d20 = new Dice(20);
            Player player1 = new Player("Nikos");
            Player player2 = new Player("Kostas");

            Game game = new Game(player1, player2, d12);
            game.Play();
            game.PrintScore();

            //int round = 0;
            //int result;

            //while (round < 100)
            //{
            //    int result1 = player1.Roll(d20);
            //    int result2 = player2.Roll(d20);
            //    int diff = result1 - result2;
            //    if (diff < 0)
            //        player1.score += Math.Abs(diff);
            //    else if (diff>0)
            //        player2.score += Math.Abs(diff);  
                
            //    //if (round %2 ==0)
            //    //{
            //    //    result = player1.Roll(d20);
            //    //    Console.WriteLine("{0} rolled {1}.", player1.name, result);
            //    //}
            //    //else
            //    //{
            //    //    result = player2.Roll(d20);
            //    //    Console.WriteLine("{0} rolled {1}.", player2.name, result);
            //    //}
            //    round++;
            //}

            //Console.WriteLine("Total dice rolls:" + Dice.GetRolls());
            //Console.WriteLine(player1.name + " score: " + player1.score);
            //Console.WriteLine(player2.name + " score: " + player2.score);

            Console.ReadKey();

        }

    }

    class Dice
    {
        public int sides;
        private static int rolls = 0;

        public Dice(int sides)
        {
            this.sides = sides;
        }

        public void Roll()
        {
            rolls++;
        }

        public static int GetRolls()
        {
            return rolls;
        }

    }

    class Player
    {
        public String name { get; private set; }
        public String surname { get; private set; }
        public int score = 0;
        private static Random rand = new Random(); 

        public Player(String name)
        {
            this.name = name;
            surname = "";
        }

        public Player(String name, String surname)
        {
            this.name = name;
            this.surname = surname;
        }

        public int Roll(Dice dice)
        {
    
            dice.Roll();
            return rand.Next(1, dice.sides + 1);
        }
    }

    class Game
    {
        Player p1, p2;
        Dice dice;
        int p1Score, p2Score;

        public Game(Player p1, Player p2, Dice dice)
        {
            this.p1 = p1;
            this.p2 = p2;
            this.dice = dice;
            p1Score = p2Score = 0;
        }

        public void Play()
        {
            int round = 0;

            while (round < 100)
            {
                int result1 = p1.Roll(dice);
                int result2 = p2.Roll(dice);
                int diff = result1 - result2;
                if (diff < 0)
                    p1Score += Math.Abs(diff);
                else if (diff > 0)
                    p2Score += Math.Abs(diff);
                round++;
            }
        }

        public void PrintScore()
        {
            Console.WriteLine("Game result:");
            Console.WriteLine(p1.name + " score: " + p1Score);
            Console.WriteLine(p2.name + " score: " + p2Score);
            if (p1Score > p2Score)
                Console.WriteLine(p1.name + " wins!");
            else if (p1Score < p2Score)
                Console.WriteLine(p2.name + " wins!");
            else
                Console.WriteLine("It's a draw.");
        }
    }
}