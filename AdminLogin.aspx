<%@ Page Title="Admin Login" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="AdminLogin.aspx.cs" Inherits="AdminLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card p-4 mt-5">
                <h3 class="text-center mb-4">Admin Login</h3>
                <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mb-3 d-block"></asp:Label>
                
                <div class="mb-3">
                    <label>Username</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label>Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" required="required"></asp:TextBox>
                </div>
                
                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-dark w-100" OnClick="btnLogin_Click" />
            </div>
        </div>
    </div>
</asp:Content>
