using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Time4Time3
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
              name: "Message",
              url: "Message/View/{id}",
              defaults: new { controller = "Message", action = "Index", id = UrlParameter.Optional }
          );

            routes.MapRoute(
                name: "CreateMessage",
                url: "Message/{msgaction}/{id}",
                defaults: new
                {
                    controller = "Message",
                    action = "Create",
                    msgaction = "New",
                    id = "-1"
                }
            );

            routes.MapRoute(
                name: "Messages",
                url: "Messages/{mailbox}/{page}",
                defaults: new
                {
                    controller = "Messages",
                    action = "Index",
                    mailbox = UrlParameter.Optional,
                    page = UrlParameter.Optional
                }
            );



            routes.MapRoute(
                name: "DeleteService",
                url: "Profile/DeleteService",
                defaults: new { controller = "Profile", action = "DeleteService"}
            );


            routes.MapRoute(
                name: "Profile",
                url: "Profile/{username}",
                defaults: new { controller = "Profile", action = "Index", username = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "EditProfile",
                url: "Profile/Edit/{username}",
                defaults: new { controller = "Profile", action = "Edit", username = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "RateService",
                url: "Profile/Rate/{id}",
                defaults: new { controller = "Profile", action = "Rate"}
            );

            routes.MapRoute(
                name: "EditService",
                url: "Profile/EditService/{id}",
                defaults: new { controller = "Profile", action = "EditService", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "NewService",
                url: "Profile/NewService/",
                defaults: new { controller = "Profile", action = "EditService", id = -1 }
            );

            routes.MapRoute(
               name: "Default",
               url: "{controller}/{action}/{id}",
               defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
           );
        }
    }
}
