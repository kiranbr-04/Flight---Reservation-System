using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class ViewBookings : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null)
            Response.Redirect("AdminLogin.aspx");

        if (!IsPostBack)
        {
            BindAllBookings();
        }
    }

    private void BindAllBookings()
    {
        string connStr = ConfigurationManager.ConnectionStrings["DBConn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = @"SELECT b.BookingID, u.Name as UserName, u.Email, t.Name as TransportName, 
                                  t.Source, t.Destination, b.JourneyDate, b.SeatNo, b.Status 
                           FROM Booking b
                           JOIN Users u ON b.UserID = u.UserID
                           JOIN Transport t ON b.TransportID = t.TransportID
                           ORDER BY b.BookingID DESC";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    gvAllBookings.DataSource = dt;
                    gvAllBookings.DataBind();
                }
            }
        }
    }
}
