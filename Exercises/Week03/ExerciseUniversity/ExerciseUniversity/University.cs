using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExerciseUniversity
{
    public class University
    {
        private static int _studentId = 1;
        public string Name { get; private set; }
        public string ShortName { get; private set; }
        public List<Course> Courses { get; private set; }
        public List<Student> Students { get; private set; }
        public List<Professor> Professors { get; private set; }

        public University(string name, string shortName)
        {
            Name = name;
            ShortName = shortName;
            Courses = new List<Course>();
            Students = new List<Student>();
            Professors = new List<Professor>();
        }

        public void AddStudent(Student student)
        {
            if (!Students.Contains(student)) { 
                Students.Add(student);
                student.setId(this.ShortName + $"{_studentId++:0000}");
            }
        }

        public void AddProfessor(Professor professor)
        {
            if (!Professors.Contains(professor)) Professors.Add(professor);
        }

        public void AddNewCourse(string name, string shortName)
        {
            Courses.Add(new Course(name, shortName, this));
        }

        public string CoursesInfo()
        {
            StringBuilder result = new StringBuilder();
            result.Append($"{Name} ({ShortName}) list of courses:\n");
            foreach (Course c in Courses) result.Append($"- [{c.ShortName}] {c.Name}\n");
            return result.ToString();
        }
    }
}
