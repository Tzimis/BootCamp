using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Time4Time3.Models;
using Time4Time3.Entities;
using System.Threading.Tasks;
using System.Data.Entity;

namespace Time4Time3.Controllers
{
    public class SearchController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();
        public ActionResult Results(string searchWord)
        {
            var a = new List<SearchViewModel>();
            var ServicesList = new List<Entities.Service>();
            var Results = new List<Entities.Service>();

            using (ApplicationDbContext db = new ApplicationDbContext())
            {

                if (!string.IsNullOrEmpty(searchWord))
                {
                    // Break the string to words separated by space
                    List<string> words = searchWord.Split(' ').ToList();
                    
                    // Select from db all active Services that contain any of the words in their Title/Descr/ProviderName etc.
                    ServicesList = db.Services.Include("Supplier")
                        .Where(s => (s.IsActive == Entities.Service.ServiceStatus.Active) && (words
                               .Any(w => (s.Title + " " + s.Description + " " + s.Supplier.FirstName + " " + s.Supplier.LastName + " " + s.Supplier.UserName + " " + s.Location)
                               .Contains(w)))
                        ).ToList();

                    // Rate them and add them to a dictionary<service, rating>
                    Dictionary<Service, int> OrderingTable = new Dictionary<Service, int>();
                    foreach (Service s in ServicesList)
                    {
                        int relevanceRating = 0;
                        foreach (string w in words)
                        {
                            // Each occurence of word has a specified weight
                            if (s.Title.Contains(w)) relevanceRating += 2;
                            if (s.Location.Contains(w)) relevanceRating += 5;
                            if (s.Supplier.FirstName.Contains(w)) relevanceRating += 3;
                            if (s.Supplier.LastName.Contains(w)) relevanceRating += 3;
                            if (s.Supplier.UserName.Contains(w)) relevanceRating += 3;
                            if (s.Description.Contains(w)) relevanceRating += 1;
                        }
                        OrderingTable.Add(s, relevanceRating);
                    }

                    // Order the Dictionary by descending rating and get the Services list
                    Results = OrderingTable.OrderByDescending(x => x.Value).Select(x => x.Key).ToList();
                }
                else // if search string is empty return every active service
                {
                    Results = db.Services.Where(s => s.IsActive == Entities.Service.ServiceStatus.Active).ToList();
                }

                foreach (var s in Results)
                {
                    var newItem = new SearchViewModel()
                    {
                        Id = s.Id,
                        Title = s.Title,
                        Description = s.Description,
                        Onoma = s.Supplier.FirstName + " " + s.Supplier.LastName,
                        CreditWorth = s.CreditWorth,
                        SupplierId = s.SupplierId,
                        Location = s.Location,
                        ImagePath = s.ImagePath,
                        Rating = db.Transactions.Where(t=> t.Service_Id == s.Id).Average(t => t.Rating)
                    };
                    a.Add(newItem);
                }
            }

            if (a.Count() == 0)
                return View();
            else
                return View(a);
        }

        public ActionResult Service(int id)
        {
            var s = db.Services.Where(x => x.Id == id).FirstOrDefault();
            var ServiceToSee = new SearchViewModel
            {
                Id = s.Id,
                Title = s.Title,
                Onoma = s.Supplier.FirstName + " " + s.Supplier.LastName,
                CreditWorth = s.CreditWorth,
                Description = s.Description,
                Location = s.Location,
                ImagePath = s.ImagePath,
                SupplierId = s.SupplierId
            };
            return View(ServiceToSee);
        }


        [AllowAnonymous]
        public async Task<ActionResult> MemberProfile(string userId, string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            ApplicationUser member = await db.Users.Include(u => u.Services).Where(u => u.Id == userId).FirstOrDefaultAsync();
            if (member != null && member.ProfileStatus == ApplicationUser.Status.Active)
            {
                return View(member);
            }
            return View();
        }

    }

}