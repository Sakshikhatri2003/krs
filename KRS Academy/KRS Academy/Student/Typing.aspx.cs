using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KRS_Academy.Student
{
    public partial class Typing : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["KRS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTypingTests();
            }
        }

        private void LoadTypingTests()
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
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", $"showModal({typingId});", true);
            }
        }

        protected void start_typing_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO TestMaster (Date, Typing_id, StudentName, MobileNo) VALUES (@Date, @Typing_id, @StudentName, @MobileNo)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Date", DateTime.Now.Date);
                    cmd.Parameters.AddWithValue("@Typing_id", hfTypingId.Value);
                    cmd.Parameters.AddWithValue("@StudentName", studentName.Text);
                    cmd.Parameters.AddWithValue("@MobileNo", mobileNo.Text);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "toastrSuccess", "toastr.success('Data inserted successfully.');", true);
                        Response.Redirect("~/TypingStart.aspx?Id=" + hfTypingId.Value, false);
                        Context.ApplicationInstance.CompleteRequest();
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "toastrError", $"toastr.error('Error inserting data: {ex.Message}');", true);
                    }
                }
            }
        }
    }
}
