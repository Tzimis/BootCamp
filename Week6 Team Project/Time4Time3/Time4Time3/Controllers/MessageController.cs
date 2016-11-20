using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Time4Time3.Models;
using Time4Time3.Entities;
using Microsoft.AspNet.Identity;
using System.Data.Entity;
using System.Threading.Tasks;
using System.Net;

namespace Time4Time3.Controllers
{
    public class MessageController : Controller
    {
        // GET: Message
        public async Task<ActionResult> Index(int id)
        {
            
            Message message;
            bool IsSender = false;
            using (ApplicationDbContext db = new ApplicationDbContext())
            {
                string userID = User.Identity.GetUserId();

                // Find the message if it belongs to this user and if is not deleted permanently
                message = await db.Messages.Include("Receiver").Include("Sender").Include("ParentMessage").Include(m => m.RelatedTransaction.Service.Supplier).FirstOrDefaultAsync(m =>
                m.MessageID == id
                && ( (m.SenderID == userID && m.SenderStatus != MessageStatus.Deleted) || (m.ReceiverID == userID && m.ReceiverStatus != MessageStatus.Deleted) ) );

                // Determine if this user is the sender or the receiver
                IsSender = (message.SenderID == userID);

                // Update ReadDate if thie message is unread
                if (!IsSender && message.ReadDate == null)
                {
                    message.ReadDate = DateTimeOffset.Now;
                    try
                    {
                        await db.SaveChangesAsync();
                        //ViewBag.Message = $"Message read just now";
                        //ViewBag.MessageConnotation = 1; // Positive feedback
                    }
                    catch(Exception e)
                    {
                        ViewBag.Message = $"Ooops! Could not update read status. Something went wrong with the Database.({e.Message}).";
                        ViewBag.MessageConnotation = -1; // Negative feedback
                    }
                }

            }

            if (message == null) return RedirectToAction("Index", "Messages");

            // Detect MailBox
            if (IsSender)
            {
                if (message != null && message.SenderStatus == MessageStatus.Trashed)
                    ViewBag.MailBox = MailBox.Trash;
                else
                {
                    ViewBag.MailBox = MailBox.Sent;
                }
            }
            else
            {
                if (message != null && message.ReceiverStatus == MessageStatus.Trashed)
                    ViewBag.MailBox = MailBox.Trash;
                else
                {
                    ViewBag.MailBox = MailBox.Inbox;
                }
            }

            return View(message);
        }

        
        // GET: Create new message
        public async Task<ActionResult> Create(int? id = -1, string msgaction  = "New")
        {
            // Gather available receivers
            List<ApplicationUser> AvailableReceivers = new List<ApplicationUser>();
            using (ApplicationDbContext db = new ApplicationDbContext())
            {
                AvailableReceivers = await db.Users.Where(u => u.ProfileStatus == ApplicationUser.Status.Active).AsNoTracking().ToListAsync();
            }


            // Construct a new ViewModel
            CreateMessageViewModel newVM = new CreateMessageViewModel()
            {
                Subject = "",
                Content = "",
                ReceiverID = "",
                Action = CreateMessageViewModel.MessageAction.New,
                ParentMessage = null,
                RelatedTransactionID = null,
                Receivers = AvailableReceivers
            };

            string userID = User.Identity.GetUserId();

            if ((msgaction.Equals(CreateMessageViewModel.MessageAction.Reply.ToString())
                || msgaction.Equals(CreateMessageViewModel.MessageAction.Forward.ToString()))
                && id > 0)
            {

                // Find parent message if it belongs to this user
                using (ApplicationDbContext db = new ApplicationDbContext())
                {
                    newVM.ParentMessage = await db.Messages.Include("Sender").Include("Receiver").Include("RelatedTransaction").Where(m => m.MessageID == id && (m.ReceiverID == userID || m.SenderID == userID)).AsNoTracking().FirstOrDefaultAsync();
                }

                // Only allow to Reply messages sent by others OR to Forward any message
                if (((msgaction.Equals(CreateMessageViewModel.MessageAction.Reply.ToString())) && newVM.ParentMessage.SenderID != userID) || msgaction.Equals(CreateMessageViewModel.MessageAction.Forward.ToString()))
                {
                    // if a message was found I must fill the other ViewModel variables
                    if (newVM.ParentMessage != null)
                    {

                        string prefix = "";
                        if (msgaction.Equals(CreateMessageViewModel.MessageAction.Reply.ToString())) { prefix = "Re: "; }
                        if (msgaction.Equals(CreateMessageViewModel.MessageAction.Forward.ToString())) { prefix = "Fw: "; }
                        newVM.Subject = prefix + newVM.ParentMessage.Subject;
                        newVM.ParentMessageId = newVM.ParentMessage.MessageID;
                        if (msgaction.Equals(CreateMessageViewModel.MessageAction.Forward.ToString())) newVM.Content = newVM.ParentMessage.Content;
                        newVM.ReceiverID = newVM.ParentMessage.SenderID;
                        if (msgaction.Equals(CreateMessageViewModel.MessageAction.Reply.ToString()))
                            newVM.Action = CreateMessageViewModel.MessageAction.Reply;
                        else if (msgaction.Equals(CreateMessageViewModel.MessageAction.Forward.ToString()))
                            newVM.Action = CreateMessageViewModel.MessageAction.Forward;

                        if (newVM.ParentMessage.RelatedTransaction != null)
                            newVM.RelatedTransactionID = newVM.ParentMessage.RelatedTransaction.Id;
                    }
                }
                return View(newVM);
            }
            else
            {
                return View(newVM);
            }

        }


        // POST: Create new message
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create(CreateMessageViewModel postVM)
        {

            if (ModelState.IsValid)
            {
                // Write to the DB!
                using (ApplicationDbContext db = new ApplicationDbContext())
                {
                    try
                    {
                        Message newMessage = new Message()
                        {
                            SenderID = User.Identity.GetUserId(),
                            ReceiverID = postVM.ReceiverID,
                            TransactionId = postVM.RelatedTransactionID,
                            ParentMessageID = postVM.ParentMessageId,
                            SentDate = DateTimeOffset.Now,
                            ReceiverStatus = MessageStatus.Available,
                            SenderStatus = MessageStatus.Available,
                            Subject = WebUtility.HtmlEncode(postVM.Subject),
                            Content = WebUtility.HtmlEncode(postVM.Content)
                        };
                        db.Messages.Add(newMessage);
                        await db.SaveChangesAsync();
                        TempData["Message"] = $"Message sent.";
                        TempData["MessageConnotation"] = 1; // Positive feedback
                        return RedirectToAction("Index", "Messages", new { mailbox = "Sent" });
                    }
                    catch (Exception e)
                    {
                        TempData["Message"] = $"Ooops! Something went wrong with the Database ({e.Message}).";
                        TempData["MessageConnotation"] = -1; // Negative feedback
                        return RedirectToAction("Index", "Messages");
                    }
                }
            }
            else
            {
                // if Model is invalid I resend it to the user
                using (ApplicationDbContext db = new ApplicationDbContext())
                {
                    postVM.ParentMessage = await db.Messages.FindAsync(postVM.ParentMessageId);
                    postVM.Receivers = await db.Users.Where(u => u.ProfileStatus == ApplicationUser.Status.Active).AsNoTracking().ToListAsync();
                }

            }
            return View(postVM);
        }
    }
}