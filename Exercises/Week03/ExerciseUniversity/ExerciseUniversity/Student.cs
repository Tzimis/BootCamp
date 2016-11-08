namespace ExerciseUniversity
{
    public class Student: Person
    {
        public string StudentID { get; private set; }

        public Student(string name, string surname, GenderType gender, int birthYear): 
            base(name, surname, gender, birthYear)
        {

        }

        public void setId(string id)
        {
            StudentID = id;
        }

    }
}