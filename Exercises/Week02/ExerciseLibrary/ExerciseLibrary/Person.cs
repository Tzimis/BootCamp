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

        public void RemoveWishlist(Book aBook)
        {
            Wishlist.Remove(aBook);
        }

        public void BookIsAvailable(Book aBook)
        {
            //TODO: implement BookIsAvailable
        }
    }
}