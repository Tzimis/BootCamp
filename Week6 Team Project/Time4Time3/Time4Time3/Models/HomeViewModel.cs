using Time4Time3.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Time4Time3.Models
{
    public class HomeViewModel
    {
        public List<ApplicationUser> UsersWithMostServices { get; set; }
        public List<Service> MostRequestedServices { get; set; }
        public Dictionary<Service, double?> HighestRatedServices { get; set; }

        

        public HomeViewModel()
        {
            UsersWithMostServices = new List<ApplicationUser>();
            MostRequestedServices = new List<Service>();
            HighestRatedServices = new Dictionary<Service, double?>();
        }
    }
}