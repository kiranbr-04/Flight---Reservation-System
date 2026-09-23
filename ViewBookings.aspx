<%@ Page Title="View Bookings" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="ViewBookings.aspx.cs" Inherits="ViewBookings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2 class="mb-4">All User Bookings</h2>
    
    <asp:GridView ID="gvAllBookings" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped">
        <Columns>
            <asp:BoundField DataField="BookingID" HeaderText="Booking ID" />
            <asp:BoundField DataField="UserName" HeaderText="Passenger Name" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="TransportName" HeaderText="Transport" />
            <asp:BoundField DataField="Source" HeaderText="From" />
            <asp:BoundField DataField="Destination" HeaderText="To" />
            <asp:BoundField DataField="JourneyDate" HeaderText="Journey Date" DataFormatString="{0:dd MMM yyyy}" />
            <asp:BoundField DataField="SeatNo" HeaderText="Seat" />
            <asp:BoundField DataField="Status" HeaderText="Status" />
        </Columns>
    </asp:GridView>
</asp:Content>
