using System;

namespace ExerciseLibrary
{
    public delegate void BookNotifier(Book aBook, Librarian aLibrarian);
    public class Librarian: Person
    {
        private Library Library { get; set; }
        public event BookNotifier Notify;

        public Librarian(string Name, string Surname, Library Library): base(Name, Surname)
        {
            this.Library = Library;
        }

        public void Greeting()
        {
            Console.WriteLine($"Wellcome to {Library.Name}! My name is {Name} and I am the Librarian.");
        }

        public void SearchBook(Book aBook, Person aPerson){
            if (Library.isMember(aPerson))
            {
                int availableCopies;
                if (Library.SearchBook(aBook, out availableCopies))
                {
                    Console.Write($"Book \"{aBook}\" exists. ");
                    if (availableCopies > 1) Console.WriteLine($"There are {availableCopies} copies available.");
                    else if (availableCopies == 1) Console.WriteLine($"There is one copy available.");
                    else Console.WriteLine("Sorry, there is no copy available.");
                }
                else Console.WriteLine($"Sorry, {Library.Name} does not have this book in its collection."); 
            }
            else Console.WriteLine($"Sorry {aPerson}, you are not a member of our library.");
        }

        public void PrintBookList(Person aPerson)
        {
            if (Library.isMember(aPerson))
            {
                Library.PrintBookList();
            }
            else Console.WriteLine($"Sorry {aPerson}, you are not a member of our library.");
        }

        public void Rent(Book aBook, Person aPerson)
        {
            Console.WriteLine(Library.Rent(aBook, aPerson));
        }

        public void Return(Book aBook, Person aPerson)
        {
            Console.WriteLine(Library.Return(aBook, aPerson));
            if (Library.AvailableCopies(aBook) == 1)
            {
                if (Notify == null)
                {
                    Console.WriteLine("No one wants to be notified.");
                }
                else
                {
                    Notify(aBook, this);
                }

            }
               
        }

        public void PrintMemberList()
        {
            Library.PrintMemberList();
        }

        public void PrintRentals()
        {
            Library.PrintRentals();
        }

        public void NotifyOn(Person aPerson)
        {
            if (Library.isMember(aPerson))
            {
                Notify += aPerson.BookIsAvailable;
            }
            else Console.WriteLine($"Sorry {aPerson}, you are not a member of our library.");
        }
        public void NotifyOff(Person aPerson)
        {
            if (Library.isMember(aPerson))
            {
                Notify -= aPerson.BookIsAvailable;
            }
            else Console.WriteLine($"Sorry {aPerson}, you are not a member of our library.");
        }
    }
}
