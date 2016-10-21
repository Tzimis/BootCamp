using System.Collections.Generic;

namespace ExerciseLibrary
{
    public class Book
    {
        private static int _nextId = 1000;
        public string id { get; private set; }
        public Author Author { get; private set; }
        public string Title { get; private set; }
        public static List<Book> BookList { get; private set; }


        public Book(string Title, Author Author)
        {
            if (BookList == null) BookList = new List<Book>();
            this.Title = Title;
            this.Author = Author;
            id = "BOOK" +_nextId++;
            BookList.Add(this);
        }

        public override string ToString()
        {
            return $"\"{Title}\" by {Author} [{id}]";
        }

        public bool Equals(Book otherBook)
        {
            if (Title == otherBook.Title && Author == otherBook.Author)
                return true;
            return false;
        }
    }
}