using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace KRS_Academy.Student
{
    public partial class Typing : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["KRS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            string query = "SELECT * FROM TypingMaster";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                TypingTable.DataSource = dt;
                TypingTable.DataBind();
            }
        }
        protected void TypingTable_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Start")
            {
                int typingId = Convert.ToInt32(e.CommandArgument);
                hfTypingId.Value = typingId.ToString();

                Response.Redirect("~/TypingStart.aspx?Id=" + hfTypingId.Value);
            }
        }

    }
}