using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KRS
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCompare_Click(object sender, EventArgs e)
        {
            string paragraph1 = txtParagraph1.Value;
            string paragraph2 = txtParagraph2.Value;

            string result = CompareParagraphs(paragraph1, paragraph2);

            ltlResult.Text = result;
        }

        private string CompareParagraphs(string para1, string para2)
        {
            string[] words1 = para1.Split(new char[] { ' ', '.', ',', ';', '!', '?' }, StringSplitOptions.None);
            string[] words2 = para2.Split(new char[] { ' ', '.', ',', ';', '!', '?' }, StringSplitOptions.None);

            StringBuilder result = new StringBuilder();
            int maxLength = Math.Max(words1.Length, words2.Length);

            for (int i = 0; i < maxLength; i++)
            {
                if (i < words1.Length && i < words2.Length)
                {
                    if (words1[i].Equals(words2[i], StringComparison.OrdinalIgnoreCase))
                    {
                        result.Append(words1[i]);
                    }
                    else
                    {
                        result.Append($"<span class='highlight'>{words1[i]}</span>");
                    }
                }
                else if (i < words1.Length)
                {
                    result.Append($"<span class='highlight'>{words1[i]}</span>");
                }
                else if (i < words2.Length)
                {
                    result.Append($"<span class='highlight'>{words2[i]}</span>");
                }

                // Add space unless it is the last word
                if (i < maxLength - 1)
                {
                    result.Append(" ");
                }
            }

            return result.ToString();
        }
    }
}