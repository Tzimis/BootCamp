using System;
using System.Linq;
using System.Data.SQLite;

namespace ExerciseUniversity
{ 
    class Program
    {
        static void Main(string[] args)
        {
            University sampleUniversity;

            init(out sampleUniversity);

            Console.WriteLine(sampleUniversity.CoursesInfo());

            foreach(Course c in sampleUniversity.Courses)
            {
                //Console.WriteLine(c.CourseInfo()); 
            }

            var youngStudents = from student in sampleUniversity.Students
                             where student.Age < 20
                             select student;



            Console.WriteLine("Students younger than 20y.");
            foreach(Student student in youngStudents)
            {
                Console.WriteLine($"{student.Name} {student.Surname}, {student.Age}");
            }

            Console.WriteLine("\nUsing Lambdas:");
            sampleUniversity.Students
                .FindAll(aStudent => aStudent.Age < 20)
                .ForEach(student => Console.WriteLine($"{student.Name} {student.Surname}, {student.Age}"));



            var femalesInPhysics = from student in (from course in sampleUniversity.Courses
                                                    where course.ShortName.Equals("TP705")
                                                    select course).First().RegisteredStudents
                                   where student.Gender == Person.GenderType.Female
                                   select student;


            Console.WriteLine("\nFemales in Physics");
            foreach (Student s in femalesInPhysics)
            {
                Console.WriteLine($"- {s.Name} {s.Surname}, {s.Age}");
            }

            Console.WriteLine("\nUsing Lambdas:");
            sampleUniversity.Courses
                .Find(c => c.ShortName.Equals("TP705"))
                .RegisteredStudents
                .FindAll(s => s.Gender == Person.GenderType.Female)
                .ForEach(student => Console.WriteLine($"- {student.Name} {student.Surname}, {student.Age}"));
            

            Console.WriteLine("\nPress any key...");
            Console.ReadKey();

        }

        static void init(out University theUniversity) {
            theUniversity = new University("California Institute of Technology", "CALTECH");

            Professor p1 = new Professor("Ammy", "Fowler", Person.GenderType.Female, 1980);
            Professor p2 = new Professor("Sheldon", "Cooper", Person.GenderType.Male, 1974);
            Professor p3 = new Professor("Leonard", "Hoffstader", Person.GenderType.Male, 1975);

            Student s1 = new Student("Tom", "Brown", Person.GenderType.Male, 1997);
            Student s2 = new Student("Mary", "Black", Person.GenderType.Female, 1998);
            Student s3 = new Student("Jane", "Red", Person.GenderType.Female, 1995);
            Student s4 = new Student("John", "Green", Person.GenderType.Male, 1993);
            Student s5 = new Student("Tim", "Orange", Person.GenderType.Male, 1998);
            Student s6 = new Student("Ron", "Blue", Person.GenderType.Male, 1997);
            Student s7 = new Student("Helen", "Gray", Person.GenderType.Female, 1996);
            Student s8 = new Student("Tania", "Pink", Person.GenderType.Female, 1997);

            theUniversity.AddStudent(s1);
            theUniversity.AddStudent(s2);
            theUniversity.AddStudent(s3);
            theUniversity.AddStudent(s4);
            theUniversity.AddStudent(s5);
            theUniversity.AddStudent(s6);
            theUniversity.AddStudent(s7);
            
            theUniversity.AddNewCourse("Newrobiology 101", "NB101");
            theUniversity.AddNewCourse("Advanced Theoretical Physics", "TP705");

            foreach (Course c in theUniversity.Courses)
            {
                if (c.ShortName.Equals("NB101"))
                {
                    c.AddStudent(s1);
                    c.AddStudent(s3);
                    c.AddStudent(s4);
                    c.AddStudent(s7);
                    c.AddProfessor(p1);
                    //Console.WriteLine(c.CourseInfo());
                }
                if (c.ShortName.Equals("TP705"))
                {
                    c.AddProfessor(p2);
                    c.AddProfessor(p3);
                    c.AddStudent(s1);
                    c.AddStudent(s2);
                    c.AddStudent(s3);
                    c.AddStudent(s4);
                    c.AddStudent(s5);
                    c.AddStudent(s6);
                    c.AddStudent(s7);
                    //Console.WriteLine(c.CourseInfo());
                }

            }

        }
    }
}
