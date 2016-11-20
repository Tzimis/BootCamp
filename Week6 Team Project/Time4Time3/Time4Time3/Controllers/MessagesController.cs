using Time4Time3.Entities;
using Time4Time3.Logic;
using Time4Time3.Models;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Time4Time3.Controllers
{
    [Authorize]
    public class MessagesController : Controller
    {

        // GET: Messages Index
        public async Task<ActionResult> Index(MailBox MailBox = MailBox.Inbox, int? page = 1)
        {
            List<MessagesViewModel> vmList = await GetListOfMessages(MailBox);
            ViewBag.UnreadCountInfo = UnreadMsgCountInfo(vmList, MailBox);
            ViewBag.Page = page;
            return View(vmList);
        }


        // POST: Messages Index
        [HttpPost]
        public async Task<ActionResult> Index(MailBox MailBox = MailBox.Inbox, string msgaction = "", string id = "")
        {
            int MessageID = 0;
            bool idIsInt = int.TryParse(id, out MessageID);
            string userID = User.Identity.GetUserId();

            Message message = null;
            if (idIsInt)
            {
                using(ApplicationDbContext db = new ApplicationDbContext())
                {
                    // Find Message if it belongs to the current application user
                    message = await db.Messages.Where(m => 
                    m.MessageID == MessageID 
                    && (m.SenderID == userID || m.ReceiverID == userID)
                    ).FirstOrDefaultAsync();

                    if (message == null) return RedirectToAction("Index", new { mailbox = MailBox });

                    // Determine if the User is the Sender or the Receiver
                    bool IsSender = (message.SenderID == userID);

                    bool aChangeWasMade = false;
                    // If we've come this far the message is found
                    if (msgaction.Equals("Trash"))
                    {
                        aChangeWasMade = await UpdateMessageStatus(message: message, IsSender: IsSender, newStatus:MessageStatus.Trashed, targetMailbox: MailBox.Trash, dbContext: db);
                    }
                    if (msgaction.Equals("Restore"))
                    {
                        aChangeWasMade = await UpdateMessageStatus(message: message, IsSender: IsSender, newStatus: MessageStatus.Available, targetMailbox: (IsSender)? MailBox.Sent : MailBox.Inbox, dbContext: db);
                    }
                    if (msgaction.Equals("Shred"))
                    {
                        aChangeWasMade = await UpdateMessageStatus(message: message, IsSender: IsSender, newStatus: MessageStatus.Deleted, targetMailbox: null, dbContext: db);
                    }

                    if (!aChangeWasMade)
                    {
                        ViewBag.Message = $"No changes made";
                        ViewBag.MessageConnotation = 0; // Negative feedback
                    }
                }
            }

            // Just passing the messages of this mailbox (as in GET version)
            List<MessagesViewModel> vmList = await GetListOfMessages(MailBox);
            ViewBag.UnreadCountInfo = UnreadMsgCountInfo(vmList, MailBox);
            return View(vmList);
        }

        private async Task<bool> UpdateMessageStatus(Message message, bool IsSender, MessageStatus newStatus, MailBox? targetMailbox, ApplicationDbContext dbContext)
        {
            if (IsSender)
            {
                if (message.SenderStatus == newStatus) return false;
                message.SenderStatus = newStatus;
            }
            else
            {
                if (message.ReceiverStatus == newStatus) return false;
                message.ReceiverStatus = newStatus;
            }
            try
            {
                await dbContext.SaveChangesAsync();
                ViewBag.Message = (targetMailbox == null)? "Message deleted permanently." : "Message moved to " + targetMailbox + ".";
                ViewBag.MessageConnotation = 1; // Positive feedback
            }
            catch (Exception e)
            {
                ViewBag.Message = $"Ooops! Something went wrong with the Database ({e.Message}).";
                ViewBag.MessageConnotation = -1; // Negative feedback
                return false;
            }
            return true;
        }

        private async Task<List<MessagesViewModel>> GetListOfMessages(MailBox MailBox)
        {
            List<MessagesViewModel> vmList = new List<MessagesViewModel>();
            string userID = User.Identity.GetUserId();
            int maxSubjectLength = 80;
            int maxContentLength = 150;

            switch (MailBox)
            {
                case MailBox.Sent:
                    ViewBag.Title = MailBox.Sent;
                    ViewBag.MailBox = MailBox.Sent;
                    using (ApplicationDbContext db = new ApplicationDbContext())
                    {
                        List<Message> sentMessages = await db.Messages.Include("Receiver").Where(m => m.SenderID == userID && m.SenderStatus == MessageStatus.Available).OrderByDescending(m => m.SentDate).ToListAsync();
                        if (sentMessages.Count() > 0)
                        {
                            vmList.AddRange(sentMessages.Select(m => new MessagesViewModel()
                            {
                                MessageID = m.MessageID,
                                CorrespondentID = m.ReceiverID,
                                CorrespondentName = Utils.GetFullName(m.Receiver),
                                SentDate = GetRelativeDate(m.SentDate),
                                IsRead = (m.ReadDate != null),
                                Status = m.SenderStatus,
                                Mailbox = MailBox.Sent,
                                Subject = ShortenText(m.Subject, maxSubjectLength),
                                Content = ShortenText(m.Content, maxContentLength),
                            }).ToList());
                        }
                    }
                    break;
                case MailBox.Trash:
                    ViewBag.Title = MailBox.Trash;
                    ViewBag.MailBox = MailBox.Trash;
                    using (ApplicationDbContext db = new ApplicationDbContext())
                    {
                        List<Message> deletedMessages = await db.Messages.Include("Sender").Include("Receiver").Where(m =>
                           (m.SenderID == userID && m.SenderStatus == MessageStatus.Trashed) ||
                           (m.ReceiverID == userID && m.ReceiverStatus == MessageStatus.Trashed)
                            ).OrderByDescending(m => m.SentDate).ToListAsync();
                        if (deletedMessages.Count() > 0)
                        {
                            vmList.AddRange(deletedMessages.Select(m => new MessagesViewModel()
                            {
                                MessageID = m.MessageID,
                                CorrespondentID = (m.SenderID == userID) ? m.ReceiverID : m.SenderID,
                                CorrespondentName = (m.SenderID == userID) ? Utils.GetFullName(m.Receiver) : Utils.GetFullName(m.Sender),
                                SentDate = GetRelativeDate(m.SentDate),
                                IsRead = (m.ReadDate != null),
                                Status = m.ReceiverStatus,
                                Mailbox = MailBox.Trash,
                                Subject = ShortenText(m.Subject, maxSubjectLength),
                                Content = ShortenText(m.Content, maxContentLength),
                            }).ToList());
                        }
                    }
                    break;
                case MailBox.Inbox:
                default:
                    ViewBag.Title = MailBox.Inbox;
                    ViewBag.MailBox = MailBox.Inbox;
                    using (ApplicationDbContext db = new ApplicationDbContext())
                    {
                        List<Message> receivedMessages = await db.Messages.Include("Sender").Where(m => m.ReceiverID == userID && m.ReceiverStatus == MessageStatus.Available).OrderByDescending(m => m.SentDate).ToListAsync();
                        if (receivedMessages.Count() > 0)
                        {
                            vmList.AddRange(receivedMessages.Select(m => new MessagesViewModel()
                            {
                                MessageID = m.MessageID,
                                CorrespondentID = m.SenderID,
                                CorrespondentName = Utils.GetFullName(m.Sender),
                                SentDate = GetRelativeDate(m.SentDate),
                                IsRead = (m.ReadDate != null),
                                Status = m.ReceiverStatus,
                                Mailbox = MailBox.Inbox,
                                Subject = ShortenText(m.Subject, maxSubjectLength),
                                Content = ShortenText(m.Content, maxContentLength),
                            }).ToList());
                        }
                    }
                    break;
            }
            // Built a Session variable for the List of messages in this MailBox
            List<int> IdList = new List<int>();
            foreach(MessagesViewModel m in vmList)
            {
                IdList.Add(m.MessageID);
            }

            Session["MessageList"] = IdList;

            return vmList;
        }

        private string ShortenText(string text, int length)
        {
            string ellispsis = "...";
            // Decode and remove HTML tags
            text = @Regex.Replace(WebUtility.HtmlDecode(text), "<.*?>", string.Empty);
            if (text.Length <= length) return text;
            return text.Substring(0, length - ellispsis.Length) + ellispsis;
        }

        private enum Months { Jan = 1, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec };
        private string GetRelativeDate(DateTimeOffset time)
        {
            
            if (DateTime.UtcNow - time < new TimeSpan(24, 0, 0)) // less than 1 day
            {
                return $"{time.Hour}:{time.Minute,0:00}";
            }
            if (DateTime.UtcNow - time < new TimeSpan(7, 0, 0, 0)) // less than 1 week
            {
                return $"{time.DayOfWeek.ToString().Substring(0,3)} {time.Hour}:{time.Minute,0:00}";
            }
            if (DateTime.UtcNow - time < new TimeSpan(365, 0, 0, 0)) // less than 1 month
            {
                return time.Day + " " + (Months) time.Month;
            }
            return time.Day + "/" + time.Month + "/" + time.Year;
        }

        private string UnreadMsgCountInfo(List<MessagesViewModel> vmList, MailBox MailBox)
        {
            int unread = vmList.Count(m => !m.IsRead);
            int total = vmList.Count();
            if (MailBox == MailBox.Trash) return "";

            string result = "";

           

            if (total == 0)
                result = "No messages in " + MailBox;
            else if (unread == 0 && total == 1)
            {
                if (MailBox == MailBox.Inbox) result = "1 read message";
                else result = "You've sent 1 message and it's been read";
            }
                
            else if (unread == 1 && total == 1)
            {
                if (MailBox == MailBox.Inbox) result = "1 unread message";
                else result = "You've sent 1 message and it has not been read";
            }
            else if (unread == 0 && total > 0)
            {
                if (MailBox == MailBox.Inbox) result = total + "read messages";
                else result = "You've sent " + total + " messages and they've been read";
            }
            else if (unread == 1 && total > 1)
            {
                if (MailBox == MailBox.Inbox) result = "1 unread message out of " + total;
                else result = "You've sent " + total + " messages and 1 has not been read";
            }

            else if (unread == total && total > 1)
            {
                if (MailBox == MailBox.Inbox) result = total + " unread messages";
                else result = "You've sent " + total + " messages and none has been read";
            }


            else
            {
                if (MailBox == MailBox.Inbox) result = unread + " unread messages out of " + total;
                else result = "You've sent " + total + " messages and " + unread + " have not been read";
            }
            return result;
        }
    }
}