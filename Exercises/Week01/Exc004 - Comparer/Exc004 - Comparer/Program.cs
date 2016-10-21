using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exc004___Comparer
{
    class Program
    {
        public class Student : IComparable<Student>
        {
            public string Name;
            public double Mark;

            public Student(string Name, double Mark)
            {
                this.Name = Name;
                this.Mark = Mark;
            }

            //public int CompareTo(Student Other)
            //{
            //    return Mark.CompareTo(Other.Mark);
            //}

            public int CompareTo(Student Other)
            {
                if (this.Mark < Other.Mark) return -1;
                else if (this.Mark > Other.Mark)  return 1;
                else return 0;
            }
        }

        static void Main(string[] args)
        {
            List<Student> StudentList = new List<Student> {
                new Student("Jim", 8.7),
                new Student("Mary", 5.5),
                new Student("John", 7.3),
                new Student("Tom", 3.4),
                new Student("Tim", 6.4),
                new Student("Jane", 4.2),
                new Student("Mark", 3.6),
                new Student("Helen", 4.5),
                new Student("Ted", 7.3)
            };

            Console.WriteLine("Unsorted:\n---------");
            foreach (Student student in StudentList)
            {
                Console.WriteLine(student.Name + "\t" + student.Mark);
            }

            StudentList.Sort();

            Console.WriteLine("\nSorted:\n-------");
            foreach (Student student in StudentList)
            {
                Console.WriteLine(student.Name + "\t" + student.Mark);
            }

            Console.ReadKey();
        }
    }
}
