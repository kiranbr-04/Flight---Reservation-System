<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="AdminDashboard.aspx.cs" Inherits="AdminDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2 class="mb-4">Admin Dashboard</h2>
    <div class="row">
        <div class="col-md-4">
            <div class="card text-white bg-primary mb-3">
                <div class="card-body">
                    <h5 class="card-title">Total Users</h5>
                    <p class="card-text display-4"><asp:Literal ID="litUsers" runat="server" Text="0"></asp:Literal></p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-white bg-success mb-3">
                <div class="card-body">
                    <h5 class="card-title">Total Bookings</h5>
                    <p class="card-text display-4"><asp:Literal ID="litBookings" runat="server" Text="0"></asp:Literal></p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-white bg-warning mb-3">
                <div class="card-body">
                    <h5 class="card-title">Total Transports</h5>
                    <p class="card-text display-4"><asp:Literal ID="litTransports" runat="server" Text="0"></asp:Literal></p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
