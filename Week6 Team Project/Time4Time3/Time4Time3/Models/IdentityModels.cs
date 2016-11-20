using System;
using System.Data.Entity;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System.Collections.Generic;
using Time4Time3.Entities;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Time4Time3.Models
{
    // You can add profile data for the user by adding more properties to your ApplicationUser class, please visit http://go.microsoft.com/fwlink/?LinkID=317594 to learn more.
    public class ApplicationUser : IdentityUser
    {
        public async Task<ClaimsIdentity> GenerateUserIdentityAsync(UserManager<ApplicationUser> manager)
        {
            // Note the authenticationType must match the one defined in CookieAuthenticationOptions.AuthenticationType
            var userIdentity = await manager.CreateIdentityAsync(this, DefaultAuthenticationTypes.ApplicationCookie);
            // Add custom user claims here
            return userIdentity;
        }
        public enum Status
        {
            Active,
            Inactive,
            Deleted
        }

        [MaxLength(140, ErrorMessage = "{0} must be less than {1} characters long")]
        public string FirstName { get; set; }
        [MaxLength(140, ErrorMessage = "{0} must be less than {1} characters long")]
        public string LastName { get; set; }
        [Required]
        public decimal CreditsOwned { get; set; }
        [MaxLength(140, ErrorMessage = "{0} must be less than {1} characters long")]
        public string Address { get; set; }
        [Required]
        [MaxLength(140, ErrorMessage = "{0} must be less than {1} characters long")]
        public string City { get; set; }
        [MaxLength(50, ErrorMessage = "{0} must be less than {1} characters long")]
        public string PostalCode { get; set; }
        public Status ProfileStatus { get; set; }
        public string ImagePath { get; set; }

        [InverseProperty("Sender")]
        public virtual ICollection<Message> SentMessages { get; set; }

        [InverseProperty("Receiver")]
        public virtual ICollection<Message> ReceivedMessages { get; set; }

        [InverseProperty("Supplier")]
        public virtual ICollection<Service> Services { get; set; }
        [InverseProperty("Sender")]
        public virtual ICollection<Transaction> Transactions { get; set; }

        public ApplicationUser()
        {
            this.ProfileStatus = Status.Active;
            this.EmailConfirmed = false;
            this.PhoneNumberConfirmed = false;
            this.TwoFactorEnabled = false;
            this.AccessFailedCount = 0;
            this.LockoutEnabled = false;
            this.CreditsOwned = 15; 
        }
    }

    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext()
            : base("DefaultConnection", throwIfV1Schema: false)
        {
        }

        public static ApplicationDbContext Create()
        {
            return new ApplicationDbContext();
        }

        public DbSet<Service> Services { get; set; }
        public DbSet<Transaction> Transactions { get; set; }
        public DbSet<Message> Messages{ get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<ApplicationUser>()
                .HasMany(u => u.ReceivedMessages)
                .WithRequired()
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ApplicationUser>()
                .HasMany(u => u.SentMessages)
                .WithRequired()
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ApplicationUser>()
                .HasMany(u => u.Services)
                .WithRequired()
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ApplicationUser>()
                .HasMany(u => u.Transactions)
                .WithRequired()
                .WillCascadeOnDelete(false);

           modelBuilder.Entity<Service>()
               .HasMany(s => s.Transactions)
               .WithRequired()
               .WillCascadeOnDelete(false);

            modelBuilder.Entity<Transaction>()
                .HasMany(t => t.RelatedMessages)
                .WithOptional()
                .WillCascadeOnDelete(false);
        }
        
    }
}