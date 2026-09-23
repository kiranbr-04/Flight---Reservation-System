using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["DBConn"].ConnectionString;

        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "INSERT INTO Users(Name, Email, Password, Phone) VALUES(@Name, @Email, @Password, @Phone)";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();

                    lblMessage.Text = "Registration Successful!";
                    Response.Redirect("Login.aspx?msg=registered");
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 2627)
                    {
                        lblMessage.Text = "Email already registered.";
                    }
                    else
                    {
                        lblMessage.Text = "Database Error: " + ex.Message;
                    }
                }
            }
        }
    }
}