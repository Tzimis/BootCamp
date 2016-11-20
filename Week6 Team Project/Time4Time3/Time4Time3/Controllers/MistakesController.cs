using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Time4Time3.Controllers
{
    public class MistakesController : Controller
    {
        // GET: Mistakes
        public ActionResult Error(string mistake)
        {
            ViewBag.Message = mistake;
            return View();
        }
        
    }
}