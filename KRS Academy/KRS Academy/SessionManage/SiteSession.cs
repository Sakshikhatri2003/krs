 
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace WebApp.LIBS
{
    public class SiteSession
    {
        public static bool IsLoggedIn
        {
            get { return HttpContext.Current.Session["IsLoggedIn"] == null ? false : (bool)HttpContext.Current.Session["IsLoggedIn"]; }
            set { HttpContext.Current.Session["IsLoggedIn"] = value; }
        }

        public static bool IsExamStart
        {
            get { return HttpContext.Current.Session["IsExamStart"] == null ? false : (bool)HttpContext.Current.Session["IsExamStart"]; }
            set { HttpContext.Current.Session["IsExamStart"] = value; }
        }
    }
}