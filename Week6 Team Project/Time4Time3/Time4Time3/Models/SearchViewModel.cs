using System;
using System.Data.Entity;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System.Collections.Generic;
using Time4Time3.Entities;
using System.ComponentModel.DataAnnotations;
namespace Time4Time3.Models
{
    public class SearchViewModel
    {
        public int Id { get; set; }

        [Display(Name = "titlos")]
        public string Title { get; set; }
        public string Description { get; set; }
        public Decimal CreditWorth { get; set; }
        
        public string Location { get; set; }
        public string ImagePath { get; set; }
        [Display(Name ="onoma")]
        public string Onoma { get; set; }

        public string SupplierId { get; set; }

        public double? Rating { get; set; }
       
    }
}