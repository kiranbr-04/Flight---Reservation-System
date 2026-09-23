<%@ Page Title="Add Transport" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="AddTransport.aspx.cs" Inherits="AddTransport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card p-4">
                <h3 class="mb-4">Add New Transport</h3>
                <asp:Label ID="lblMessage" runat="server" CssClass="mb-3 d-block fw-bold"></asp:Label>
                
                <div class="row g-3">
                    <div class="col-md-6">
                        <label>Transport Name (e.g. Flight Air123, Train Express)</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label>Departure Time</label>
                        <asp:TextBox ID="txtDeparture" runat="server" CssClass="form-control" TextMode="DateTimeLocal" required="required"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label>Source</label>
                        <asp:TextBox ID="txtSource" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label>Destination</label>
                        <asp:TextBox ID="txtDestination" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label>Total Seats</label>
                        <asp:TextBox ID="txtSeats" runat="server" CssClass="form-control" TextMode="Number" required="required"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label>Price (in USD/Local Curr)</label>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" TextMode="Number" step="0.01" required="required"></asp:TextBox>
                    </div>
                    <div class="col-12 mt-4">
                        <asp:Button ID="btnAdd" runat="server" Text="Add Transport" CssClass="btn btn-primary" OnClick="btnAdd_Click" />
                        <a href="ManageTransport.aspx" class="btn btn-secondary ms-2">Cancel</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
