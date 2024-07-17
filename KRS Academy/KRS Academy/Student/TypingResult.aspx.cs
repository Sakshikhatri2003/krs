using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using WebApp.LIBS;

namespace KRS_Academy.Student
{
    public partial class TypingResult : BasePageClass
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["KRS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT t.Test_id, t.Date, tm.TestName, t.StudentName, t.MobileNo
                    FROM TestMaster t
                    JOIN TypingMaster tm ON t.Typing_id = tm.TypingId";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                example1.DataSource = dt;
                example1.DataBind();
            }
        }

        protected void example1_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "View")
            {
                int testId = Convert.ToInt32(e.CommandArgument);
                hfTypingId.Value = testId.ToString();
                Response.Redirect("TypingReview.aspx?Id=" + hfTypingId.Value, false);
            }
        }
    }
}
