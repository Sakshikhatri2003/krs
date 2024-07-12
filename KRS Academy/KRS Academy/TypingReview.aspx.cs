using System;

namespace KRS_Academy
{
    public partial class TypingReview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Result"] != null)
                {
                    string result = Session["Result"].ToString();
                    LblResult.Text = result;
                }
            }
        }
    }
}
