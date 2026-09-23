using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class MyBookings : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
            Response.Redirect("Login.aspx?msg=login_required");

        if (!IsPostBack)
        {
            if (Request.QueryString["msg"] == "booked")
                lblMessage.Text = "Ticket booked successfully!";
            BindBookings();
        }
    }

    private void BindBookings()
    {
        int userId = Convert.ToInt32(Session["UserID"]);
        string connStr = ConfigurationManager.ConnectionStrings["DBConn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = @"SELECT b.BookingID, t.TransportID, t.Name, t.Source, t.Destination, t.DepartureTime, b.SeatNo, b.Status 
                           FROM Booking b 
                           JOIN Transport t ON b.TransportID = t.TransportID 
                           WHERE b.UserID = @UserID ORDER BY b.BookingID DESC";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    gvBookings.DataSource = dt;
                    gvBookings.DataBind();
                }
            }
        }
    }

    protected void gvBookings_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "CancelTicket")
        {
            string[] args = e.CommandArgument.ToString().Split('|');
            int bookingId = Convert.ToInt32(args[0]);
            int transportId = Convert.ToInt32(args[1]);

            string connStr = ConfigurationManager.ConnectionStrings["DBConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                SqlTransaction tran = con.BeginTransaction();
                try
                {
                    string updateBooking = "UPDATE Booking SET Status = 'Cancelled' WHERE BookingID = @BookingID AND Status != 'Cancelled'";
                    using (SqlCommand cmd = new SqlCommand(updateBooking, con, tran))
                    {
                        cmd.Parameters.AddWithValue("@BookingID", bookingId);
                        int rows = cmd.ExecuteNonQuery();

                        if (rows > 0)
                        {
                            string updateSeats = "UPDATE Transport SET Seats = Seats + 1 WHERE TransportID = @TransportID";
                            using (SqlCommand cmd2 = new SqlCommand(updateSeats, con, tran))
                            {
                                cmd2.Parameters.AddWithValue("@TransportID", transportId);
                                cmd2.ExecuteNonQuery();
                            }
                        }
                    }
                    tran.Commit();
                    lblMessage.Text = "Ticket cancelled successfully.";
                    BindBookings();
                }
                catch (Exception ex)
                {
                    tran.Rollback();
                    lblMessage.Text = "Cancellation failed: " + ex.Message;
                }
            }
        }
    }
}
