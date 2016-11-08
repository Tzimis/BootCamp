namespace T4TMailbox
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Message
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Message()
        {
            Messages1 = new HashSet<Message>();
        }

        public int MessageID { get; set; }

        public int SenderID { get; set; }

        public int ReceiverID { get; set; }

        public int? RelatedServiceID { get; set; }

        public int? ReplyToMessageID { get; set; }

        public DateTime SentDate { get; set; }

        public DateTime? ReadDate { get; set; }

        public bool? IsDeletedBySender { get; set; }

        public bool? IsDeletedByReceiver { get; set; }

        public bool? IsPermanentlyDeletedBySender { get; set; }

        public bool? IsPermanentlyDeletedByReceiver { get; set; }

        [StringLength(80)]
        public string Subject { get; set; }

        [StringLength(500)]
        public string Text { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Message> Messages1 { get; set; }

        public virtual Message Message1 { get; set; }

        public virtual Service Service { get; set; }

        public virtual User User { get; set; }

        public virtual User User1 { get; set; }
    }
}
