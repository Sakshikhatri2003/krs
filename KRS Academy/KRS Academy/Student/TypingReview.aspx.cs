using System;
using System.Configuration;
using System.Data.SqlClient;
using WebApp.LIBS;

namespace KRS_Academy
{
    public partial class TypingReview : BasePageClass
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Accuracy"] != null)
                {
                    Accuracy.Text = Session["Accuracy"].ToString();
                }
                if (Session["Speed"] != null)
                {
                    GrossSpeed.Text = Session["Speed"].ToString();
                }
                if (Session["TimeAllote"] != null)
                {
                    TimeAllocate.Text = Session["TimeAllote"].ToString();
                }
                if (Session["TimeTaken"] != null)
                {
                    TimeTaken.Text = Session["TimeTaken"].ToString();
                }
                if (Session["BackspaceCount"] != null)
                {
                    Backspace.Text = Session["BackspaceCount"].ToString();
                }
                if (Session["WordCount"] != null)
                {
                    TotalWords.Text = Session["WordCount"].ToString();
                }
                if (Session["SkippedWords"] != null)
                {
                    SkippedWord.Text = Session["SkippedWords"].ToString();
                }
                if (Session["CorrectWords"] != null)
                {
                    CorrectWords.Text = Session["CorrectWords"].ToString();
                }
                if (Session["WrongWords"] != null)
                {
                    WrongWords.Text = Session["WrongWords"].ToString();
                }
                if (Session["Result"] != null)
                {
                    LblResult.InnerHtml = Session["Result"].ToString();
                }
                if (Session["StuName"] != null)
                {
                    stuName.Text = Session["StuName"].ToString();
                }

                if (!string.IsNullOrEmpty(Request.QueryString["Id"]))
                {
                    int id = Convert.ToInt32(Request.QueryString["Id"]);
                    BindData(id);
                }
            }
        }
        private void BindData(int id)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["KRS"].ConnectionString;
            string query = @"
                SELECT 
                    tm.StudentName, 
                    r.SkippedWord, 
                    r.Backspace, 
                    r.TimeAlloted, 
                    r.TimeTaken, 
                    r.TotalWords, 
                    r.GrossSpeed, 
                    r.CorrectWord, 
                    r.WrongWord, 
                    r.Accuracy, 
                    r.Result_text
                FROM 
                    Result r
                JOIN 
                    TestMaster tm ON r.Test_id = tm.Test_id
                WHERE 
                    r.Test_id = @Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Id", id);

                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        stuName.Text = reader["StudentName"].ToString();
                        SkippedWord.Text = reader["SkippedWord"].ToString();
                        Backspace.Text = reader["Backspace"].ToString();
                        TimeAllocate.Text = reader["TimeAlloted"].ToString();
                        TimeTaken.Text = reader["TimeTaken"].ToString();
                        TotalWords.Text = reader["TotalWords"].ToString();
                        GrossSpeed.Text = reader["GrossSpeed"].ToString();
                        CorrectWords.Text = reader["CorrectWord"].ToString();
                        WrongWords.Text = reader["WrongWord"].ToString();
                        Accuracy.Text = reader["Accuracy"].ToString();
                        LblResult1.Text = reader["Result_text"].ToString();
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    // Handle the exception
                }
            }
        }
    }
}
