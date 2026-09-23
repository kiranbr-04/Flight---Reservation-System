using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class AdminDashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null)
            Response.Redirect("AdminLogin.aspx");

        if (!IsPostBack)
        {
            LoadStatistics();
        }
    }

    private void LoadStatistics()
    {
        string connStr = ConfigurationManager.ConnectionStrings["DBConn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connStr))
        {
            con.Open();

            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Users", con))
            {
                litUsers.Text = cmd.ExecuteScalar().ToString();
            }

            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Booking", con))
            {
                litBookings.Text = cmd.ExecuteScalar().ToString();
            }

            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Transport", con))
            {
                litTransports.Text = cmd.ExecuteScalar().ToString();
            }
        }
    }
}
