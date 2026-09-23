using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadUpcomingTransports();
        }
    }

    private void LoadUpcomingTransports()
    {
        string connStr = ConfigurationManager.ConnectionStrings["DBConn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "SELECT TransportID, Name, Source, Destination, DepartureTime, Seats, Price FROM Transport WHERE CAST(DepartureTime AS DATE) >= CAST(GETDATE() AS DATE) ORDER BY DepartureTime";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptTransports.DataSource = dt;
                    rptTransports.DataBind();
                }
            }
        }
    }

    // Returns the first 2 letters of a transport name for the icon
    public string GetTransportInitial(string name)
    {
        if (string.IsNullOrWhiteSpace(name)) return "?";
        var parts = name.Trim().Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
        if (parts.Length >= 2 && parts[0].Length > 0 && parts[1].Length > 0)
            return (parts[0][0].ToString() + parts[1][0].ToString()).ToUpper();
        return name.Trim().Length >= 2 ? name.Trim().Substring(0, 2).ToUpper() : name.Trim().ToUpper();
    }

    protected void rptTransports_ItemCommand(object source, RepeaterCommandEventArgs e)
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
