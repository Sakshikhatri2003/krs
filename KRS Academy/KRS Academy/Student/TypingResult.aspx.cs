using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApp.LIBS;

namespace KRS_Academy.Student
{
    public partial class TypingResult : BasePageClass
    {
        string connectionString = ConfigurationManager.ConnectionStrings["KRS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            SiteSession.IsExamStart = false;
            if (!IsPostBack)
            {
                LoadDatas();
                BindNameFilterDropDown();
            }
        }

        private void BindNameFilterDropDown()
        {
            string query = "SELECT DISTINCT [StudentName], [MobileNo] FROM [KRSAcademy].[dbo].[TestMaster] WHERE [StudentName] IS NOT NULL AND [StudentName] <> '' AND [MobileNo] IS NOT NULL AND [MobileNo] <> ''";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    List<ListItem> items = new List<ListItem>();

                    while (reader.Read())
                    {
                        string studentName = reader["StudentName"].ToString();
                        string mobileNo = reader["MobileNo"].ToString();
                        string displayText = $"{studentName} - {mobileNo}";

                        items.Add(new ListItem(displayText, $"{studentName} - {mobileNo}"));
                    }

                    NameFilter.DataSource = items;
                    NameFilter.DataTextField = "Text";
                    NameFilter.DataValueField = "Value";
                    NameFilter.DataBind();
                }
            }

            NameFilter.Items.Insert(0, new ListItem("--Select Student--", ""));
        }

        private void LoadDatas()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                               SELECT t.Test_id, t.Date, tm.TestName, t.StudentName, t.MobileNo
                               FROM TestMaster t
                               JOIN TypingMaster tm ON t.Typing_id = tm.TypingId
                               ORDER BY t.Test_id ASC";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                example1.DataSource = dt;
                example1.DataBind();
            }
        }

        protected void example1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "View")
            {
                int testId = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT tm.LanguageCode FROM TestMaster t JOIN TypingMaster tm ON t.Typing_id = tm.TypingId WHERE t.Test_id = @TestId";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@TestId", testId);
                        conn.Open();
                        int languageCode = (int)cmd.ExecuteScalar();
                        if (languageCode == 1)
                        {
                            Response.Redirect("HindiTypingReview.aspx?Id=" + testId, false);
                        }
                        else
                        {
                            Response.Redirect("TypingReview.aspx?Id=" + testId, false);
                        }
                    }
                }
            }
        }

        private void BindGridView(string studentName = "", string mobileNo = "")
        {
            string query = @"
                SELECT t.Test_id, t.Date, tm.TestName, t.StudentName, t.MobileNo
                FROM TestMaster t
                JOIN TypingMaster tm ON t.Typing_id = tm.TypingId
                WHERE 1=1";

            if (!string.IsNullOrEmpty(studentName))
            {
                query += " AND t.StudentName = @StudentName";
            }

            if (!string.IsNullOrEmpty(mobileNo))
            {
                query += " AND t.MobileNo = @MobileNo";
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (!string.IsNullOrEmpty(studentName))
                    {
                        cmd.Parameters.AddWithValue("@StudentName", studentName);
                    }

                    if (!string.IsNullOrEmpty(mobileNo))
                    {
                        cmd.Parameters.AddWithValue("@MobileNo", mobileNo);
                    }

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        example1.DataSource = dt;
                        example1.DataBind();
                    }
                }
            }
        }

        protected void NameFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = NameFilter.SelectedValue;

            if (!string.IsNullOrEmpty(selectedValue) && selectedValue != "--Select Student--")
            {
                string[] values = selectedValue.Split('-');
                if (values.Length == 2)
                {
                    string studentName = values[0].Trim();
                    string mobileNo = values[1].Trim();
                    BindGridView(studentName, mobileNo);
                }
            }
            else
            {
                BindGridView();
            }
        }
    }
}
