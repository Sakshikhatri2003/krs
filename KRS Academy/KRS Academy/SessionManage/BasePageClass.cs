 
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using WebApp.LIBS;

namespace WebApp.LIBS
{
    public class BasePageClass : System.Web.UI.Page
    {
        protected override void OnPreInit(EventArgs e)
        {
            base.OnPreInit(e);
            string pagename = e.ToString();

            if (!SiteSession.IsLoggedIn)
            {


                if (Request.RawUrl.Contains("admin"))
                {
                    Response.Redirect("~/Login.aspx?ReturnUrl=" + Request.RawUrl, true);
                }


            }


           
        }
    }
}

