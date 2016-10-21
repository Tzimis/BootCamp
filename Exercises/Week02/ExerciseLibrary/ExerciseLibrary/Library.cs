using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExerciseLibrary
{
    public delegate void BookNotifier(Book aBook);
    class Library
    {
        public string Name { get; private set; }
        public event BookNotifier Notify;
        private class BookStock
        {
            public int TotalBooks { get; set; }
            public int AvailableBooks { get; set; }

            public BookStock(int Copies)
            {
                TotalBooks = Copies;
                AvailableBooks = Copies;
            }
        }


        private Dictionary<Book, BookStock> BookCollection{get; set;}
        private List<Person> Members { get; set; }
        private List<Rental> Rentals { get; set; }

        public Library(string Name)
        {
            this.Name = Name;
            BookCollection = new Dictionary<Book, BookStock>();
            Members = new List<Person>();
            Rentals = new List<Rental>();
        }
        
        public void AddBook(Book Book, int Copies)
        {
            if (BookCollection.ContainsKey(Book)){
                Console.WriteLine($"Book {Book} is allready in the collection of {Name}.");
                return;
            }
            BookCollection.Add(Book, new BookStock(Copies));
        }
        
        public void AddCopies(Book Book, int Copies)
        {
            BookCollection[Book].TotalBooks += Copies;
            BookCollection[Book].AvailableBooks += Copies;
        }

        public void AddUser(Person newPerson)
        {
            if (Members.Contains(newPerson)) Console.WriteLine($"{newPerson} is already a member.");
            else Members.Add(newPerson);
        }

        internal bool isMember(Person aPerson)
        {
            return Members.Contains(aPerson);
        }

        public bool SearchBook(Book aBook, out int availableCopies)
        {
            if (BookCollection.ContainsKey(aBook))
            {
                availableCopies = BookCollection[aBook].AvailableBooks;
                return true;
            }
            availableCopies = 0;
            return false;
        }

        public string Rent(Book aBook, Person aPerson)
        {
            if (BookCollection.ContainsKey(aBook))
            {
                if (isMember(aPerson))
                {
                    if (BookCollection[aBook].AvailableBooks > 0)
                    {
                        Rentals.Add(new Rental(aBook, aPerson));
                        BookCollection[aBook].AvailableBooks--;
                        return $"Here is your book. Please remember to bring it back in 10 days!";
                    }
                    return $"Sorry we have not any copies available.";
                }
                return $"Sorry, {aPerson} is not a member of our library.";
            }
            return $"{aBook} is not in our collection.";
        }

        public string Return(Book aBook, Person aPerson)
        {
            if (BookCollection.ContainsKey(aBook))
            {
                if (isMember(aPerson))
                {
                    foreach (Rental rental in Rentals)
                    {
                        if (rental.Renter.Equals(aPerson) && rental.RentedBook.Equals(aBook) && !rental.isCompleted)
                        {
                            rental.ReturnBook();
                            BookCollection[aBook].AvailableBooks++;
                            return $"Thank you for returning the book!";
                        }
                    }
                    return $"Sorry, according to our records you have not rented this book.";
                }
                return $"Sorry, {aPerson} is not a member of our library.";
            }
            return $"{aBook} is not in our collection.";
        }

        public void PrintBookList()
        {
            Console.WriteLine("Books in the Library:");
            foreach (KeyValuePair<Book,BookStock> entry in BookCollection)
            {
                Console.WriteLine($"- {entry.Key}: { entry.Value.AvailableBooks}/{ entry.Value.TotalBooks} copies available.");
            }
        }

        public void PrintMemberList()
        {
            Console.WriteLine($"Members of the {Name}:");
            foreach (Person p in Members)
            {
                Console.WriteLine($"- {p}");
            }
            Console.WriteLine();
        }

        public void PrintRentals()
        {
            Console.WriteLine("Rental Log:");
            foreach (Rental rental in Rentals)
            {
                Console.WriteLine($"- {rental.RentedBook} | {rental.Renter} | {rental.RentDate} | {rental.ReturnDate} | {rental.isCompleted}");
            }
            Console.WriteLine();
        }

    }
}
