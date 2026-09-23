using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class ManageTransport : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["DBConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null)
            Response.Redirect("AdminLogin.aspx");

        if (!IsPostBack)
        {
            BindGrid();
        }
    }

    private void BindGrid()
    {
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "SELECT * FROM Transport ORDER BY DepartureTime DESC";
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

    protected void gvTransports_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvTransports.EditIndex = e.NewEditIndex;
        BindGrid();
    }

    protected void gvTransports_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvTransports.EditIndex = -1;
        BindGrid();
    }

    protected void gvTransports_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int transportId = Convert.ToInt32(gvTransports.DataKeys[e.RowIndex].Value.ToString());
        string name = ((TextBox)gvTransports.Rows[e.RowIndex].Cells[1].Controls[0]).Text;
        string source = ((TextBox)gvTransports.Rows[e.RowIndex].Cells[2].Controls[0]).Text;
        string dest = ((TextBox)gvTransports.Rows[e.RowIndex].Cells[3].Controls[0]).Text;
        DateTime departure = Convert.ToDateTime(((TextBox)gvTransports.Rows[e.RowIndex].Cells[4].Controls[0]).Text);
        int seats = Convert.ToInt32(((TextBox)gvTransports.Rows[e.RowIndex].Cells[5].Controls[0]).Text);
        decimal price = Convert.ToDecimal(((TextBox)gvTransports.Rows[e.RowIndex].Cells[6].Controls[0]).Text);

        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "UPDATE Transport SET Name=@Name, Source=@Source, Destination=@Destination, DepartureTime=@DepartureTime, Seats=@Seats, Price=@Price WHERE TransportID=@TransportID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@TransportID", transportId);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Source", source);
                cmd.Parameters.AddWithValue("@Destination", dest);
                cmd.Parameters.AddWithValue("@DepartureTime", departure);
                cmd.Parameters.AddWithValue("@Seats", seats);
                cmd.Parameters.AddWithValue("@Price", price);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        gvTransports.EditIndex = -1;
        BindGrid();
        lblMessage.Text = "Transport updated successfully.";
        lblMessage.CssClass = "text-success mb-3 d-block fw-bold";
    }

    protected void gvTransports_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            bool isEditing = (e.Row.RowState & DataControlRowState.Edit) != 0;

            System.Web.UI.WebControls.TableCell actionCell =
                (System.Web.UI.WebControls.TableCell)e.Row.Controls[e.Row.Controls.Count - 1];

            foreach (System.Web.UI.Control ctrl in actionCell.Controls)
            {
                LinkButton btn = ctrl as LinkButton;
                if (btn == null) continue;

                // Uniform CSS for all buttons
                btn.CssClass = "btn btn-sm btn-primary text-white grid-action-btn";

                switch (btn.CommandName)
                {
                    case "Edit":   btn.Visible = !isEditing; break;
                    case "Update": btn.Text = "Save"; btn.Visible = isEditing; break;
                    case "Cancel": btn.Visible = false; break;
                    case "Delete":
                        btn.Visible = !isEditing;
                        btn.OnClientClick = "return confirm('Are you sure you want to delete this transport?');";
                        break;
                }
            }
        }
    }



    protected void gvTransports_RowDeleting(object sender, GridViewDeleteEventArgs e)

    {
        int transportId = Convert.ToInt32(gvTransports.DataKeys[e.RowIndex].Value.ToString());

        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "DELETE FROM Transport WHERE TransportID=@TransportID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@TransportID", transportId);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMessage.Text = "Transport deleted successfully.";
                    lblMessage.CssClass = "text-success mb-3 d-block fw-bold";
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 547) // Foreign key violation
                        lblMessage.Text = "Cannot delete transport because it has existing bookings.";
                    else
                        lblMessage.Text = "Error: " + ex.Message;
                    lblMessage.CssClass = "text-danger mb-3 d-block fw-bold";
                }
            }
        }
        BindGrid();
    }
}
