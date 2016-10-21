using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exc001___CompositeNumbers
{
    class Program
    {
        static void Main(string[] args)
        {
            Complex c1 = new Complex(3, 7);
            Complex c2 = new Complex(-3.1);
            Complex c8 = new Complex(5.7, -2.1);

            Console.WriteLine("Complex 1: " + c1);
            Console.WriteLine("Complex 2: " + c2);
            Console.WriteLine("Complex 8: " + c8);

            Complex c3 = Complex.add(c1, c2);
            Console.WriteLine("Addition result: " + c3);

            Complex c4 = Complex.subtract(c1, c2);
            Console.WriteLine("Subtraction result: " + c4);

            Complex c5 = Complex.multiply(c1, c2);
            Console.WriteLine("Multiplication result: " + c5);

            Complex c9 = Complex.addMany(new List<Complex> { c1, c2, c8   });
            Console.WriteLine("Addition of many result: " + c9);


            Console.WriteLine("Addition operator result: " + (c1 + c2));

            Console.ReadKey();

        }
    }

    public class Complex
    {

        private double real;

        private double imaginary;


        public Complex()
        {
            real = 0;
            imaginary = 0;
        }

        public Complex(double real, double imaginary)
        {
            this.real = real;
            this.imaginary = imaginary;
        }

        public Complex(double real)
        {
            this.real = real;
            imaginary = 0;
        }

        public static Complex add(Complex c1, Complex c2)
        {
            Complex result = new Complex(c1.real + c2.real, c1.imaginary + c2.imaginary);
            return result;
        }

        public static Complex addMany(List<Complex> list)
        {
            Complex result = new Complex();
            foreach (Complex c in list)
            {
                result = Complex.add(result, c);
            }

            return result;
        }

        public static Complex subtract(Complex c1, Complex c2)
        {
            Complex result = new Complex(c1.real - c2.real, c1.imaginary - c2.imaginary);
            return result;
        }

        public static Complex multiply(Complex c1, Complex c2)
        {
            return new Complex(c1.real*c2.real - c1.imaginary*c2.imaginary , c1.real * c2.real + c1.imaginary * c2.imaginary);
        }

        public override string ToString()
        {
            string result = "";
            result += real;
            if (imaginary >= 0) result += "+";
            result += imaginary+"i";
            return result;  
        }
         
        public static Complex operator +(Complex c1, Complex c2)
        {
            return new Complex(c1.real + c2.real, c1.imaginary + c2.imaginary);
        }
           
    }
}
