<%@ Page Title="Manage Transports" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="ManageTransport.aspx.cs" Inherits="ManageTransport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2 class="mb-4">Manage Transports</h2>
    <asp:Label ID="lblMessage" runat="server" CssClass="mb-3 d-block fw-bold"></asp:Label>
    <a href="AddTransport.aspx" class="btn btn-primary mb-3">Add New Transport</a>
    
    <asp:GridView ID="gvTransports" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped"
        DataKeyNames="TransportID" OnRowDeleting="gvTransports_RowDeleting" OnRowEditing="gvTransports_RowEditing"
        OnRowUpdating="gvTransports_RowUpdating" OnRowCancelingEdit="gvTransports_RowCancelingEdit"
        OnRowDataBound="gvTransports_RowDataBound"
        EditRowStyle-CssClass="table-edit-row table-warning">
        <Columns>
            <asp:BoundField DataField="TransportID" HeaderText="ID" ReadOnly="True" />
            <asp:BoundField DataField="Name" HeaderText="Name" ControlStyle-CssClass="form-control form-control-sm edit-input" />
            <asp:BoundField DataField="Source" HeaderText="Source" ControlStyle-CssClass="form-control form-control-sm edit-input" />
            <asp:BoundField DataField="Destination" HeaderText="Destination" ControlStyle-CssClass="form-control form-control-sm edit-input" />
            <asp:BoundField DataField="DepartureTime" HeaderText="Departure Time" DataFormatString="{0:yyyy-MM-ddTHH:mm}" ControlStyle-CssClass="form-control form-control-sm edit-input" />
            <asp:BoundField DataField="Seats" HeaderText="Seats" ControlStyle-CssClass="form-control form-control-sm edit-input edit-input-sm" />
            <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:0.00}" ControlStyle-CssClass="form-control form-control-sm edit-input edit-input-sm" />
            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True"
                EditText="Edit" UpdateText="Save" CancelText="Cancel" DeleteText="Delete"
                ButtonType="Link" />
        </Columns>
    </asp:GridView>
</asp:Content>
