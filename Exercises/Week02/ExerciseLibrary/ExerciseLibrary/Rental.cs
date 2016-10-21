using System;

namespace ExerciseLibrary
{
    internal class Rental
    {
        public Book RentedBook { get; private set; }
        public Person Renter { get; private set; }
        public DateTime RentDate { get; private set; }
        public DateTime ReturnDate { get; private set; }
        public bool isCompleted {
            get
            {
                if (ReturnDate < RentDate) return false;
                return true;
            }
        }

        public Rental(Book RentedBook, Person Renter)
        {
            this.RentedBook = RentedBook;
            this.Renter = Renter;
            RentDate = DateTime.Now;
        } 

        public void ReturnBook()
        {
            ReturnDate = DateTime.Now;
        }
    }
}