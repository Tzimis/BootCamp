using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ExerciseEf6.Model;
using System.Data.Entity;

namespace ExerciseEf6
{
    class Program
    {
        static void Main(string[] args)
        {

            //InsertExample();
            //PrintAllBlogs();

            //UpdateExample();
            //PrintAllBlogs();

            //DeleteExample();
            //PrintAllBlogs();
            ASimpleJoin();

            PrintAllPostsOfEf();
            Console.ReadKey(true);
        }

        private static void PrintAllPostsOfEf()
        {
            var postList = new List<Post>();
            using (var context = new BlogContext())
            {
                int blogId = context.Blogs.FirstOrDefault(b => b.Title == "My Ef Blog").Id;
                //postList = context.Posts.Where(p => p.BlogId == blogId).ToList();
                postList = context.Posts.Include(p => p.User).Where(p => p.BlogId == blogId).ToList();
            }

            Console.WriteLine("Posts in My Ef Blog:\n");
            foreach (Post p in postList)
            {
                Console.WriteLine($"Title: {p.Title}");
                Console.WriteLine($"Content: {p.Content}");
                Console.WriteLine($"Written by: {p.User.UserName} ({p.User.FullName})");
                Console.WriteLine($"Likes: {p.Likes}");
                Console.WriteLine();
            }

        }

        public static void PrintAllBlogs()
        {
            var blogList = new List<Blog>();
            using (var db = new BlogContext())
            {
                blogList = db.Blogs.ToList();
            }

            Console.WriteLine($"Blogs:");
            foreach (Blog b in blogList)
            {
                Console.WriteLine($"ID: {b.Id} \tTitle: {b.Title}.");
            }
            Console.WriteLine();
        }


        public static void DeleteExample()
        {
            using (var db = new BlogContext())
            {
                var blog = db.Blogs.FirstOrDefault(b => b.Title.Equals("A Newer Blog"));
                db.Blogs.Remove(blog);
                db.SaveChanges();
            }
        }



        public static void UpdateExample()
        {
            using (var db = new BlogContext())
            {
                var blog = db.Blogs.FirstOrDefault(b => b.Title.Equals("A new Blog"));
                blog.Title = "A Newer Blog";
                db.SaveChanges();
            }
        }

        public static void InsertExample()
        {
            using (var db = new BlogContext())
            {
                db.Blogs.Add(new Blog()
                {
                    Title = "A new Blog"
                });
                db.SaveChanges();
            }
        }

        public static void ASimpleJoin()
        {
            var listBlogs = new List<Blog>();
            using (var db = new BlogContext())
            {
                listBlogs = db.Blogs.Include(b => b.Posts).ToList();
            }

            foreach (Blog b in listBlogs)
            {
                Console.WriteLine("Posts of Blog " + b.Title);
                foreach (Post p in b.Posts)
                {
                    Console.WriteLine( "- " + p.Title);
                }
                Console.WriteLine();
            }
        }
    }
}
