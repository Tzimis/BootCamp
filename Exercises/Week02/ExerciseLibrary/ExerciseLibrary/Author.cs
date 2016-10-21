using System;
using System.Collections.Generic;

namespace ExerciseLibrary
{
    public class Author: Person
    {
        public static List<Author> Authors { get; private set; }

        public Author(string Name, string Surname): base(Name, Surname)
        {
            if (Authors == null) Authors = new List<Author>();
            Authors.Add(this);
        }

        public static new void PrintEveryone()
        {
            Console.WriteLine("Every author we know:");
            foreach (Author a in Authors) Console.WriteLine("- " + a);
            Console.WriteLine();
        }
    }
}