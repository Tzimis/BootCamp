using Time4Time3.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace Time4Time3.Models
{
    public class MessagesViewModel
    {
        public int MessageID { get; set; }
        public string CorrespondentID { get; set; }
        public string CorrespondentName { get; set; }
        public string SentDate { get; set; }
        public bool IsRead{ get; set; }
        public MessageStatus Status { get; set; }
        public MailBox Mailbox { get; set; }
        public string Subject { get; set; }
        public string Content { get; set; }

    }

    public class CreateMessageViewModel
    {
        public enum MessageAction
        {
            New,
            Reply,
            Forward
        }


        [Display(Name = "Subject")]
        [MaxLength(120, ErrorMessage = "{0} must be less than {1} characters long")]
        [AllowHtml]
        public string Subject { get; set; }

        [Required]
        [Display(Name = "Content")]
        [MaxLength(600, ErrorMessage = "{0} must be less than {1} characters long")]
        [AllowHtml]
        public string Content { get; set; }

        [Required]
        [Display(Name = "Receiver")]
        public string ReceiverID { get; set; }
        
        public MessageAction Action{ get; set; }
        public int? ParentMessageId { get; set; }
        public Message ParentMessage { get; set; }
        public int? RelatedTransactionID { get; set; }
        public List<ApplicationUser> Receivers { get; set; }

        public CreateMessageViewModel()
        {
            Receivers = new List<ApplicationUser>();
        }
    }

    public class CreateMessageViewModel2
    {
        public enum MessageAction
        {
            New,
            Reply,
            Forward
        }

        public Message NewMessage { get; set; }
        public MessageAction Action { get; set; }
        public Message ParentMessage { get; set; }
        public Transaction RelatedTransaction { get; set; }
        public List<ApplicationUser> Receivers { get; set; }

        public CreateMessageViewModel2()
        {
            Receivers = new List<ApplicationUser>();
        }
    }

}