using System;
using System.Collections.Generic;

namespace ExerciseLibrary
{
    public class Person
    {
        private static int _nextId = 100 ;
        public string id { get; private set; }
        public string Name { get; private set; }
        public string Surname { get; private set; }
        public static List<Person> Persons { get; protected set; }
        public List<Book> Wishlist { get; private set; }

        public Person(string Name, string Surname)
        {
            if (Persons == null) Persons = new List<Person>();
            this.Name = Name;
            this.Surname = Surname;
            Wishlist = new List<Book>();
            id = "PERS" + _nextId++;
            Persons.Add(this);
        }

        public override string ToString()
        {
            return $"{Name} {Surname}";
        }

        public static void PrintEveryone()
        {
            Console.WriteLine("Every person in this world:");
            foreach (Person p in Persons) Console.WriteLine($"- {p} [{p.id}]" );
            Console.WriteLine();
        }

        public void AddToWishlist(Book aBook)
        {
            if (!Wishlist.Contains(aBook)) Wishlist.Add(aBook);
        }

        public void RemoveFromWishlist(Book aBook)
        {
            Wishlist.Remove(aBook);
        }

        public void PrintWishlist()
        {
            Console.WriteLine($"{Name} {Surname}'s wishlist:");
            if (Wishlist.Count == 0) Console.WriteLine("- The whishlist is empty.");
            else foreach (Book b in Wishlist) Console.WriteLine("- " + b);
            Console.WriteLine();
        }

        public void BookIsAvailable(Book aBook, Librarian aLibrarian)
        {
            if (Wishlist.Contains(aBook))
            {
                Console.WriteLine($"\n{Name} {Surname} is notified and goes to rent {aBook}.");
                aLibrarian.Rent(aBook, this);
            }
            else Console.WriteLine($"{Name} {Surname} does not have {aBook} in his wishlist.");
        }
    }
}