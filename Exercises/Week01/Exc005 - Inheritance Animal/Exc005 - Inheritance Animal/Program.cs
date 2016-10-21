using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exc005___Inheritance_Animal
{
    class Program
    {
        static void Main(string[] args)
        {
            Animal[] Animals = new Animal[5];

            Animals[0] = new Animal(38, "George", "M");
            Animals[1] = new Cat(2, "Felina", "F");
            Animals[2] = new Dog(12, "Rufus", "M");
            Animals[3] = new Lion(9, "Simba", "M");
            Animals[4] = new Animal(44, "Mary", "F"); 

            foreach (Animal animal in Animals)
            {
                Console.WriteLine(animal);
            }
            


            Console.ReadKey();
        }
    }
}
