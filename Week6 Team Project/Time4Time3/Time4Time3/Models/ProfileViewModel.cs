using System.Collections.Generic;
using Time4Time3.Entities;
using System.ComponentModel.DataAnnotations;
using System.Web;
using System.Web.Mvc;

namespace Time4Time3.Models
{
    public class ProfileViewModel
    {
        public string Id { get; set; }
        [Display(Name = "First Name ")]
        public string FirstName { get; set; }
        [Display(Name = "Last Name ")]
        public string LastName { get; set; }

        [Display(Name = "Full Name ")]
        public string FullName
        {
            get
            {
                return FirstName +" "+ LastName;
            }
        }
        [Display(Name = "City")]
        public string City { get; set; }
        [Display(Name = "Address")]
        public string Address { get; set; }
        [Display(Name = "Postal Code")]
        public string PostalCode { get; set; }
        [Display(Name = "Full Address")]
        public string FullAddress
        {
            get
            {
                if (PostalCode == null)
                {
                    return City + " , " + Address;
                }else if(Address == null)
                {
                return City + ". PO :" + PostalCode;
                }
                return City + " , " + Address + " , " + PostalCode;
            }
        }
        [Display(Name ="Credits ")]
        public decimal OwnedCredits { get; set; }
        [Display(Name = "E-mail ")]
        public string Email { get; set; }
        [Display(Name = "Status ")]
        public ApplicationUser.Status Status { get; set; }
        [Display(Name = "Profile Picture")]
        [DataType(DataType.Upload)]
        public string ImagePath { get; set; }

        [Display(Name ="My Services")]
        public IList<Service> Services {get;set;}
        [Display(Name = "My Requests")]
        public IList<Transaction> Requests { get; set; }
        [Display(Name = "To Do ")]
        public IList<Transaction> Todo { get; set; }
        [Display(Name = "History")]
        public IList<Transaction> Transactions { get; set; }
    }

    public class ProfileEditModel
    {
        public string Id { get; set; }
        [Display(Name ="First Name ")]
        public string FirstName { get; set; }
        [Display(Name = "Last Name ")]
        public string LastName { get; set; }
        [Display(Name = "City ")]
        public string City { get; set; }
        [Required]
        [Display(Name = "E-Mail ")]
        [DataType(DataType.EmailAddress, ErrorMessage = "Please enter a valid E-Mail")]
        public string Email { get; set; }
 
        [Display(Name = "Address")]
        public string Address { get; set; }
        [Display(Name = "Postal Code")]
        public string PostalCode { get; set; }
        [Display(Name = "Profile Picture")]
        [DataType(DataType.Upload)]
        public HttpPostedFileBase ImagePath { get; set; }



    }

    public class ProfileServiceEditModel
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        [Display(Name = "Service Availability ")]
        public Service.ServiceStatus IsActive { get; set; }
        [Display(Name = "Credits Asked ")]
        public decimal CreditWorth { get; set; }
        public string Location { get; set; }
        [Display(Name = "Service Image")]
        [DataType(DataType.Upload)]
        public HttpPostedFileBase ImagePath { get; set; }
        public List<Service.ServiceStatus> _viewStatusList { get; set; }
        public IEnumerable<SelectListItem> ViewStatuses
        {
            get { return new SelectList(_viewStatusList); }
        }
    }
}