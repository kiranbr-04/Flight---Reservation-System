<%@ Page Title="Search Routes" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="Search" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card p-4">
                <h2 class="text-center mb-4">Search Transports</h2>
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label">Source</label>
                        <asp:TextBox ID="txtSource" runat="server" CssClass="form-control" placeholder="City or Airport"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Destination</label>
                        <asp:TextBox ID="txtDestination" runat="server" CssClass="form-control" placeholder="City or Airport"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Date (Optional)</label>
                        <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="col-12 text-center mt-4">
                        <asp:Button ID="btnSearch" runat="server" Text="Search Transport" CssClass="btn btn-primary px-5" OnClick="btnSearch_Click" />
                    </div>
                </div>
            </div>

            <div class="mt-4">
                <asp:Label ID="lblMessage" runat="server" CssClass="text-danger fw-bold"></asp:Label>
                <asp:GridView ID="gvTransports" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped"
                    DataKeyNames="TransportID" OnRowCommand="gvTransports_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Name" HeaderText="Transport Name" />
                        <asp:BoundField DataField="Source" HeaderText="Source" />
                        <asp:BoundField DataField="Destination" HeaderText="Destination" />
                        <asp:BoundField DataField="DepartureTime" HeaderText="Departure" DataFormatString="{0:dd MMM yyyy HH:mm}" ItemStyle-CssClass="text-nowrap" />
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" ItemStyle-CssClass="text-nowrap" />
                        <asp:BoundField DataField="Seats" HeaderText="Available Seats" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnBook" runat="server" Text="Book Now" CommandName="Book" CommandArgument='<%# Eval("TransportID") %>' CssClass="btn btn-success btn-sm" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="alert alert-info text-center">No transport available for the selected route.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
