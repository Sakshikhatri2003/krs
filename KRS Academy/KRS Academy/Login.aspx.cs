using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using WebApp.LIBS;

namespace KRS_Academy
{
    public partial class Login : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["KRS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void button_Click(object sender, EventArgs e)
        {
            SqlDataAdapter da = new SqlDataAdapter("select * from Login where UserName = '" + textbox1.Text + "' and Password = '" + textbox2.Text + "'", connectionString);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                SiteSession.IsLoggedIn = true;
                if(textbox1.Text == "Admin")
                {
                    Response.Redirect("~/Admin/Dashboard.aspx");
                }
                else
                {
                    Response.Redirect("~/Student/Dashboard.aspx");
                }
            }
            else
            {
                Response.Write("<script>alert('invalid user_name or password')</script>");
            }

            textbox1.Text = "";
            textbox2.Text = "";
        }
    }
}