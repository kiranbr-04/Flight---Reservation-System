using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class AddTransport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null)
            Response.Redirect("AdminLogin.aspx");
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["DBConn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "INSERT INTO Transport (Name, Source, Destination, DepartureTime, Seats, Price) VALUES (@Name, @Source, @Destination, @DepartureTime, @Seats, @Price)";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@Source", txtSource.Text.Trim());
                cmd.Parameters.AddWithValue("@Destination", txtDestination.Text.Trim());
                cmd.Parameters.AddWithValue("@DepartureTime", Convert.ToDateTime(txtDeparture.Text));
                cmd.Parameters.AddWithValue("@Seats", Convert.ToInt32(txtSeats.Text));
                cmd.Parameters.AddWithValue("@Price", Convert.ToDecimal(txtPrice.Text));

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMessage.Text = "Transport added successfully!";
                    lblMessage.CssClass = "text-success mb-3 d-block fw-bold";
                    ClearFields();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                    lblMessage.CssClass = "text-danger mb-3 d-block fw-bold";
                }
            }
        }
    }

    private void ClearFields()
    {
        txtName.Text = "";
        txtSource.Text = "";
        txtDestination.Text = "";
        txtDeparture.Text = "";
        txtSeats.Text = "";
        txtPrice.Text = "";
    }
}
