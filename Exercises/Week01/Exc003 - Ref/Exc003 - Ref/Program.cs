using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exc003___Ref
{
    class Program
    {
        public static class Utilities
        {
            public static void Swap(int a, int b)
            {
                int temp = a;
                a = b;
                b = temp;
            }

            public static void Swap(ref int a, ref int b)
            {
                int temp = a;
                a = b;
                b = temp;
            }

            public static void Swap<T>(ref T a, ref T b)
            {
                T temp = a;
                a = b;
                b = temp;
            }

            public static void Swap(Person p1, Person p2)
            {
                Person temp = p1;
                p1 = p2;
                p2 = temp;
                p1.name = "Jenny";
            }
        }

        public class Person
        {
            public String name;
            String surName;

            public Person(String name, String surName)
            {
                this.name = name;
                this.surName = surName;
            }

            public override string ToString()
            {
                return name + " " + surName;
            }
        }

            static void Main(string[] args)
        {
            int a = 5;
            int b = 7;
            Console.WriteLine($"Before: a = {a}, b = {b}");
            Utilities.Swap(a, b);
            Console.WriteLine($"After without ref: a = {a}, b = {b}");
            Utilities.Swap(ref a, ref b);
            Console.WriteLine($"After with ref: a = {a}, b = {b}");

            Console.WriteLine("\nSwap Generic");
            String c = "day";
            String d = "night";
            Console.WriteLine($"Before: c = {c}, d = {d}");
            Utilities.Swap<String>(ref c, ref d);
            Console.WriteLine($"After generic: c = {c}, d = {d}");

            Person p1 = new Person("Peter", "Parker");
            Person p2 = new Person("Betsy", "Blue");
            Console.WriteLine($"Before: Person1 = {p1}, Person2 = {p2}");
            Utilities.Swap(ref p1, ref p2);
            Console.WriteLine($"After: Person1 = {p1}, Person2 = {p2}");

            Person p3 = new Person("Jonah", "Jameson");
            Person p4 = new Person("Clark", "Kent");
            Console.WriteLine($"Before: Person3 = {p3}, Person4 = {p4}");
            Utilities.Swap(p3, p4);
            Console.WriteLine($"After: Person3 = {p3}, Person4 = {p4}");

            Console.ReadKey();

        }
    }
}
