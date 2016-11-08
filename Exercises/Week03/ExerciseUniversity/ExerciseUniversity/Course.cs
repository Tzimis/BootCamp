using System.Collections.Generic;
using System.Text;

namespace ExerciseUniversity
{
    public class Course
    {
        private static int _id = 0;
        public string CourseID { get; private set; }
        public string Name { get; private set; }
        public string ShortName { get; private set; }
        public University University { get; private set; }
        public List<Student> RegisteredStudents { get; private set;}
        public List<Professor> TeachingProfessors { get; private set; }

        public Course(string name, string shortName, University university)
        {
            Name = name;
            ShortName = shortName;
            University = university;
            CourseID = university.ShortName + _id++;
            TeachingProfessors = new List<Professor>();
            RegisteredStudents = new List<Student>();
        }

        public bool AddStudent(Student student)
        {
            if (University.Students.Contains(student))
            {
                RegisteredStudents.Add(student);
                return true;
            }
            return false;
        }

        public void AddProfessor(Professor professor)
        {
            TeachingProfessors.Add(professor);
        }

        public string CourseInfo()
        {
            StringBuilder result = new StringBuilder();
            result.Append($"{University.ShortName}, {University.Name}\n");
            result.Append($"Course: {ShortName}, {Name}\n");
            result.Append("Teaching Professors:\n");
            foreach (Professor p in TeachingProfessors) result.Append($"- {p.Name} {p.Surname} ({p.ProfessorID}), {p.Age}yo\n");
            result.Append("\nRegistered Students:\n");
            foreach (Student s in RegisteredStudents) result.Append($"- {s.Name} {s.Surname} ({s.StudentID}), {s.Age}yo\n");
            result.Append("\n");
            return result.ToString();
        }

    }
}
