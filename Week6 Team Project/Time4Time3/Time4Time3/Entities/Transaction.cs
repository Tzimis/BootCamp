using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Collections.Generic;
using System.Data.Entity;
using Time4Time3.Models;

namespace Time4Time3.Entities
{


    public class Transaction
    {
        public enum TransactionStatus
        {
            New,
            Accepted,
            Cancelled,
            Completed
        }

        public int Id { get; set; }
        [Required]
        [ForeignKey("Sender"),Column(Order =1)]
        public string Sender_Id { get; set; }
        public virtual ApplicationUser Sender { get; set; }
        [ForeignKey("Service"), Column(Order = 2)]
        public int Service_Id { get; set; }
        public virtual Service Service { get; set; }

        public int? Rating { get; set; }
        [Required]
        public decimal CreditValue { get; set; }
        public TransactionStatus  Status{ get; set; }
        public DateTimeOffset StartDate { get; set; }
        public DateTimeOffset? AcceptDate { get; set; }
        public DateTimeOffset? CancelDate { get; set; }
        public DateTimeOffset? CompleteDate { get; set; }

        [InverseProperty("RelatedTransaction")]
        public virtual ICollection<Message> RelatedMessages { get; set; }
        public Transaction()
        {
            this.Status = TransactionStatus.New;
            this.StartDate = DateTimeOffset.Now;
        }
    }
}