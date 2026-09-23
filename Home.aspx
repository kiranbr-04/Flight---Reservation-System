<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<style>
    /* ---- Upcoming Transports ---- */
    .transport-container { max-width: 1200px; margin: 0 auto; padding: 0 15px; }

    .transport-row {
        display: flex;
        align-items: center;
        background: #fff;
        border: 1px solid #f1f5f9;
        border-radius: 14px;
        padding: 18px 24px;
        margin-bottom: 12px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.02);
        position: relative;
        overflow: hidden;
    }

    .transport-row::before {
        content: '';
        position: absolute;
        left: 0; top: 0; bottom: 0;
        width: 4px;
        background: var(--primary-color);
        opacity: 0.8;
    }

    /* Column widths for wide layout */
    .tc-brand  { flex: 0 0 220px; }
    .tc-route  { flex: 1; padding: 0 40px; }
    .tc-date   { flex: 0 0 160px; text-align: left; }
    .tc-seats  { flex: 0 0 120px; text-align: center; }
    .tc-price  { flex: 0 0 140px; text-align: right; }
    .tc-action { flex: 0 0 140px; text-align: right; }

    /* Brand */
    .tc-brand .brand-wrap { display: flex; align-items: center; gap: 14px; }
    .brand-icon {
        width: 42px; height: 42px;
        background: #1e3a8a;
        border-radius: 10px;
        display: flex; align-items: center; justify-content: center;
        color: #fff; font-weight: 700; font-size: 0.9rem;
        flex-shrink: 0;
    }
    .brand-name  { font-size: 0.95rem; font-weight: 700; color: #1e293b; line-height: 1.2; }
    .brand-id    { font-size: 0.75rem; color: #94a3b8; font-weight: 500; margin-top: 2px; }

    /* Route */
    .tc-route .route-wrap { display: flex; align-items: center; justify-content: space-between; position: relative; }
    .route-point { flex: 1; }
    .route-point.to { text-align: right; }
    
    .route-city { font-size: 1.1rem; font-weight: 700; color: #0f172a; }
    .route-arrow-wrap { 
        padding: 0 15px; 
        color: #94a3b8; 
        display: flex; 
        flex-direction: column; 
        align-items: center;
        margin-top: 15px;
    }
    .route-arrow { font-size: 1.2rem; opacity: 0.4; }
    .route-label { font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.05em; color: #94a3b8; font-weight: 600; }

    /* Date */
    .tc-date .date-val  { font-size: 1.05rem; font-weight: 700; color: #1e3a8a; }
    .tc-date .date-sub  { font-size: 0.78rem; color: #64748b; font-weight: 500; }

    /* Seats */
    .seats-pill {
        display: inline-block;
        padding: 5px 14px;
        border-radius: 10px;
        font-size: 0.82rem; font-weight: 600;
        background: #f0fdf4; color: #166534;
        border: 1px solid #dcfce7;
    }
    .seats-pill.low { background: #fff1f2; color: #9f1239; border-color: #ffe4e6; }

    /* Price */
    .tc-price .price-val  { font-size: 1.2rem; font-weight: 800; color: #0f172a; }
    .tc-price .price-sub  { font-size: 0.75rem; color: #64748b; }

    /* Book button */
    .btn-book-now {
        display: inline-block;
        padding: 10px 24px;
        border-radius: 10px;
        font-size: 0.88rem; font-weight: 700;
        background: #059669;
        color: #fff !important;
        border: none;
        cursor: pointer;
        transition: all 0.2s ease;
        box-shadow: 0 4px 6px rgba(5, 150, 105, 0.1);
    }
    .btn-book-now:hover { 
        background: #047857 !important; 
        transform: scale(1.03);
        box-shadow: 0 6px 12px rgba(5, 150, 105, 0.2);
    }

    /* Header row */
    .transport-header {
        display: flex;
        align-items: center;
        padding: 12px 24px;
        margin-bottom: 8px;
        font-size: 0.75rem; font-weight: 700;
        color: #94a3b8; text-transform: uppercase; letter-spacing: 0.1em;
    }

    .no-transports { text-align: center; padding: 60px 20px; color: #94a3b8; }

    /* Section title */
    .section-title {
        font-size: 1.4rem; font-weight: 800; color: #1e293b;
        margin-bottom: 6px;
    }
    .section-underline {
        width: 48px; height: 4px; background: var(--primary-color);
        border-radius: 4px; margin-bottom: 30px;
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <!-- Page Wrapper -->
    <div style="max-width:100%;">

        <!-- Hero Banner -->
        <div class="hero-section" style="margin-bottom:28px;">
            <h1 class="display-5 fw-bold">Book Your Next Journey</h1>
            <p class="lead">Fast, Secure and Reliable Train &amp; Flight Reservations.</p>
            <a href="Search.aspx" class="btn btn-primary btn-lg mt-3">Search Tickets Now</a>
        </div>

        <!-- Transport Listing -->
        <div class="transport-container">
            <div class="section-title">Upcoming Transports</div>
            <div class="section-underline"></div>

        <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3 text-danger fw-bold"></asp:Label>

        <!-- Column Headers -->
        <div class="transport-header">
            <div class="tc-brand">Transport</div>
            <div class="tc-route">Route Details</div>
            <div class="tc-date">Departure</div>
            <div class="tc-seats">Seats</div>
            <div class="tc-price">Price</div>
            <div class="tc-action"></div>
        </div>

        <asp:Repeater ID="rptTransports" runat="server" OnItemCommand="rptTransports_ItemCommand">
            <ItemTemplate>
                <div class="transport-row">

                    <!-- Transport Name -->
                    <div class="tc-brand">
                        <div class="brand-wrap">
                            <div class="brand-icon"><%# GetTransportInitial(Eval("Name").ToString()) %></div>
                            <div>
                                <div class="brand-name"><%# Eval("Name") %></div>
                                <div class="brand-id">ID #<%# Eval("TransportID") %></div>
                            </div>
                        </div>
                    </div>

                    <!-- Route -->
                    <div class="tc-route">
                        <div class="route-wrap">
                            <div class="route-point">
                                <span class="route-label">From</span>
                                <div class="route-city"><%# Eval("Source") %></div>
                            </div>
                            <div class="route-arrow-wrap">
                                <span class="route-arrow">&rarr;</span>
                            </div>
                            <div class="route-point to">
                                <span class="route-label">To</span>
                                <div class="route-city"><%# Eval("Destination") %></div>
                            </div>
                        </div>
                    </div>

                    <!-- Departure Date & Time -->
                    <div class="tc-date">
                        <div class="date-val"><%# Eval("DepartureTime", "{0:HH:mm}") %></div>
                        <div class="date-sub"><%# Eval("DepartureTime", "{0:dd MMM yyyy}") %></div>
                    </div>

                    <!-- Seats -->
                    <div class="tc-seats">
                        <span class="seats-pill <%# Convert.ToInt32(Eval("Seats")) < 20 ? "low" : "" %>">
                            <%# Eval("Seats") %> left
                        </span>
                    </div>

                    <!-- Price -->
                    <div class="tc-price">
                        <div class="price-val">&#8377; <%# string.Format("{0:0.00}", Eval("Price")) %></div>
                        <div class="price-sub">per person</div>
                    </div>

                    <!-- Book Action -->
                    <div class="tc-action">
                        <asp:Button ID="btnBook" runat="server"
                            Text="Book Now"
                            CommandName="Book"
                            CommandArgument='<%# Eval("TransportID") %>'
                            CssClass="btn-book-now" />
                    </div>

                </div>
            </ItemTemplate>
            <FooterTemplate>
                <asp:Panel ID="pnlEmpty" runat="server" Visible='<%# rptTransports.Items.Count == 0 %>'>
                    <div class="no-transports rounded-4 bg-white border p-5">
                        <div class="mb-3" style="font-size: 3rem; opacity: 0.2;">🗺️</div>
                        <h5 class="fw-bold text-dark">No Transports Found</h5>
                        <p class="text-muted">No upcoming transports match your search criteria.</p>
                        <a href="Search.aspx" class="btn btn-primary mt-2">Search for Routes</a>
                    </div>
                </asp:Panel>
            </FooterTemplate>
        </asp:Repeater>
        </div><!-- /transport listing -->

        <!-- Feature Cards -->
        <div class="row text-center mt-5">
            <div class="col-md-4 mb-4">
                <div class="card h-100 p-4 border-0">
                    <h3 class="text-primary">Fast Booking</h3>
                    <p>Book your tickets in just a few clicks. Our streamlined process saves you time.</p>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100 p-4 border-0">
                    <h3 class="text-primary">Secure Payments</h3>
                    <p>Your transactions are 100% secure with top tier encryption and privacy standards.</p>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100 p-4 border-0">
                    <h3 class="text-primary">24/7 Support</h3>
                    <p>Our customer service team is always available to help you with your journey.</p>
                </div>
            </div>
        </div>

    </div><!-- /page wrapper -->

</asp:Content>
