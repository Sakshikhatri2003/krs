﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApp.LIBS;

namespace KRS_Academy.Student
{
    public partial class HindiTypingStart : BasePageClass
    {
        string connectionString = ConfigurationManager.ConnectionStrings["KRS"].ConnectionString;
        private static int remainingTime;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (SiteSession.IsExamStart)
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
            else
            {
                Response.Redirect("HindiTyping.aspx", false);
            }
        }

        [WebMethod]
        public static void SaveStats(int backspaceCount, int totalWords, string typingSpeed)
        {
            HttpContext.Current.Session["BackspaceCount"] = backspaceCount;
            HttpContext.Current.Session["WordCount"] = totalWords;
            HttpContext.Current.Session["TypingSpeed"] = typingSpeed;
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
            }
            else
            {
                count.Enabled = false;
                input_text.ReadOnly = true;

                CommonInsert();
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
            // Handle text changed event if needed
        }

        protected void submit_button_Click(object sender, EventArgs e)
        {
            count.Enabled = false;
            CommonInsert();
        }

        protected void CommonInsert()
        {
            string paragraph1 = input.Text;
            string paragraph2 = input_text.Text;

            double similarityScore = CompareParagraphs(paragraph1, paragraph2);
            string highlightedText = HighlightDifferentWords(paragraph1, paragraph2);
            string result = $"{highlightedText}";

            int allottedTimeInSeconds = Convert.ToInt32(timeSelector.SelectedValue) * 60;
            int timeTakenInSeconds = allottedTimeInSeconds - remainingTime;

            int minutesTaken = timeTakenInSeconds / 60;
            int secondsTaken = timeTakenInSeconds % 60;
            string timeTakenFormatted = $"{minutesTaken:00}:{secondsTaken:00}";

            int backspaceCount = Session["BackspaceCount"] != null ? (int)Session["BackspaceCount"] : 0;
            int wordCount = Session["WordCount"] != null ? (int)Session["WordCount"] : 0;
            string typingSpeed = Session["TypingSpeed"] != null ? Session["TypingSpeed"].ToString() : "";

            // Calculate word counts for Hindi
            int totalWords = CountWordsInHindi(paragraph1);
            int typedWords = CountWordsInHindi(paragraph2);

            int skippedWords = Math.Max(0, totalWords - typedWords);
            int correctWords = 0;
            int wrongWords = 0;

            string[] originalWords = SplitHindiText(paragraph1);
            string[] typedWordsArray = SplitHindiText(paragraph2);

            for (int i = 0; i < typedWordsArray.Length; i++)
            {
                if (i < originalWords.Length)
                {
                    if (originalWords[i].Equals(typedWordsArray[i], StringComparison.OrdinalIgnoreCase))
                        correctWords++;
                    else
                        wrongWords++;
                }
                else
                {
                    wrongWords++;
                }
            }

            double accuracyPercentage = Math.Round((double)correctWords / originalWords.Length * 100, 2);
            Session["Accuracy"] = accuracyPercentage.ToString("F2") + "%";

            Session["Speed"] = typingSpeed;
            Session["TimeAllote"] = timeSelector.SelectedValue;
            Session["TimeTaken"] = timeTakenFormatted;
            Session["BackspaceCount"] = backspaceCount;
            Session["WordCount"] = wordCount;
            Session["SkippedWords"] = skippedWords;
            Session["CorrectWords"] = correctWords;
            Session["WrongWords"] = wrongWords;
            Session["Input"] = input.Text;
            Session["Result"] = result;
            Session["TotalMarks"] = wordCount / 5;

            int correctCharCount = 0;
            for (int i = 0; i < correctWords; i++)
            {
                correctCharCount += originalWords[i].Length;
            }

            int marks = correctCharCount / 5;
            Session["Marks"] = marks;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Result (Test_id, Input_text, Result_text, SkippedWord, Backspace, TimeAlloted, TimeTaken, TotalWords, GrossSpeed, CorrectWord, WrongWord, Accuracy, Marks) " +
                               "VALUES (@Test_id, @Input_text, @Result_text, @SkippedWord, @Backspace, @TimeAlloted, @TimeTaken, @TotalWords, @GrossSpeed, @CorrectWord, @WrongWord, @Accuracy, @Marks)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Test_id", Session["TestId"]);
                    cmd.Parameters.AddWithValue("@Input_text", paragraph1);
                    cmd.Parameters.AddWithValue("@Result_text", highlightedText);
                    cmd.Parameters.AddWithValue("@SkippedWord", skippedWords);
                    cmd.Parameters.AddWithValue("@Backspace", backspaceCount);
                    cmd.Parameters.AddWithValue("@TimeAlloted", timeSelector.SelectedValue);
                    cmd.Parameters.AddWithValue("@TimeTaken", timeTakenFormatted);
                    cmd.Parameters.AddWithValue("@TotalWords", totalWords);
                    cmd.Parameters.AddWithValue("@GrossSpeed", typingSpeed);
                    cmd.Parameters.AddWithValue("@CorrectWord", correctWords);
                    cmd.Parameters.AddWithValue("@WrongWord", wrongWords);
                    cmd.Parameters.AddWithValue("@Accuracy", accuracyPercentage);
                    cmd.Parameters.AddWithValue("@Marks", marks);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "toastrSuccess", "toastr.success('Data inserted successfully.');", true);
                        Response.Redirect("HindiTypingReview.aspx");
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "toastrError", $"toastr.error('Error inserting data: {ex.Message}');", true);
                    }
                }
            }
        }

        static string[] SplitHindiText(string text)
        {
            return text.Split(new[] { ' ', '.', ',', '!', '?', '।', '—', '॥' }, StringSplitOptions.RemoveEmptyEntries);
        }

        static int CountWordsInHindi(string text)
        {
            return SplitHindiText(text).Length;
        }

        static string HighlightDifferentWords(string text1, string text2)
        {
            string[] words1 = SplitHindiText(text1);
            string[] words2 = SplitHindiText(text2);

            HashSet<string> set1 = new HashSet<string>(words1);

            for (int i = 0; i < words2.Length; i++)
            {
                if (!set1.Contains(words2[i]))
                {
                    words2[i] = $"<span style='color:red;'>{words2[i]}</span>";
                }
            }

            return string.Join(" ", words2);
        }

        static double CompareParagraphs(string para1, string para2)
        {
            string[] words1 = SplitHindiText(para1);
            string[] words2 = SplitHindiText(para2);

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