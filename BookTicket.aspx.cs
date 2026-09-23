using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class BookTicket : System.Web.UI.Page
{
    int transportId = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
            Response.Redirect("Login.aspx?msg=login_required");

        if (Request.QueryString["tid"] != null)
        {
            int.TryParse(Request.QueryString["tid"], out transportId);
            if (!IsPostBack)
            {
                LoadTransportDetails();
            }
        }
        else
        {
            Response.Redirect("Search.aspx");
        }
    }

    private void LoadTransportDetails()
    {
        string connStr = ConfigurationManager.ConnectionStrings["DBConn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "SELECT Name, Source, Destination, DepartureTime, Price, Seats FROM Transport WHERE TransportID=@TransportID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@TransportID", transportId);
                con.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        litTransportDetails.Text = string.Format("<strong>Name:</strong> {0} <br/>" +
                            "<strong>Route:</strong> {1} to {2} <br/>" +
                            "<strong>Departure:</strong> {3} <br/>" +
                            "<strong>Price:</strong> {4} <br/>" +
                            "<strong>Available Seats:</strong> <span class='badge bg-primary'>{5}</span>",
                            dr["Name"], dr["Source"], dr["Destination"], 
                            Convert.ToDateTime(dr["DepartureTime"]).ToString("dd MMM yyyy HH:mm"), 
                            Convert.ToDecimal(dr["Price"]).ToString("C"), dr["Seats"]);
                    }
                    else
                    {
                        lblMessage.Text = "Transport details not found.";
                        btnConfirmBook.Enabled = false;
                    }
                }
            }
        }
    }

    protected void btnConfirmBook_Click(object sender, EventArgs e)
    {
        string seatNo = txtSeatNo.Text.Trim();
        string paymentMethod = rbCard.Checked ? "Card" : "UPI";
        int userId = Convert.ToInt32(Session["UserID"]);

        string connStr = ConfigurationManager.ConnectionStrings["DBConn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connStr))
        {
            con.Open();
            // Check seat availability
            string checkQuery = "SELECT Seats FROM Transport WHERE TransportID=@TransportID";
            int availableSeats = 0;
            using (SqlCommand cmdCheck = new SqlCommand(checkQuery, con))
            {
                cmdCheck.Parameters.AddWithValue("@TransportID", transportId);
                object result = cmdCheck.ExecuteScalar();
                if (result != null) availableSeats = Convert.ToInt32(result);
            }

            if (availableSeats <= 0)
            {
                lblMessage.Text = "Sorry, no seats are available on this transport.";
                return;
            }

            SqlTransaction tran = con.BeginTransaction();
            try
            {
                string insertBooking = "INSERT INTO Booking (UserID, TransportID, SeatNo, JourneyDate, Status, PaymentMethod) VALUES (@UserId, @TransportID, @SeatNo, @JourneyDate, 'Confirmed', @PaymentMethod); SELECT SCOPE_IDENTITY();";
                int newBookingId = 0;
                using (SqlCommand cmd = new SqlCommand(insertBooking, con, tran))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@TransportID", transportId);
                    cmd.Parameters.AddWithValue("@SeatNo", seatNo);
                    cmd.Parameters.AddWithValue("@JourneyDate", DateTime.Now.Date);
                    cmd.Parameters.AddWithValue("@PaymentMethod", paymentMethod);
                    newBookingId = Convert.ToInt32(cmd.ExecuteScalar());
                }

                string updateSeats = "UPDATE Transport SET Seats = Seats - 1 WHERE TransportID=@TransportID";
                using (SqlCommand cmd = new SqlCommand(updateSeats, con, tran))
                {
                    cmd.Parameters.AddWithValue("@TransportID", transportId);
                    cmd.ExecuteNonQuery();
                }

                tran.Commit();
                Response.Redirect("DownloadTicket.aspx?bid=" + newBookingId, false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (SqlException ex)
            {
                tran.Rollback();
                lblMessage.Text = "Database Error: " + ex.Message;
            }
        }
    }
}
