namespace T4TMailbox
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Service
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Service()
        {
            Messages = new HashSet<Message>();
        }

        public int ServiceID { get; set; }

        public int OfferedBy { get; set; }

        [Required]
        [StringLength(120)]
        public string ServiceTitle { get; set; }

        [StringLength(500)]
        public string ServiceDescription { get; set; }

        public decimal CreditsRequested { get; set; }

        [Required]
        [StringLength(50)]
        public string City { get; set; }

        [StringLength(100)]
        public string ImagePath { get; set; }

        public bool Active { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Message> Messages { get; set; }

        public virtual User User { get; set; }
    }
}
