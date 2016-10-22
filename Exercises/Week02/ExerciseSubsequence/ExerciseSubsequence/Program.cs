using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExerciseSubsequence
{
    class Program
    {
        static void Main(string[] args)
        {
            List<int> intList = new List<int> {5,6,7,4,17,4,24,5,
                7,9,6,4,3,3,3,3,3,3,2,3,5,6,6,6,6,8,6,5,2,1,2,4,6,7,8,8,9};

            Console.Write("Int List: ");
            foreach (int i in intList) Console.Write(i + " ");
            Console.WriteLine();

            Console.Write("Largest int Subsequence: ");
            foreach (int i in Utilities.Subsequence(intList)) Console.Write(i + " ");
            Console.WriteLine("\n");

            List<char> charList = new List<char> { 'a', 'b', 'c', 'c', 'c', 'd', 'd', 'e', 'f' };

            Console.Write("Char List: " + charList.ToString<char>());
            //foreach (char c in charList) Console.Write(c + " ");
            Console.WriteLine();

            Console.Write("Largest char Subsequence: ");
            foreach (char c in Utilities.Subsequence(charList)) Console.Write(c + " ");
            Console.WriteLine("\n");

            List<string> stringList = new List<string> { "one", "one", "two", "two", "two", "three",
                "four", "four", "four", "five", "six", "six", "six", "six", "seven" };

            Console.Write("String List: ");
            foreach (string s in stringList) Console.Write(s + " ");
            Console.WriteLine();

            Console.Write("Largest string Subsequence: ");
            foreach (string s in Utilities.Subsequence(stringList)) Console.Write(s + " ");
            Console.WriteLine("\n");

            Console.Write("Largest string Subsequence (ext): ");
            foreach (string s in stringList.SubsequenceExt()) Console.Write(s + " ");
            Console.WriteLine("\n");

            Console.ReadKey();
        }
    }
}
