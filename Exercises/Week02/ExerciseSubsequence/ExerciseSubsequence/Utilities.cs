using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExerciseSubsequence
{
    static class Utilities
    {
        /// <summary>
        /// Finds the longest subsequence of equal integers in a given list and
        /// returns the result as a new list.
        /// Initial implementation.
        /// </summary>
        /// <param name="list"></param>
        /// <returns></returns>
        public static List<int> Subsequence(List<int> list)
        {
            List<int> tempResult = new List<int>();
            List<int> largestSoFar = new List<int>();
            if (list.Count == 1) largestSoFar.Add(list[0]);
            else if (list.Count > 1)
            {
                int counter = 0;
                int highest = 0;

                for  (int i = 1; i < list.Count; i++)
                {
                    if (list[i] == list[i - 1])
                    {
                        tempResult.Add(list[i]);
                        counter++;
                        if (counter > highest)
                        {
                            highest = counter;
                            largestSoFar.Clear();
                            largestSoFar.AddRange(tempResult);
                        }
                    }
                    else
                    {
                        tempResult.Clear();
                        tempResult.Add(list[i]);
                        counter = 0;
                    }
                } 
            }
            return largestSoFar;
        }

        /// <summary>
        /// Finds the longest subsequence of equal items in a given list and
        /// returns the result as a new list.
        /// Implementation using Generics;
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="list"></param>
        /// <returns></returns>
        public static List<T> Subsequence<T>(List<T> list)
        {
            List<T> tempResult = new List<T>();
            List<T> largestSoFar = new List<T>();
            if (list.Count == 1) largestSoFar.Add(list[0]);
            else if (list.Count > 1)
            {
                int counter = 0;
                int highest = 0;

                for (int i = 1; i < list.Count; i++)
                {
                    if (list[i].Equals(list[i - 1]))
                    {
                        tempResult.Add(list[i]);
                        counter++;
                        if (counter > highest)
                        {
                            highest = counter;
                            largestSoFar.Clear();
                            largestSoFar.AddRange(tempResult);
                        }
                    }
                    else
                    {
                        tempResult.Clear();
                        tempResult.Add(list[i]);
                        counter = 0;
                    }
                }
            }
            return largestSoFar;
        }

        /// <summary>
        /// Finds the longest subsequence of equal items in a given list and
        /// returns the result as a new list.
        /// Implementation as an extension method to List<T>;
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="list"></param>
        /// <returns></returns>
        public static List<T> SubsequenceExt<T>(this List<T> list)
        {
            return Subsequence(list);
        }

        public static string ToString<T>(this List<T> list)
        {
            string result = "";
            foreach (T item in list) result += $"[{item}]";
            return result;
        }
    }
}
  