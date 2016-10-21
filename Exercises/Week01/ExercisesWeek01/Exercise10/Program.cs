using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exercise10
{
    class Program
    {
        public class RandomSelector<T>
        {
            private static Random _r;
            private List<T> list;

            public RandomSelector(List<T> list)
            {
                _r = new Random();
                this.list = list;
            }

            public T Select()
            {
                int index = _r.Next(0, list.Count());
                return list.ElementAt(index);
            }
        }

        public class Person
        {
            public string Name { get; private set; }

            public Person(string name) { Name = name; }

            public override string ToString() { return Name; }
        }

        static void Main(string[] args)
        {
            List<string> stringList = new List<string>
            {
                "Bike", "Train", "Boat", "Feet"
            };

            List<Person> personList = new List<Person> {
                new Person("Ted"),
                new Person("Ira"),
                new Person("Ada"),
                new Person("Lea")
            };

            List<int> intList = new List<int> { 5, 10, 15, 20 };

            RandomSelector<string> stringSelector = new RandomSelector<string>(stringList);
            RandomSelector<Person> personSelector = new RandomSelector<Person>(personList);
            RandomSelector<int> intSelector = new RandomSelector<int>(intList);

            string choice = "";

            while (choice != "q")
            {
                Console.WriteLine("Random string: " + stringSelector.Select().ToString());
                Console.WriteLine("Random person: " + personSelector.Select().ToString());
                Console.WriteLine("Random integer: " + intSelector.Select().ToString());
                Console.Write("Again? Enter to continue, q to quit: ");
                choice = Console.ReadLine();
            }

        }
    }
}
