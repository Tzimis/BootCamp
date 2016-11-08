namespace ExerciseUniversity
{
    public class Professor : Person
    {
        private static int _id = 1;
        public string ProfessorID { get; private set; }

        public Professor(string name, string surname, GenderType gender, int birthYear) :
            base(name, surname, gender, birthYear)
        {
            ProfessorID = $"PRF{_id++:000}";
        }

    }
}