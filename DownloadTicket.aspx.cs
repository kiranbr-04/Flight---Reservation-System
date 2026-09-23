using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class DownloadTicket : System.Web.UI.Page
{
    public string BookingID, PassengerName, TransportName, Source, Destination, DepartureTime, SeatNo, Price, PaymentMethod;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
            Response.Redirect("Login.aspx");

        if (Request.QueryString["bid"] != null)
        {
            LoadTicketData(Request.QueryString["bid"]);
        }
        else
        {
            Response.Redirect("MyBookings.aspx");
        }
    }

    private void LoadTicketData(string bid)
    {
        string connStr = ConfigurationManager.ConnectionStrings["DBConn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = @"SELECT b.BookingID, u.Name as PassengerName, t.Name as TransportName, 
                            t.Source, t.Destination, t.DepartureTime, b.SeatNo, t.Price, b.PaymentMethod 
                            FROM Booking b 
                            JOIN Users u ON b.UserID = u.UserID 
                            JOIN Transport t ON b.TransportID = t.TransportID 
                            WHERE b.BookingID = @BookingID AND b.UserID = @UserID";
            
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@BookingID", bid);
                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                con.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        BookingID = dr["BookingID"].ToString();
                        PassengerName = dr["PassengerName"].ToString();
                        TransportName = dr["TransportName"].ToString();
                        Source = dr["Source"].ToString();
                        Destination = dr["Destination"].ToString();
                        DepartureTime = Convert.ToDateTime(dr["DepartureTime"]).ToString("F");
                        SeatNo = dr["SeatNo"].ToString();
                        Price = Convert.ToDecimal(dr["Price"]).ToString("C");
                        PaymentMethod = dr["PaymentMethod"] != DBNull.Value ? dr["PaymentMethod"].ToString() : "Not Specified";
                    }
                    else
                    {
                        Response.Redirect("MyBookings.aspx");
                    }
                }
            }
        }
    }
}
