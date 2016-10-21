using System;
using System.Collections.Generic;

namespace ExerciseFraction
{
    public class Fraction : IComparable<Fraction>
    {
        public int Numer { get; set; }
        private int _denom;
        public int Denom {
            get
            {
                return _denom;
            }

            private set
            {
                if (value == 0)
                {
                    Console.WriteLine("Cannot have 0 denominator.");
                    throw new DivideByZeroException();
                }
                else _denom = value;
            }
        }

        public Decimal Decimal {
            get
            {
                return (Decimal) Numer / (Decimal) Denom;
            }
        }

        public Fraction(int Numer, int Denom)
        {
            this.Numer = Numer;
            this.Denom = Denom;
        }

        public override string ToString()
        {
            if (Numer == 0) return "0";
            if (Denom == 1) return Numer.ToString();
            if (Numer == Denom) return "1";
            string sign = "";
            if ((double)Numer / Denom < 0) sign = "-";
            return sign + Math.Abs(Numer) + "/" + Math.Abs(Denom);
        }

        public static Fraction operator *(Fraction f1, Fraction f2)
        {
            Fraction result = new Fraction(f1.Numer * f2.Numer, f1.Denom * f2.Denom);
            Fraction.Cancel(result);
            return result;
        }

        public static Fraction operator *(int i, Fraction f)
        {
            Fraction result = new Fraction(i * f.Numer, f.Denom);
            Fraction.Cancel(result);
            return result;
        }

        public static Fraction operator *(Fraction f, int i)
        {
            return i*f;
        }

        public static Fraction operator +(Fraction f1, Fraction f2)
        {
            int Numerator = f1.Numer * f2.Denom + f2.Numer * f1.Denom;
            int Denominator = f1.Denom * f2.Denom;
            Fraction result = new Fraction(Numerator, Denominator);
            Fraction.Cancel(result);
            return result;
        }

        public static Fraction operator -(Fraction f)
        {
            return (new Fraction(-f.Numer, f.Denom));
        }

        public static Fraction operator -(Fraction f1, Fraction f2)
        {
            return f1 + -f2;
        }

        public static Fraction Parse(string str)
        {
            string[] parts = str.Split('/');
            if (parts.Length == 0)
                throw new ArithmeticException();
            int resultNum, resultDen = 1;
            bool successNum = Int32.TryParse(parts[0], out resultNum);
            bool successDen = false;
            if (parts.Length > 1)
                successDen = Int32.TryParse(parts[1], out resultDen);
            if (successDen && successNum)
                return new Fraction(resultNum, resultDen);
            if (!successDen && successNum)
                return new Fraction(resultNum, 1);
            //throw new ArgumentException();
            Console.WriteLine("Unacceptable String");
            return new Fraction(1, 1);
        }

        public int CompareTo(Fraction other)
        {
            // return Decimal.CompareTo((obj as Fraction).Decimal);
            if (Decimal == other.Decimal) return 0;
            else if (Decimal > other.Decimal) return 1;
            else return -1;
        }

        public static void Cancel(Fraction fract)
        {  
            int divider = Math.Min(Math.Abs(fract.Numer), Math.Abs(fract.Denom));
            while (divider > 1)
            {
                if ((fract.Numer % divider == 0) && (fract.Denom % divider == 0))
                {
                    fract.Numer = fract.Numer / divider;
                    fract.Denom = fract.Denom / divider;
                    divider = Math.Min(Math.Abs(fract.Numer), Math.Abs(fract.Denom));
                }
                else
                    divider--;
            }
        }

        public void Cancel()
        {
            int min = Math.Min(Numer, Denom);
            for (int i = min; i >= 2; i--)
            {
                if (Numer % i == 0  && Denom % i == 0)
                {
                    Numer /= i;
                    Denom /= i;
                }
            }
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            List<Fraction> fractions = new List<Fraction>()
            {
                new Fraction(3, 4),
                new Fraction(-3, 4),
                new Fraction(3, -4),
                new Fraction(-3, -4),
                new Fraction(0, 5),
                new Fraction(2, 4)
            };
            
             
            
            foreach (Fraction fract in fractions)
            {
                Console.WriteLine(fract);
            }

            Console.WriteLine();
            Console.WriteLine($"Multiplication {fractions[0]} * {fractions[2]}: {fractions[0] * fractions[2]}");
            Console.WriteLine($"Multiplication {fractions[0]} * {fractions[5]}: {fractions[0] * fractions[5]}");
            Console.WriteLine();
            Console.WriteLine($"Addition {fractions[0]} + {fractions[2]}: {fractions[0] + fractions[2]}");
            Console.WriteLine($"Addition {fractions[0]} + {fractions[5]}: {fractions[0] + fractions[5]}");
            Console.WriteLine($"Addition 3/4 + 3/4: {new Fraction(3,4) + new Fraction(3, 4)}");
            Console.WriteLine();
            Console.WriteLine($"Unary test - (-3/4): { - new Fraction(-3, 4)}");
            Console.WriteLine($"Subtraction {fractions[0]} - {fractions[2]}: {fractions[0] - fractions[2]}");
            Console.WriteLine($"Subreaction {fractions[0]} - {fractions[5]}: {fractions[0] - fractions[5]}");
            Console.WriteLine();
            Fraction parsed = Fraction.Parse("");
            Console.WriteLine("Parsed \"\": " + parsed);
            Fraction parsed2 = Fraction.Parse("-3/4");
            Console.WriteLine("Parsed2 \"-3/4\": " + parsed2);
            Fraction parsed3 = Fraction.Parse("a/b");
            Console.WriteLine("Parsed3 \"a/b\": " + parsed3);

            Fraction c1 = Fraction.Parse("8460/15625");
            
            Console.WriteLine("Before Cancel: " + c1);
            Fraction.Cancel(c1);
            Console.WriteLine("Cancelled: " + c1);

            Fraction c2 = Fraction.Parse("8460/15625");

            Console.WriteLine("Before Cancel: " + c2);
            c2.Cancel();
            Console.WriteLine("Cancelled: " + c2);



            fractions.Sort();
            foreach (Fraction fract in fractions) Console.WriteLine(fract);

            Console.ReadKey();
        }
    }
}
