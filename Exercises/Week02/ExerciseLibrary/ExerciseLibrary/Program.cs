using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExerciseLibrary
{
    class Program
    {
         static int interval = 453; // Sleep interval
        static void Main(string[] args)
        {
            Librarian Nancy;
            init(out Nancy);

            Nancy.Greeting();
            Console.WriteLine();

            System.Threading.Thread.Sleep(interval);

            checkSearch(Nancy);
            checkRent(Nancy);

            Console.WriteLine($"{Person.Persons[1]} asks for list of books in the library.");
            Nancy.PrintBookList(Person.Persons[1]);
            Console.WriteLine();

            System.Threading.Thread.Sleep(interval);

            Console.WriteLine($"{Person.Persons[2]} asks for list of books in the library.");
            Nancy.PrintBookList(Person.Persons[2]);
            Console.WriteLine();

            System.Threading.Thread.Sleep(interval);

            Nancy.PrintRentals();

            System.Threading.Thread.Sleep(interval);

            Console.ReadKey();
            Person.PrintEveryone();
            Author.PrintEveryone();
            Nancy.PrintMemberList();
            Console.ReadKey();
        }

        /// <summary>
        /// Initialize and populate the world.
        /// </summary>
        static void init(out Librarian theLibrarian)
        {
            // Create a library and the librarian
            Library NationalLibrary = new Library("National Library");
            theLibrarian = new Librarian("Nancy", "Pearl", NationalLibrary);

            // Create persons
            Person u1 = new Person("George", "Brown");
            Person u2 = new Person("Martha", "Grey");
            Person u3 = new Person("John", "Black");
            Person u4 = new Person("Henry", "White");
            Person u5 = new Person("Andrew", "Orange");
            Person u6 = new Person("Julian", "Purple");

            // Register users to the library
            NationalLibrary.AddUser(u2);
            NationalLibrary.AddUser(u3);
            NationalLibrary.AddUser(u4);
            NationalLibrary.AddUser(u5);

            // Create authors
            Author Blyton = new Author("Enid", "Blyton");
            Author Verne = new Author("Jules", "Verne");
            Author Hugo = new Author("Victor", "Hugo");
            Author Poe = new Author("Edgar", "Allan Poe");

            // Create books
            Book b1 = new Book("The Secret Seven", Blyton);
            Book b2 = new Book("Well Done Secret Seven", Blyton);
            Book b3 = new Book("Secret Seven on the Trail", Blyton);
            Book b4 = new Book("20,000 Leagues Under the Sea", Verne);
            Book b5 = new Book("Journey to the Center of the Earth", Verne);
            Book b6 = new Book("Around the World in 80 Days", Verne);
            Book b7 = new Book("The Mysterious Island", Verne);
            Book b8 = new Book("The Miserables, Vol.I - Fantine", Hugo);
            Book b9 = new Book("The Miserables, Vol.II - Cosette", Hugo);
            Book b10 = new Book("The Golden Scarab", Poe);
            Book b11 = new Book("Eureka", Poe);
            Book b12 = new Book("The Raven and Other Poems", Poe);

            // Add books to library
            NationalLibrary.AddBook(b1, 2);
            NationalLibrary.AddBook(b2, 8);
            NationalLibrary.AddBook(b4, 8);
            NationalLibrary.AddBook(b6, 7);
            NationalLibrary.AddBook(b7, 12);
            NationalLibrary.AddBook(b9, 12);
            NationalLibrary.AddBook(b10, 15);
            NationalLibrary.AddBook(b12, 5);

        }

        /// <summary>
        /// Group all search book related tests.
        /// </summary>
        /// <param name="theLibrarian"></param>
        static void checkSearch(Librarian theLibrarian)
        {
            Console.WriteLine($"{Person.Persons[0]} asks for {Book.BookList[0]}.");
            theLibrarian.SearchBook(Book.BookList[0], Person.Persons[0]);
            Console.WriteLine();

            System.Threading.Thread.Sleep(interval);

            Console.WriteLine($"{Person.Persons[2]} asks for {Book.BookList[0]}.");
            theLibrarian.SearchBook(Book.BookList[0], Person.Persons[2]);
            Console.WriteLine();

            System.Threading.Thread.Sleep(interval);
        }

        /// <summary>
        /// Group all rent related tests.
        /// </summary>
        /// <param name="theLibrarian"></param>
        static void checkRent(Librarian theLibrarian)
        {
            Console.WriteLine($"{Person.Persons[0]} wants to rent {Book.BookList[0]}.");
            theLibrarian.Rent(Book.BookList[0], Person.Persons[0]);
            Console.WriteLine();

            System.Threading.Thread.Sleep(interval);

            Console.WriteLine($"{Person.Persons[5]} wants to rent {Book.BookList[0]}.");
            theLibrarian.Rent(Book.BookList[0], Person.Persons[5]);
            Console.WriteLine();

            System.Threading.Thread.Sleep(interval);

            Console.WriteLine($"{Person.Persons[3]} wants to rent {Book.BookList[0]}.");
            theLibrarian.Rent(Book.BookList[0], Person.Persons[3]);
            Console.WriteLine();

            System.Threading.Thread.Sleep(interval);

            Console.WriteLine($"{Person.Persons[4]} wants to rent {Book.BookList[0]}.");
            theLibrarian.Rent(Book.BookList[0], Person.Persons[4]);
            Console.WriteLine();

            System.Threading.Thread.Sleep(interval);

            Console.WriteLine($"{Person.Persons[3]} wants to return {Book.BookList[0]}.");
            theLibrarian.Return(Book.BookList[0], Person.Persons[3]);
            Console.WriteLine();

            System.Threading.Thread.Sleep(interval);

            Console.WriteLine($"{Person.Persons[3]} wants to rent {Book.BookList[0]}.");
            theLibrarian.Rent(Book.BookList[0], Person.Persons[3]);
            Console.WriteLine();

            System.Threading.Thread.Sleep(interval);

        }
    }
}
