using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Configuration;
using WebApp.LIBS;

namespace KRS_Academy.Admin
{
    public partial class TypingMaster : BasePageClass
    {
        string connectionString = ConfigurationManager.ConnectionStrings["KRS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid()
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

        protected void submit_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("InsertTypingMaster", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Date", Date.Text);
                    cmd.Parameters.AddWithValue("@Language", languageDrp.SelectedItem.Text); // Use SelectedItem.Text for the Language
                    cmd.Parameters.AddWithValue("@TestName", testName.Text);
                    cmd.Parameters.AddWithValue("@InputText", Content.Text);
                    cmd.Parameters.AddWithValue("@TotalWords", WordsNo.Text);
                    cmd.Parameters.AddWithValue("@LanguageCode", int.Parse(languageDrp.SelectedValue)); // Assuming LanguageCode is an int

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        ClientScript.RegisterStartupScript(this.GetType(), "toastrSuccess", "toastr.success('Data inserted successfully.');", true);
                        ClearForm();
                    }
                    catch (Exception ex)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "toastrError", $"toastr.error('Error inserting data: {ex.Message}');", true);
                    }
                }
            }
            BindGrid();
        }

        protected void Content_TextChanged(object sender, EventArgs e)
        {
            string content = Content.Text;
            int wordCount = content.Split(new char[] { ' ', '\t', '\n', '\r' }, StringSplitOptions.RemoveEmptyEntries).Length;
            WordsNo.Text = wordCount.ToString() + " Word";
        }

        protected void TypingTable_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditRow")
            {
                int typingId = Convert.ToInt32(e.CommandArgument);
                hfTypingId.Value = typingId.ToString();
                string query = "SELECT * FROM TypingMaster WHERE TypingId = @TypingId";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@TypingId", typingId);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        Date.Text = reader["Date"].ToString();
                        languageDrp.SelectedValue = reader["LanguageCode"].ToString();
                        testName.Text = reader["TestName"].ToString();
                        Content.Text = reader["InputText"].ToString();
                        WordsNo.Text = reader["TotalWords"].ToString();
                        submit.Visible = false;
                        update.Visible = true;
                    }
                }
            }
        }

        protected void update_Click(object sender, EventArgs e)
        {
            int typingId = Convert.ToInt32(hfTypingId.Value);

            string inputText = (languageDrp.SelectedValue == "1") ? HindiContent1.Text : Content.Text;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("UpdateTypingMaster", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TypingId", typingId);
                    cmd.Parameters.AddWithValue("@Date", Date.Text);
                    cmd.Parameters.AddWithValue("@Language", languageDrp.SelectedItem.Text); 
                    cmd.Parameters.AddWithValue("@TestName", testName.Text);
                    cmd.Parameters.AddWithValue("@InputText", inputText); 
                    cmd.Parameters.AddWithValue("@TotalWords", WordsNo.Text);
                    cmd.Parameters.AddWithValue("@LanguageCode", int.Parse(languageDrp.SelectedValue)); 

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "toastrSuccess", "toastr.success('Data updated successfully');", true);
                        ClearForm();
                    }
                    catch (Exception ex)
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "toastrError", $"toastr.error('Error updating data: {ex.Message}');", true);
                    }
                }
            }
            submit.Visible = true;
            update.Visible = false;
            BindGrid();
        }
        private void ClearForm()
        {
            Date.Text = "";
            languageDrp.SelectedValue = "";
            testName.Text = "";
            Content.Text = "";
            WordsNo.Text = "";
            hfTypingId.Value = "";
            HindiContent1.Text = "";
            Content.Visible = true;
        }

        protected void TypingTable_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int typingId = Convert.ToInt32(TypingTable.DataKeys[e.RowIndex].Value);
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("DELETE FROM TypingMaster WHERE TypingId = @TypingId", conn))
                {
                    cmd.Parameters.AddWithValue("@TypingId", typingId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            BindGrid();
        }

        protected void languageDrp_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (languageDrp.SelectedValue == "1")
            {
                Content.Visible = false;
                HindiContent1.Visible = true;
            }
            else if (languageDrp.SelectedValue == "0")
            {
                Content.Visible = true;
                HindiContent1.Visible = false;
            }
            else
            {
                Content.Visible = true;
                HindiContent1.Visible = false;
            }
        }

        protected void HindiContent1_TextChanged(object sender, EventArgs e)
        {
            string content = HindiContent1.Text;
            int wordCount = content.Split(new char[] { ' ', '\t', '\n', '\r' }, StringSplitOptions.RemoveEmptyEntries).Length;
            WordsNo.Text = wordCount.ToString() + " Word";
        }
    }
}
