using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;
using Time4Time3.Models;

namespace Time4Time3.Entities
{
    public enum MessageStatus
    {
        Available = 0,
        Trashed = 1,
        Deleted = 2
    }

    public enum MailBox
    {
        Inbox = 0,
        Sent = 1,
        Trash = 2
    }

    public class Message
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int MessageID { get; set; }

        [Required]
        [ForeignKey("Sender")]
        public string SenderID { get; set; }
        public ApplicationUser Sender { get; set; }

        [ForeignKey("RelatedTransaction")]
        public int? TransactionId { get; set; }
        public Transaction RelatedTransaction { get; set; }

        [Required]
        [ForeignKey("Receiver")]
        public string ReceiverID { get; set; }
        public ApplicationUser Receiver { get; set; }

        [ForeignKey("ParentMessage")]
        public int? ParentMessageID { get; set; }
        public Message ParentMessage { get; set; }

        [Required]
        public DateTimeOffset SentDate { get; set; }
        public DateTimeOffset? ReadDate { get; set; }
        public MessageStatus ReceiverStatus { get; set; }
        public MessageStatus SenderStatus { get; set; }

        [MaxLength(140, ErrorMessage = "{0} must be less than {1} characters long")]
        public string Subject { get; set; }

        [Required]
        [MaxLength(700, ErrorMessage = "{0} must be less than {1} characters long")]
        public string Content { get; set; }

    }
}