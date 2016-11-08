namespace ExerciseEf6.Migrations
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;
    using ExerciseEf6.Model;

    internal sealed class Configuration : DbMigrationsConfiguration<ExerciseEf6.BlogContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }

        protected override void Seed(ExerciseEf6.BlogContext context)
        {
            //  This method will be called after migrating to the latest version.

            //  You can use the DbSet<T>.AddOrUpdate() helper extension method 
            //  to avoid creating duplicate seed data. E.g.
            //

            context.Blogs.AddOrUpdate(
              b => b.Title,
              new Model.Blog() { Title = "My Ef Blog" },
              new Model.Blog() { Title = "My .Net Blog" }
            );
            //

            context.Users.AddOrUpdate(
                u => u.UserName,
                new User() { UserName = "arvangeo", FullName = "George Arvanitakis", Email = "arvangeo@gmail.com"},
                new User() { UserName = "bgates", FullName = "Bill Gates", Email = "bill@microsoft.com" }
            );
            //
            context.SaveChanges();

            var geoId = context.Users.FirstOrDefault(x => x.UserName == "arvangeo").Id;
            var billId = context.Users.FirstOrDefault(u => u.UserName == "bgates").Id;
            var EfBlogId = context.Blogs.AsNoTracking().FirstOrDefault(b => b.Title == "My Ef Blog").Id;

            context.Posts.AddOrUpdate(
                p => new { p.Title, p.UserId },
                new Post() { Title = "My First Post", UserId = geoId, BlogId = EfBlogId, Content = "This is my very first post to My Ef Blog.", Likes = 32},
                new Post() { Title = "Bill is great", UserId = billId, BlogId = EfBlogId, Content = "Whoever is named Bill is the best", Likes = 1 }
            );

            context.SaveChanges();
        }
    }
}
