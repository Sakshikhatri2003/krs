using System;

namespace KRS_Academy
{
    public partial class TypingReview : System.Web.UI.Page
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
            }
        }
    }
}
