using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Time4Time3.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Time4Time3.Entities;
using System.IO;

namespace Time4Time3.Controllers
{
    [Authorize]
    public class ProfileController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext(); 

        private ApplicationSignInManager _signInManager;
        private ApplicationUserManager _userManager;

        public ProfileController()
        {
        }

        public ProfileController(ApplicationUserManager userManager, ApplicationSignInManager signInManager)
        {
            UserManager = userManager;
            SignInManager = signInManager;
        }

        public ApplicationSignInManager SignInManager
        {
            get
            {
                return _signInManager ?? HttpContext.GetOwinContext().Get<ApplicationSignInManager>();
            }
            private set
            {
                _signInManager = value;
            }
        }

        public ApplicationUserManager UserManager
        {
            get
            {
                return _userManager ?? HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
            }
            private set
            {
                _userManager = value;
            }
        }

        ApplicationUser user = System.Web.HttpContext.Current.GetOwinContext().GetUserManager < ApplicationUserManager>().FindById(System.Web.HttpContext.Current.User.Identity.GetUserId());
        
        public async Task<ActionResult> Index()
        {
            var username =  User.Identity.GetUserName();
            if (username == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ApplicationUser applicationUser = await UserManager.FindByNameAsync(username);
            if (applicationUser == null)
            {
                return HttpNotFound();
            }
            var userProfile = new ProfileViewModel()
            {
                FirstName = applicationUser.FirstName,
                LastName = applicationUser.LastName,
                City = applicationUser.City,
                Address = applicationUser.Address,
                PostalCode = applicationUser.PostalCode,
                Email = applicationUser.Email,
                ImagePath = applicationUser.ImagePath,
                OwnedCredits = applicationUser.CreditsOwned,
                Services = applicationUser.Services.Where(s => s.IsActive != Service.ServiceStatus.Deleted).OrderByDescending(s => s.Id).ToList(),
                Todo = await db.Transactions
                               .Where(t => t.Service.Supplier.UserName == username && (t.Status == Transaction.TransactionStatus.New|| t.Status == Transaction.TransactionStatus.Accepted)).OrderByDescending(s => s.StartDate).ToListAsync(),
                Transactions = await db.Transactions
                                       .Where(t => (t.Service.Supplier.UserName == username || t.Sender.UserName == username) && ( t.Status == Transaction.TransactionStatus.Cancelled || t.Status == Transaction.TransactionStatus.Completed)).OrderByDescending(s => s.StartDate).ToListAsync(),
                Requests = applicationUser.Transactions
                                          .Where(t => t.Sender.UserName == username && (t.Status != Transaction.TransactionStatus.Cancelled && t.Status != Transaction.TransactionStatus.Completed)).OrderByDescending(s => s.StartDate).ToList()
            };
            return View(userProfile);
        }

        // GET: Profile/Edit/username
        public async Task<ActionResult> Edit(string username)
        {
            if (username == null || username != User.Identity.GetUserName())
            {
                return RedirectToAction("Index");
            }
            ApplicationUser applicationUser = await UserManager.FindByNameAsync(username);
            if (applicationUser == null)
            {
                return HttpNotFound();
            }
            var userProfile = new ProfileEditModel()
            {
                FirstName = applicationUser.FirstName,
                LastName = applicationUser.LastName,
                City = applicationUser.City,
                Email = applicationUser.Email,
                Address = applicationUser.Address,
                PostalCode = applicationUser.PostalCode
        };

            return View(userProfile);
        }

        // POST: Profile/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit(ProfileEditModel model)
        {
            if (ModelState.IsValid)
            {
                user.City = model.City;
                user.FirstName = model.FirstName;
                user.LastName = model.LastName;
                user.Email = model.Email;
                user.Address = model.Address;
                user.PostalCode = model.PostalCode;
                user.City = model.City;

                if (model.ImagePath != null && model.ImagePath.ContentLength > 0)
                {

                    string serverPath = "~/Assets/UserImages";

                    string path = Path.Combine(Server.MapPath(serverPath), user.Id + Path.GetFileName(model.ImagePath.FileName));
                    model.ImagePath.SaveAs(path);
                    user.ImagePath = serverPath + "/" + user.Id + Path.GetFileName(model.ImagePath.FileName);

                }

                await UserManager.UpdateAsync(user);
                return RedirectToAction("Index");
            }
            return View(user);
        }

        public async Task<ActionResult> EditService(int? id)
        {
           
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            if (id == -1)
            {
                ViewBag.Title = "New Service";
                var NewServiceModel = new ProfileServiceEditModel
                {
                    Title = "",
                    Description = "",
                    CreditWorth = 0,
                    IsActive = Service.ServiceStatus.Active,
                    Location = "",
                    _viewStatusList = new List<Service.ServiceStatus> { Service.ServiceStatus.Active, Service.ServiceStatus.Inactive },
                    ImagePath = null
                };
                return View(NewServiceModel);
            }
            ViewBag.Title = "Edit Service";
            string currentUserId = User.Identity.GetUserId();
            ApplicationUser currentUser = await UserManager.FindByIdAsync(currentUserId);
            IList<Service> userServices = currentUser.Services.Where(s => s.IsActive != Service.ServiceStatus.Deleted).ToList();
            var service = userServices.FirstOrDefault(s => s.Id as int? == id);

            if (service == null)
            {
                return HttpNotFound();
            }
            var serviceModel = new ProfileServiceEditModel
            {
                Title = service.Title,
                Description = service.Description,
                CreditWorth = service.CreditWorth,
                IsActive = service.IsActive,
                Location = service.Location,
                _viewStatusList = new List<Service.ServiceStatus> { Service.ServiceStatus.Active , Service.ServiceStatus.Inactive}
                //ImagePath = service.ImagePath
            };
            return View(serviceModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> EditService(ProfileServiceEditModel model)
        {
            Service service = new Service() { SupplierId = user.Id};
            if(model.Id != -1)
            {
                service = await db.Services.FirstOrDefaultAsync(s => s.Id == model.Id);
            }
           
            if (ModelState.IsValid)
            {

                service.Title = model.Title;
                service.Description = model.Description;
                service.CreditWorth = model.CreditWorth;
                service.Location = model.Location;
                service.IsActive = model.IsActive;
                if( model.ImagePath != null && model.ImagePath.ContentLength > 0)
                {

                    string serverPath = "~/Assets";
               
                    string path = Path.Combine(Server.MapPath(serverPath), user.Id+Path.GetFileName(model.ImagePath.FileName));
                    model.ImagePath.SaveAs(path);
                    service.ImagePath = serverPath + "/" +user.Id + Path.GetFileName(model.ImagePath.FileName);
                  
                }
                if(model.Id == -1)
                {
                    db.Services.Add(service);
                }
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            return View(model);
        }
        
        [HttpPost]
        public async Task<ActionResult> DeleteService(int? serviceId)
        {

            var service = await db.Services.FirstOrDefaultAsync(s => s.Id == serviceId);
            service.IsActive = Service.ServiceStatus.Deleted;
            

            await db.SaveChangesAsync();
            return RedirectToAction("Index");

        }
   
        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }


        public async Task<ActionResult> AcceptRequest(int? id)
        {
            if (id != null)
            {
                Transaction tr = await db.Transactions.Include(t => t.Service.Supplier).FirstOrDefaultAsync(t => t.Id == id);
                if (tr != null && tr.Status == Transaction.TransactionStatus.New && tr.AcceptDate == null
                    && tr.Service.Supplier.Id == User.Identity.GetUserId())
                {
                    try
                    {
                        // Send a message to Sender
                        Message newMessage = new Message()
                        {
                            SenderID = User.Identity.GetUserId(),
                            ReceiverID = tr.Sender_Id,
                            TransactionId = tr.Id,
                            ParentMessageID = null,
                            SentDate = DateTimeOffset.Now,
                            ReceiverStatus = MessageStatus.Available,
                            SenderStatus = MessageStatus.Available,
                            Subject = "Request Accepted",
                            Content = $"Your request for my service \"{tr.Service.Title}\" was accepted. Please contact me to arrange the details."
                        };
                        db.Messages.Add(newMessage);


                        tr.AcceptDate = DateTimeOffset.Now;
                        tr.Status = Transaction.TransactionStatus.Accepted;
                        await db.SaveChangesAsync();
                    }
                    catch (Exception e)
                    {
                        ViewBag.Message = "Oops! Something went wrong with the DataBase. Error: " + e.Message;
                        ViewBag.Connotation = -1;
                    }
                }
            }
            return RedirectToAction("Index");
        }

        public async Task<ActionResult> DeclineRequest(int? id)
        {
            if (id != null)
            {
                Transaction tr = await db.Transactions.Include("Service").FirstOrDefaultAsync(t => t.Id == id);
                if (tr != null && (tr.Status == Transaction.TransactionStatus.New || tr.Status == Transaction.TransactionStatus.Accepted) && tr.CancelDate == null)
                {
                    try
                    {
                        string thisUserID = User.Identity.GetUserId();
                        string otherUserID = (tr.Sender_Id == thisUserID) ? tr.Service.SupplierId : tr.Sender_Id;

                        // Send a message to Offerer
                        Message newMessage = new Message()
                        {
                            SenderID = thisUserID,
                            ReceiverID = otherUserID,
                            TransactionId = tr.Id,
                            ParentMessageID = null,
                            SentDate = DateTimeOffset.Now,
                            ReceiverStatus = MessageStatus.Available,
                            SenderStatus = MessageStatus.Available,
                            Subject = "Transaction Cancelled",
                            Content = $"The transaction for the service \"{tr.Service.Title}\" was canceled."
                        };
                        db.Messages.Add(newMessage);

                        // UpdateTransaction
                        tr.CancelDate = DateTimeOffset.Now;
                        tr.CreditValue = 0;
                        tr.Status = Transaction.TransactionStatus.Cancelled;
                        await db.SaveChangesAsync();
                    }
                    catch (Exception e)
                    {
                        ViewBag.Message = "Oops! Something went wrong with the DataBase. Error: " + e.Message;
                        ViewBag.Connotation = -1;
                    }
                }
            }
            return RedirectToAction("Index");
        }

        public async Task<ActionResult> Rate(int? id)
        {
            if (id != null)
            {
                Transaction tr = await db.Transactions.FirstOrDefaultAsync(t => t.Id == id);
                if (tr.Sender_Id == User.Identity.GetUserId() && tr.Service.SupplierId != User.Identity.GetUserId() && tr.Status == Transaction.TransactionStatus.Accepted)
                    return View(tr);
            }
            return RedirectToAction("Index");
        }

        [HttpPost]
        public async Task<ActionResult> Rate(int id, int rating, bool denyCredits = false)
        {
            Transaction tr = await db.Transactions.Include("Service").FirstOrDefaultAsync(t => t.Id == id);
            if (tr != null && tr.Status == Transaction.TransactionStatus.Accepted)
            {
                // if the guy who asked for this service has enough credits proceeed, else send him to an error page.
                if (user.CreditsOwned >= tr.CreditValue || denyCredits)
                {
                    //Find User that Offers the service to add the credits
                    ApplicationUser ServiceOfferer = await db.Users.FirstOrDefaultAsync(u => u.Id == tr.Service.SupplierId);
                    if (ServiceOfferer != null)
                    {
                        try
                        {
                            // Update Transaction
                            tr.CompleteDate = DateTimeOffset.Now;
                            tr.Status = Transaction.TransactionStatus.Completed;
                            tr.Rating = rating;

                            // Add Credits to service offerer
                            if (denyCredits)
                                tr.CreditValue = 0;
                            else
                            {
                                ServiceOfferer.CreditsOwned += tr.CreditValue;
                                user.CreditsOwned -= tr.CreditValue;
                            }

                            // Send a message to Offerer
                            Message newMessage = new Message()
                            {
                                SenderID = tr.Sender_Id,
                                ReceiverID = ServiceOfferer.Id,
                                TransactionId = tr.Id,
                                ParentMessageID = null,
                                SentDate = DateTimeOffset.Now,
                                ReceiverStatus = MessageStatus.Available,
                                SenderStatus = MessageStatus.Available,
                                Subject = "Transaction Completed",
                                Content = $"The transaction for your service \"{tr.Service.Title}\" was completed. {tr.CreditValue} credits were added to your account. Your service was rated {rating}/10."
                            };
                            db.Messages.Add(newMessage);

                            // Save changes to DB
                            await db.SaveChangesAsync();
                            return RedirectToAction("Index");
                        }
                        catch (Exception e)
                        {
                            ViewBag.Message = "Oops! Something went wrong with the DataBase. Error: " + e.Message;
                            ViewBag.Connotation = -1;
                        }
                    }
                }
                else
                {
                    return RedirectToAction("Error", "Mistakes", new { mistake = $"You do not have enough credits for this service! You own {user.CreditsOwned} credits but this service is worth {tr.CreditValue} credits. Perform some more services to gain credits." });
                }
            }
            return RedirectToAction("Rate", new { id = id });
        }

public async Task<ActionResult> AskTransaction(int id)
        {
            // Find the requested service
            Service service = await db.Services.Include(s => s.Supplier).Where(x => x.Id == id).FirstOrDefaultAsync();

            // If this action is not already requested and not responded
            
            if (!db.Transactions.Where(x => x.Service.Id == id && x.Sender_Id == user.Id && x.Status == 0).Any())
            {
                if (service != null)
                {
                    // To be able to request a transaction the user must have enough credits to cover
                    // the cost of all pending requests plus this one.
                    decimal? pendingRequestsValue = db.Transactions.Where(t => t.Sender_Id == user.Id && (t.Status == Transaction.TransactionStatus.Accepted || t.Status == Transaction.TransactionStatus.New)).Sum(t => (decimal?)t.CreditValue);

                    if (pendingRequestsValue == null) pendingRequestsValue = 0;
                    bool HasEnoughCredits = (user.CreditsOwned - pendingRequestsValue - service.CreditWorth > 0);

                    if (HasEnoughCredits)
                    {
                        var newTransaction = new Entities.Transaction
                        {
                            Status = 0,
                            Sender_Id = User.Identity.GetUserId(),
                            Service_Id = id,
                            CreditValue = service.CreditWorth
                        };
                        db.Transactions.Add(newTransaction);
                        db.SaveChanges();

                        // Send a message to Provider
                        Message newMessage = new Message()
                        {
                            SenderID = User.Identity.GetUserId(),
                            ReceiverID = service.Supplier.Id,
                            TransactionId = newTransaction.Id,
                            ParentMessageID = null,
                            SentDate = DateTimeOffset.Now,
                            ReceiverStatus = MessageStatus.Available,
                            SenderStatus = MessageStatus.Available,
                            Subject = "New Request",
                            Content = $"You have a new request for your service \"{service.Title}\"."
                        };
                        db.Messages.Add(newMessage);
                        db.SaveChanges();
                    }
                    else
                    {
                        return RedirectToAction("Error", "Mistakes", new { mistake = $"You do not have enough credits to ask for this service! You own {user.CreditsOwned} credits, the sum of the pending requests you've asked for is {pendingRequestsValue} credits, so your available credits are {user.CreditsOwned - pendingRequestsValue}. This service is worth {service.CreditWorth} credits." });
                    }
                }
            }
            else
            {
                return RedirectToAction("Error", "Mistakes", routeValues: new { mistake = "You have already asked for that service" });
            }
            return RedirectToAction("Index");
        }
    }
}
