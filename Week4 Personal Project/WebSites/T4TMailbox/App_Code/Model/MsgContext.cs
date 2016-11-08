namespace T4TMailbox
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class MsgContext : DbContext
    {
        public MsgContext()
            : base("name=MsgContext")
        {
        }

        public virtual DbSet<Message> Messages { get; set; }
        public virtual DbSet<Service> Services { get; set; }
        public virtual DbSet<User> Users { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Message>()
                .Property(e => e.Subject)
                .IsUnicode(false);

            modelBuilder.Entity<Message>()
                .Property(e => e.Text)
                .IsUnicode(false);

            modelBuilder.Entity<Message>()
                .HasMany(e => e.Messages1)
                .WithOptional(e => e.Message1)
                .HasForeignKey(e => e.ReplyToMessageID);

            modelBuilder.Entity<Service>()
                .Property(e => e.ServiceTitle)
                .IsUnicode(false);

            modelBuilder.Entity<Service>()
                .Property(e => e.ServiceDescription)
                .IsUnicode(false);

            modelBuilder.Entity<Service>()
                .Property(e => e.CreditsRequested)
                .HasPrecision(18, 0);

            modelBuilder.Entity<Service>()
                .Property(e => e.City)
                .IsUnicode(false);

            modelBuilder.Entity<Service>()
                .Property(e => e.ImagePath)
                .IsUnicode(false);

            modelBuilder.Entity<Service>()
                .HasMany(e => e.Messages)
                .WithOptional(e => e.Service)
                .HasForeignKey(e => e.RelatedServiceID);

            modelBuilder.Entity<User>()
                .Property(e => e.FirstName)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.LastName)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.UserName)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.Password)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.eMail)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.OwnedCredits)
                .HasPrecision(18, 0);

            modelBuilder.Entity<User>()
                .Property(e => e.City)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.Address)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.PostCode)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.ImagePath)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .HasMany(e => e.Messages)
                .WithRequired(e => e.User)
                .HasForeignKey(e => e.SenderID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<User>()
                .HasMany(e => e.Messages1)
                .WithRequired(e => e.User1)
                .HasForeignKey(e => e.ReceiverID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<User>()
                .HasMany(e => e.Services)
                .WithRequired(e => e.User)
                .HasForeignKey(e => e.OfferedBy)
                .WillCascadeOnDelete(false);
        }
    }
}
