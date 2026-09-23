<%@ Page Title="My Bookings" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MyBookings.aspx.cs" Inherits="MyBookings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-md-12">
            <h2 class="mb-4">My Bookings</h2>
            <asp:Label ID="lblMessage" runat="server" CssClass="text-success mb-3 d-block fw-bold"></asp:Label>
            
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                <asp:GridView ID="gvBookings" runat="server" AutoGenerateColumns="False" 
                    CssClass="table table-hover mb-0 border-0"
                    DataKeyNames="BookingID" OnRowCommand="gvBookings_RowCommand"
                    GridLines="None">
                    <HeaderStyle CssClass="bg-light text-secondary fw-bold text-uppercase small py-3" />
                    <RowStyle CssClass="align-middle" />
                    <Columns>
                        <asp:BoundField DataField="BookingID" HeaderText="ID" ItemStyle-Width="60px" />
                        <asp:BoundField DataField="Name" HeaderText="Transport" />
                        <asp:TemplateField HeaderText="Route">
                            <ItemTemplate>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="fw-600"><%# Eval("Source") %></span>
                                    <span class="text-muted">&rarr;</span>
                                    <span class="fw-600"><%# Eval("Destination") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="DepartureTime" HeaderText="Departure" DataFormatString="{0:dd MMM, HH:mm}" ItemStyle-CssClass="text-nowrap" />
                        <asp:BoundField DataField="SeatNo" HeaderText="Seat" ItemStyle-CssClass="fw-bold text-primary" />
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class='badge <%# Eval("Status").ToString() == "Confirmed" ? "bg-success-subtle text-success" : "bg-danger-subtle text-danger" %> px-3 py-2 rounded-pill'>
                                    <%# Eval("Status") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemStyle CssClass="text-end pe-4" />
                            <ItemTemplate>
                                <div class="d-flex justify-content-end gap-2">
                                    <asp:HyperLink ID="hlPrint" runat="server" 
                                        NavigateUrl='<%# "DownloadTicket.aspx?bid=" + Eval("BookingID") %>' 
                                        CssClass="btn btn-outline-primary btn-sm rounded-3 fw-bold px-3"
                                        Visible='<%# Eval("Status").ToString() != "Cancelled" %>'>
                                        Print Ticket
                                    </asp:HyperLink>
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CommandName="CancelTicket" 
                                        CommandArgument='<%# Eval("BookingID") + "|" + Eval("TransportID") %>' 
                                        CssClass="btn btn-outline-danger btn-sm rounded-3 fw-bold px-3" 
                                        Visible='<%# Eval("Status").ToString() != "Cancelled" %>'
                                        OnClientClick="return confirm('Are you sure you want to cancel this ticket?');" />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="p-5 text-center text-muted border-top">
                            <div class="mb-3" style="font-size: 40px;">🎫</div>
                            <p class="mb-0">You have no bookings yet.</p>
                            <a href="Search.aspx" class="btn btn-primary mt-3 btn-sm">Find Transports</a>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
