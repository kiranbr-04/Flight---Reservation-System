<%@ Page Title="Book Ticket" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="BookTicket.aspx.cs" Inherits="BookTicket" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .payment-options label {
            margin-right: 15px;
            cursor: pointer;
            font-weight: normal;
        }
        .payment-options input[type="radio"] {
            margin-right: 5px;
        }
        .payment-details {
            display: none;
            margin-top: 15px;
            padding: 15px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            background-color: #f8f9fa;
        }
    </style>
    <script>
        function togglePaymentFields() {
            var rbCard = document.getElementById('<%= rbCard.ClientID %>');
            var cardSection = document.getElementById('cardDetails');
            var upiSection = document.getElementById('upiDetails');
            
            if (rbCard && rbCard.checked) {
                cardSection.style.display = 'block';
                upiSection.style.display = 'none';
            } else {
                cardSection.style.display = 'none';
                upiSection.style.display = 'block';
            }
        }
        
        window.onload = function() {
            togglePaymentFields();
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card p-4">
                <h3 class="text-center mb-4">Book Ticket</h3>
                <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mb-3 d-block"></asp:Label>
                
                <div class="alert alert-info">
                    <h5>Transport Details</h5>
                    <asp:Literal ID="litTransportDetails" runat="server"></asp:Literal>
                </div>

                <div class="mb-3">
                    <label>Select Seat No</label>
                    <asp:TextBox ID="txtSeatNo" runat="server" CssClass="form-control" placeholder="e.g., A1, B12" required="required"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label d-block fw-semibold mb-2">Payment Method</label>
                    <div class="d-flex gap-4 p-2 border rounded bg-light">
                        <div class="form-check">
                            <asp:RadioButton ID="rbCard" runat="server" GroupName="Payment" Text="&nbsp;Credit/Debit Card" Checked="True" onclick="togglePaymentFields();" />
                        </div>
                        <div class="form-check">
                            <asp:RadioButton ID="rbUPI" runat="server" GroupName="Payment" Text="&nbsp;UPI Payment" onclick="togglePaymentFields();" />
                        </div>
                    </div>
                </div>

                <!-- Card Details Section -->
                <div id="cardDetails" class="payment-details">
                    <div class="mb-2">
                        <label class="small fw-bold">Card Number</label>
                        <asp:TextBox ID="txtCardNo" runat="server" CssClass="form-control form-control-sm" placeholder="1234 5678 9101 1121"></asp:TextBox>
                    </div>
                    <div class="row g-2">
                        <div class="col-6">
                            <label class="small fw-bold">Expiry</label>
                            <asp:TextBox ID="txtExpiry" runat="server" CssClass="form-control form-control-sm" placeholder="MM/YY"></asp:TextBox>
                        </div>
                        <div class="col-6">
                            <label class="small fw-bold">CVV</label>
                            <asp:TextBox ID="txtCVV" runat="server" CssClass="form-control form-control-sm" placeholder="123"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <!-- UPI Details Section -->
                <div id="upiDetails" class="payment-details">
                    <label class="small fw-bold">UPI ID</label>
                    <asp:TextBox ID="txtUpiId" runat="server" CssClass="form-control form-control-sm" placeholder="username@bank"></asp:TextBox>
                </div>
                
                <asp:Button ID="btnConfirmBook" runat="server" Text="Confirm Booking" CssClass="btn btn-success w-100 py-2 mt-3 shadow-sm" OnClick="btnConfirmBook_Click" OnClientClick="return confirm('Are you sure you want to proceed with this booking?');" />
            </div>
        </div>
    </div>
</asp:Content>
