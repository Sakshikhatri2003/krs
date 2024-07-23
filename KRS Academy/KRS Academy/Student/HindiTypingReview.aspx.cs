using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApp.LIBS;

namespace KRS_Academy.Student
{
    public partial class HindiTypingReview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteSession.IsExamStart = false;
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
                if (Session["Input"] != null)
                {
                    input.Text = Session["Input"].ToString();
                }
                if (Session["Marks"] != null)
                {
                    Marks.Text = Session["Marks"].ToString();
                }
                if (Session["TotalMarks"] != null)
                {
                    TotalMarks.Text = Session["TotalMarks"].ToString();
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
                    r.Input_text,
                    r.SkippedWord, 
                    r.Backspace, 
                    r.TimeAlloted, 
                    r.TimeTaken, 
                    r.TotalWords, 
                    r.GrossSpeed, 
                    r.CorrectWord, 
                    r.WrongWord, 
                    r.Accuracy, 
                    r.Result_text,
                    r.Marks
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
                        input.Text = reader["Input_text"].ToString();
                        SkippedWord.Text = reader["SkippedWord"].ToString();
                        Backspace.Text = reader["Backspace"].ToString();
                        TimeAllocate.Text = reader["TimeAlloted"].ToString();
                        TimeTaken.Text = reader["TimeTaken"].ToString();
                        TotalWords.Text = reader["TotalWords"].ToString();
                        GrossSpeed.Text = reader["GrossSpeed"].ToString();
                        CorrectWords.Text = reader["CorrectWord"].ToString();
                        WrongWords.Text = reader["WrongWord"].ToString();
                        Accuracy.Text = reader["Accuracy"].ToString() + "%";
                        LblResult.InnerHtml = reader["Result_text"].ToString();
                        Marks.Text = reader["Marks"].ToString();
                        int totalMarks = Convert.ToInt32(reader["TotalWords"]) / 5;
                        TotalMarks.Text = Convert.ToInt32(totalMarks).ToString();
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