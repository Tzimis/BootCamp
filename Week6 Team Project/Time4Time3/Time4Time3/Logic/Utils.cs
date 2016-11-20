using Time4Time3.Entities;
using Time4Time3.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading.Tasks;
using System.Data.Entity;

namespace Time4Time3.Logic
{
    public static class Utils
    {
        public static string GetFullName(ApplicationUser user)
        {
            if (user != null)
            {
                if (string.IsNullOrWhiteSpace(user.FirstName) && string.IsNullOrWhiteSpace(user.LastName)) return user.UserName;
                if (string.IsNullOrWhiteSpace(user.FirstName)) return user.LastName + " (" + user.UserName + ")";
                else if (string.IsNullOrWhiteSpace(user.LastName)) return user.FirstName + " (" + user.UserName + ")";
                else return user.FirstName + " " + user.LastName;
            }
            return "Empty";
        }

        public static int GetUnreadMessages(string userID)
        {
            int messagesCount = 0;
            using (ApplicationDbContext db = new ApplicationDbContext())
            {
                messagesCount = db.Messages.Where(m => m.ReceiverID == userID && m.ReceiverStatus == MessageStatus.Available).Count(m => m.ReadDate == null);
            }
            return messagesCount;
        }
    }
}