using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exc005___Inheritance_Animal
{
    public class Animal
    {
        protected int Age { get; set; }
        protected string Name { get; set; }
        protected string Gender { get; set; } 

        public Animal(int Age, string Name, string Gender)
        {
            this.Age = Age;
            this.Name = Name;
            this.Gender = Gender;
        }

        public virtual string Sound()
        {
            return "a sound";
        }

        public override string ToString()
        {
            return $"{Name},\tAge:{Age},\t{Gender}, makes {Sound()}\t({GetType()})";
        }
    }

    public class Cat : Animal
    {
        public Cat(int Age, string Name, string Gender) : base(Age, Name, Gender)
        {

        }

        public override string Sound()
        {
            return "Meow...";
        }
    }

    public class Dog : Animal
    {
        public Dog(int Age, string Name, string Gender) : base(Age, Name, Gender)
        {
            //
        }

        public override string Sound()
        {
            return "Woof woof!";
        }
    }

    public class Lion : Animal
    {
        public Lion(int Age, string Name, string Gender) : base(Age, Name, Gender)
        {
            //
        }

        public override string Sound()
        {
            return "Grroarr!";
        }
    }

}
