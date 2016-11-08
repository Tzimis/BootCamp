using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace ExerciseADONET
{
    class Program
    {
        static void Main(string[] args)
        {
            //Console.WindowHeight = 30;
            //Console.WindowWidth = 115;
            Console.BackgroundColor = ConsoleColor.DarkBlue;
            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.Clear();
            try
            {
                using (SqlConnection conn = new SqlConnection("Data Source=VISION;Initial Catalog=MyServiceTrade;Integrated Security=True;Connect Timeout=15;Encrypt=False;TrustServerCertificate=True;ApplicationIntent=ReadWrite;MultiSubnetFailover=False"))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand("SELECT * from Users ", conn))
                    {
                        using (SqlDataReader rdr = cmd.ExecuteReader())
                        {
                            if (rdr != null)
                            {
                                int counter = 0;
                                int screenLines = 25;
                                while (rdr.Read())
                                {
                                    if (counter % screenLines == 0)
                                    {
                                        Console.WriteLine("{0,10} {1,-15} {2,-20} {3,-15} {4,-30}", "UserID", "First Name", "Last Name", "Username", "eMail");
                                        for (int i = 0; i < 90; i++) Console.Write("-");
                                        Console.WriteLine();
                                   }
                                    int UserID = (int)rdr["UserID"];
                                    string FirstName = (string)rdr["FirstName"];
                                    string LastName = (string)rdr["LastName"];
                                    string UserName = (string)rdr["UserName"];
                                    string eMail = (string)rdr["eMail"];

                                    counter++;

                                    Console.WriteLine($"{UserID,10} {FirstName,-15} {LastName,-20} {UserName, -15} {eMail, -30}");
                                    if (counter % screenLines == 0)
                                    {
                                        Console.WriteLine();
                                        Console.Write("Press Any Key To Continue...\n");
                                        Console.ReadKey();
                                        Console.Clear();
                                    }
                                }
                                if (counter % screenLines < screenLines)
                                {
                                    Console.WriteLine();
                                    Console.Write("End of Records. Press Any Key To Continue...");
                                    Console.ReadKey();
                                    Console.Clear();
                                }

                            }
                        }
                    }

                 

                }
            }
            catch (SqlException exception)
            {
                for (int i = 0; i < exception.Errors.Count; i++)
                {
                    Console.WriteLine("Error: " + exception.Errors[i].ToString());
                }
            }
            Console.Write("Press any key to continue...");
            Console.ReadKey();
        }

        //static void Main(string[] args)
        //{
        //    Console.BackgroundColor = ConsoleColor.DarkBlue;
        //    Console.ForegroundColor = ConsoleColor.Yellow;
        //    Console.Clear();
        //    try
        //    {
        //        using (SqlConnection conn = new SqlConnection("Data Source=VISION;Initial Catalog=NORTHWND;Integrated Security=True;Connect Timeout=15;Encrypt=False;TrustServerCertificate=True;ApplicationIntent=ReadWrite;MultiSubnetFailover=False"))
        //        {
        //            conn.Open();
        //            using (SqlCommand cmd = new SqlCommand("SELECT * from Customers", conn))
        //            {
        //                using (SqlDataReader rdr = cmd.ExecuteReader())
        //                {
        //                    if (rdr != null)
        //                    {
        //                        int counter = 0;
        //                        int screenLines = 25;
        //                        while (rdr.Read())
        //                        {
        //                            if (counter % screenLines == 0)
        //                            {
        //                                Console.WriteLine(" {0,3} {1,7} {2,-38} {3,-25} {4,-15} {5,20}", "# ", "CompID", "Company Name", "Contact Title", "City", "Phone");
        //                                for (int i = 0; i < 114; i++) Console.Write("-");
        //                                Console.WriteLine();
        //                                //Console.WriteLine("{0,3} {1,7} {2,-38} {3,-25} {4,-15} {5,20}", "---", "------", "------------", "-------------", "----", "-----");
        //                            }
        //                            string CustomerID = (string)rdr["CustomerID"];
        //                            string CompanyName = (string)rdr["CompanyName"];
        //                            string ContactName = (string)rdr["ContactName"];
        //                            string ContactCity = (string)rdr["City"];
        //                            string Phone = (string)rdr["Phone"];
        //                            counter++;

        //                            Console.WriteLine($"{counter,3} {CustomerID,7} {CompanyName,-38}  {ContactName,-25} {ContactCity,-15} {Phone,20}");
        //                            if (counter % screenLines == 0)
        //                            {
        //                                Console.WriteLine();
        //                                Console.Write("Press Any Key To Continue...\n");
        //                                Console.ReadKey();
        //                                Console.Clear();
        //                            }
        //                        }
        //                        if (counter % screenLines < screenLines)
        //                        {
        //                            Console.WriteLine();
        //                            Console.Write("End of Records. Press Any Key To Continue...");
        //                            Console.ReadKey();
        //                            Console.Clear();
        //                        }

        //                    }
        //                }
        //            }

        //            using (SqlCommand cmd = new SqlCommand("Ten Most Expensive Products", conn))
        //            {
        //                cmd.CommandType = System.Data.CommandType.StoredProcedure;
        //                cmd.Connection = conn;

        //                using (SqlDataReader rdr = cmd.ExecuteReader())
        //                {
        //                    if (rdr != null)
        //                    {
        //                        while (rdr.Read())
        //                        {
        //                            try
        //                            {
        //                                string product = (string)rdr["TenMostExpensiveProducts"];
        //                                decimal price = (decimal)rdr["UnitPrice"];
        //                                Console.WriteLine($"{product,-50} {price:.00}");
        //                            }
        //                            catch (InvalidCastException e)
        //                            {
        //                                Console.WriteLine(e.Message);
        //                            }

        //                        }
        //                    }
        //                }

        //            }

        //            Console.Write("Press any key...");
        //            Console.ReadKey();
        //            Console.Clear();

        //            using (SqlCommand cmd = new SqlCommand("SalesByCategory", conn))
        //            {
        //                cmd.CommandType = System.Data.CommandType.StoredProcedure;
        //                cmd.Parameters.Add(new SqlParameter("CategoryName", "Seafood"));
        //                cmd.Connection = conn;

        //                using (SqlDataReader rdr = cmd.ExecuteReader())
        //                {
        //                    if (rdr != null)
        //                    {
        //                        while (rdr.Read())
        //                        {
        //                            string productName = (string)rdr["ProductName"];
        //                            decimal total = (decimal)rdr["TotalPurchase"];

        //                            Console.WriteLine($"{productName,-50} {total:.00}");

        //                        }
        //                    }
        //                }

        //            }

        //        }
        //    }
        //    catch (SqlException exception)
        //    {
        //        for (int i = 0; i < exception.Errors.Count; i++)
        //        {
        //            Console.WriteLine("Error: " + exception.Errors[i].ToString());
        //        }
        //    }
        //    Console.ReadKey();
        //}
    }
}
