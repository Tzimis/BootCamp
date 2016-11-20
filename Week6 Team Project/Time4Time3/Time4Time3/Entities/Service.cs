using System;
using Time4Time3.Models;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Collections.Generic;


namespace Time4Time3.Entities
{
    public class Service
    {
        public enum ServiceStatus
        {
            Active,
            Inactive,
            Deleted
        }

        public int Id { get; set; }
        [Required]
        [MaxLength(200)]
        public string Title { get; set; }
        [Required]
        public string Description { get; set; }
        [Required]
        public decimal CreditWorth { get; set; }
        [Required]
        public string Location { get; set; }
        public string ImagePath { get; set; }
        [Required]
        public ServiceStatus IsActive { get; set; }
        public string SupplierId { get; set; }
        [ForeignKey("SupplierId")]
        public virtual ApplicationUser Supplier { get; set; }
        [InverseProperty("Service")]
        public virtual ICollection<Transaction> Transactions { get; set; }
        public Service()
        {
            this.IsActive = ServiceStatus.Active;
        }

    }
}