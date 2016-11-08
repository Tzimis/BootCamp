using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExerciseUniversity
{
    public abstract class Person
    {
        public enum GenderType { Male, Female}
        public string Name { get; protected set; }
        public string Surname { get; protected set; }
        public int BirthYear { get; protected set; }
        public GenderType Gender { get; protected set; }
        public int Age { get
            {
                return DateTime.Now.Year - BirthYear;
            } }

        public Person(string name, string surname, GenderType gender, int birthYear)
        {
            Name = name;
            Surname = surname;
            Gender = gender;
            BirthYear = birthYear;
        }
    }
}
