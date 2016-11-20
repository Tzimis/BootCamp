using Time4Time3.Entities;
using Time4Time3.Models;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Time4Time3.Controllers
{
    public class HomeController : Controller
    {
        public async Task<ActionResult> Index()
        {
            HomeViewModel vm = new HomeViewModel();
            using (ApplicationDbContext db = new ApplicationDbContext())
            {
                // MOST REQUESTED SERVICES
                vm.MostRequestedServices = await db.Services.Include("Transactions").OrderByDescending(s => s.Transactions.Count()).Take(3).ToListAsync();

                // TOP OFFERERS
                // Select top 3 users Ordered by count of Services offered
                vm.UsersWithMostServices = await db.Users.Include("Services").OrderByDescending(u => u.Services.Count(s => s.IsActive == Service.ServiceStatus.Active)).AsNoTracking().Take(3).ToListAsync();
                // Keep only actice services
                foreach (ApplicationUser u in vm.UsersWithMostServices)
                {
                    u.Services = u.Services.Where(s => s.IsActive == Service.ServiceStatus.Active).ToList();
                }

                // TOP RATED SERVICES
                List<Service> HighestRated = await db.Services.OrderByDescending(s => s.Transactions.Average(t => t.Rating)).Take(3).ToListAsync();
                // BUILD THE DICTIONARY 
                foreach (Service s in HighestRated)
                {
                    double? rating = s.Transactions.Average(t => t.Rating);
                    vm.HighestRatedServices.Add(s, rating);
                }

            }
            return View(vm);
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

      //public ActionResult Search(string searchWord)
      //  {
      //      var a = new List<SearchViewModel>();
      //      var ServicesList = new List<Entities.Service>();

      //      using (ApplicationDbContext db = new ApplicationDbContext())
      //      {

      //          if (!string.IsNullOrEmpty(searchWord))
      //          {

      //              ServicesList = db.Services.Where(x => x.Title.Contains(searchWord) ||
      //                                                                      x.Supplier.FirstName.Contains(searchWord) ||
      //                                                                      x.Supplier.LastName.Contains(searchWord)).ToList();

      //          }

      //          foreach (var s in ServicesList)
      //          {
      //              var newItem = new SearchViewModel()
      //              {
      //                  Id = s.Id,
      //                  Title = s.Title,
      //                  Onoma = s.Supplier.FirstName + " " + s.Supplier.LastName,
      //                  CreditWorth = s.CreditWorth
      //              };
      //              a.Add(newItem);
      //          }
      //      }

      //      if (a.Count() == 0)
      //          return View();
      //      else
      //          return View(a);
      //  }

    }
}