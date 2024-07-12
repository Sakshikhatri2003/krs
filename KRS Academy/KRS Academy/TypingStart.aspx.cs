using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KRS_Academy
{
    public partial class TypingStart : Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["KRS"].ConnectionString;
        private static int remainingTime;
        private int backspaceCount = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["Id"]))
                {
                    int id = Convert.ToInt32(Request.QueryString["Id"]);
                    string query = "SELECT TestName, InputText FROM TypingMaster WHERE TypingId = @Id";

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        SqlCommand command = new SqlCommand(query, connection);
                        command.Parameters.AddWithValue("@Id", id);

                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.Read())
                        {
                            input.Text = reader["InputText"].ToString();
                            TestName.Text = reader["TestName"].ToString();
                        }
                    }
                }
                count.Enabled = false;
            }
        }

        protected void startTypingButton_Click(object sender, EventArgs e)
        {
            count.Enabled = true;
            remainingTime = Convert.ToInt32(timeSelector.SelectedValue) * 60;
            input_text.ReadOnly = false;
            input_text.Focus();
            UpdateTimerLabel();
        }

        protected void count_Tick(object sender, EventArgs e)
        {
            if (remainingTime > 0)
            {
                remainingTime--;
                UpdateTimerLabel();
                if(timer.Text == "00:00")
                {
                    string paragraph1 = input.Text;
                    string paragraph2 = input_text.Text;

                    double similarityScore = CompareParagraphs(paragraph1, paragraph2);
                    string highlightedText = HighlightDifferentWords(paragraph1, paragraph2);

                    string result = $"Similarity score between the paragraphs: {similarityScore:P}<br /><br />{highlightedText}";

                    Session["Result"] = result;

                    Response.Redirect("TypingReview.aspx");
                }
            }
            else
            {
                count.Enabled = false;
                timer.Text = "00:00";
                input_text.ReadOnly = true;
            }
        }

        private void UpdateTimerLabel()
        {
            int minutes = remainingTime / 60;
            int seconds = remainingTime % 60;
            timer.Text = $"{minutes:00}:{seconds:00}";
        }
        protected void input_text_TextChanged(object sender, EventArgs e)
        {
            if (backspaceCheckbox.Checked && input_text.Text.Contains("\b"))
            {
                backspaceCount++;
                // Update the display if needed (if backspace count is to be displayed differently)
            }
        }

        protected void submit_button_Click(object sender, EventArgs e)
        {
            count.Enabled = false;
            string paragraph1 = input.Text;
            string paragraph2 = input_text.Text;

            double similarityScore = CompareParagraphs(paragraph1, paragraph2);
            string highlightedText = HighlightDifferentWords(paragraph1, paragraph2);

            string result = $"Similarity score between the paragraphs: {similarityScore:P}<br /><br />{highlightedText}";

            Session["Result"] = result;

            Response.Redirect("TypingReview.aspx");
        }

        static string HighlightDifferentWords(string text1, string text2)
        {
            string[] words1 = text1.Split(new[] { ' ', '.', ',', '!', '?' }, StringSplitOptions.RemoveEmptyEntries);
            string[] words2 = text2.Split(new[] { ' ', '.', ',', '!', '?' }, StringSplitOptions.RemoveEmptyEntries);

            HashSet<string> set1 = new HashSet<string>(words1);
            HashSet<string> set2 = new HashSet<string>(words2);

            HashSet<string> uniqueWordsInText1 = new HashSet<string>(set1);
            uniqueWordsInText1.ExceptWith(set2);

            for (int i = 0; i < words2.Length; i++)
            {
                if (uniqueWordsInText1.Contains(words2[i]))
                {
                    words2[i] = $"<span style='color:red;'>{words2[i]}</span>";
                }
            }

            return string.Join(" ", words2);
        }

        static double CompareParagraphs(string para1, string para2)
        {
            string[] words1 = para1.Split(new[] { ' ', '.', ',', '!', '?' }, StringSplitOptions.RemoveEmptyEntries);
            string[] words2 = para2.Split(new[] { ' ', '.', ',', '!', '?' }, StringSplitOptions.RemoveEmptyEntries);

            var termFrequency1 = CalculateTermFrequency(words1);
            var termFrequency2 = CalculateTermFrequency(words2);

            var uniqueWords = new HashSet<string>(words1.Union(words2));

            double[] vector1 = CalculateTFIDFVector(termFrequency1, uniqueWords.ToArray());
            double[] vector2 = CalculateTFIDFVector(termFrequency2, uniqueWords.ToArray());

            return CalculateCosineSimilarity(vector1, vector2);
        }

        static Dictionary<string, int> CalculateTermFrequency(string[] words)
        {
            var termFrequency = new Dictionary<string, int>();
            foreach (string word in words)
            {
                if (termFrequency.ContainsKey(word))
                {
                    termFrequency[word]++;
                }
                else
                {
                    termFrequency[word] = 1;
                }
            }
            return termFrequency;
        }

        static double[] CalculateTFIDFVector(Dictionary<string, int> termFrequency, string[] uniqueWords)
        {
            double[] vector = new double[uniqueWords.Length];
            for (int i = 0; i < uniqueWords.Length; i++)
            {
                vector[i] = termFrequency.ContainsKey(uniqueWords[i]) ? termFrequency[uniqueWords[i]] * CalculateIDF(termFrequency, uniqueWords[i]) : 0;
            }
            return vector;
        }

        static double CalculateIDF(Dictionary<string, int> termFrequency, string word)
        {
            return Math.Log10((double)(1 + termFrequency.Values.Sum()) / (1 + termFrequency[word]));
        }

        static double CalculateCosineSimilarity(double[] vector1, double[] vector2)
        {
            double dotProduct = 0;
            double magnitude1 = 0;
            double magnitude2 = 0;

            for (int i = 0; i < vector1.Length; i++)
            {
                dotProduct += vector1[i] * vector2[i];
                magnitude1 += Math.Pow(vector1[i], 2);
                magnitude2 += Math.Pow(vector2[i], 2);
            }

            magnitude1 = Math.Sqrt(magnitude1);
            magnitude2 = Math.Sqrt(magnitude2);

            return dotProduct / (magnitude1 * magnitude2);
        }
    }
}
