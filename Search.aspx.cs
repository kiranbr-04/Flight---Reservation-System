using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class Search : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadAllTransports();
        }
    }

    private void LoadAllTransports()
    {
        string connStr = ConfigurationManager.ConnectionStrings["DBConn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "SELECT TransportID, Name, Source, Destination, DepartureTime, Seats, Price FROM Transport WHERE CAST(DepartureTime AS DATE) >= CAST(GETDATE() AS DATE)";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    gvTransports.DataSource = dt;
                    gvTransports.DataBind();
                }
            }
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string source = txtSource.Text.Trim();
        string destination = txtDestination.Text.Trim();
        string date = txtDate.Text.Trim();

        string connStr = ConfigurationManager.ConnectionStrings["DBConn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "SELECT TransportID, Name, Source, Destination, DepartureTime, Seats, Price FROM Transport WHERE CAST(DepartureTime AS DATE) >= CAST(GETDATE() AS DATE)";
            
            if (!string.IsNullOrEmpty(source))
                query += " AND Source LIKE @Source";
            if (!string.IsNullOrEmpty(destination))
                query += " AND Destination LIKE @Destination";
            if (!string.IsNullOrEmpty(date))
                query += " AND CAST(DepartureTime as DATE) = @Date";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                if (!string.IsNullOrEmpty(source))
                    cmd.Parameters.AddWithValue("@Source", "%" + source + "%");
                if (!string.IsNullOrEmpty(destination))
                    cmd.Parameters.AddWithValue("@Destination", "%" + destination + "%");
                if (!string.IsNullOrEmpty(date))
                    cmd.Parameters.AddWithValue("@Date", date);

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    gvTransports.DataSource = dt;
                    gvTransports.DataBind();
                }
            }
        }
    }

    protected void gvTransports_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Book")
        {
            string transportId = e.CommandArgument.ToString();
            if (Session["UserID"] != null)
            {
                Response.Redirect("BookTicket.aspx?tid=" + transportId);
            }
            else
            {
                Response.Redirect("Login.aspx?msg=login_required");
            }
        }
    }
}
