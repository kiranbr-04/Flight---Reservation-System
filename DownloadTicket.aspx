<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DownloadTicket.aspx.cs" Inherits="DownloadTicket" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Download Your Ticket - TravelBook</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f3f4f6;
            color: #111827;
            padding: 20px;
        }

        .e-ticket {
            max-width: 800px;
            margin: 0 auto;
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            overflow: hidden;
        }

        .ticket-header {
            background-color: #1e3a8a;
            color: white;
            padding: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-left .brand {
            font-size: 24px;
            font-weight: 800;
            letter-spacing: -0.025em;
        }

        .header-right {
            text-align: right;
        }

        .ticket-title {
            font-size: 14px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            opacity: 0.9;
        }

        .booking-ref {
            font-size: 20px;
            font-weight: 800;
        }

        .ticket-body {
            padding: 30px 40px;
        }

        .section-title {
            font-size: 12px;
            font-weight: 700;
            color: #6b7280;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            border-bottom: 2px solid #f3f4f6;
            padding-bottom: 8px;
            margin-bottom: 20px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 40px;
        }

        .info-item .label {
            font-size: 11px;
            color: #9ca3af;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 4px;
        }

        .info-item .value {
            font-size: 16px;
            font-weight: 700;
            color: #111827;
        }

        .route-container {
            background: #f9fafb;
            padding: 25px;
            border-radius: 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            border: 1px solid #f3f4f6;
        }

        .route-point {
            flex: 1;
        }

        .route-point.to {
            text-align: right;
        }

        .city-label {
            font-size: 12px;
            color: #6b7280;
            font-weight: 500;
        }

        .city-name {
            font-size: 24px;
            font-weight: 800;
            color: #1e3a8a;
        }

        .route-arrow {
            padding: 0 20px;
            color: #d1d5db;
            font-size: 24px;
        }

        .footer-note {
            margin-top: 40px;
            padding: 20px;
            background: #fff8f1;
            border-left: 4px solid #f97316;
            font-size: 13px;
            color: #9a3412;
            line-height: 1.5;
        }

        .barcode-placeholder {
            margin-top: 40px;
            text-align: center;
            opacity: 0.5;
        }

        .no-print {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container text-center no-print">
            <div class="alert alert-primary d-inline-block px-5 py-3 rounded-4 shadow-sm border-0">
                <h4 class="fw-800 mb-2">E-Ticket Ready! &#x1F3AB;</h4>
                <p class="mb-3 text-muted">Your booking is confirmed. You can now download your e-ticket below.</p>
                <div class="d-flex justify-content-center gap-2">
                    <button type="button" onclick="generatePDF()" class="btn btn-primary px-4 fw-bold rounded-3">Download PDF</button>
                    <a href="MyBookings.aspx" class="btn btn-outline-secondary px-4 fw-bold rounded-3">My Bookings</a>
                </div>
            </div>
        </div>

        <div id="ticket-content" class="e-ticket">
            <div class="ticket-header">
                <div class="header-left">
                    <div class="brand">TravelBook</div>
                    <div class="ticket-title">E-Ticket</div>
                </div>
                <div class="header-right">
                    <div class="ticket-title">Booking ID</div>
                    <div class="booking-ref">#<%= BookingID.PadLeft(6, '0') %></div>
                </div>
            </div>

            <div class="ticket-body">
                <div class="section-title">Passenger Details</div>
                <div class="d-flex align-items-center mb-5 p-3 rounded-4" style="background: #f9fafb; border: 1px solid #f3f4f6;">
                    <div style="width: 70px; height: 70px; border-radius: 50%; overflow: hidden; border: 3px solid #fff; box-shadow: 0 4px 10px rgba(0,0,0,0.05); flex-shrink: 0;">
                        <img src="images/passenger_avatar.png" alt="Passenger" style="width: 100%; height: 100%; object-fit: cover;" />
                    </div>
                    <div class="d-flex w-100 justify-content-around align-items-center ms-4">
                        <div class="info-item text-center">
                            <div class="label" style="margin-bottom: 2px;">Passenger Name</div>
                            <div class="value" style="font-size: 18px; color: #1e3a8a;"><%= PassengerName.ToUpper() %></div>
                        </div>
                        <div style="height: 30px; width: 1px; background: #e5e7eb;"></div>
                        <div class="info-item text-center">
                            <div class="label" style="margin-bottom: 2px;">Seat Number</div>
                            <div class="value" style="color: #2563eb; font-size: 20px;"><%= SeatNo %></div>
                        </div>
                    </div>
                </div>

                <div class="section-title">Journey Details</div>
                <div class="route-container" style="padding: 35px 30px;">
                    <div class="route-point">
                        <div class="city-label" style="text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 5px;">Departure</div>
                        <div class="city-name" style="font-size: 28px;"><%= Source %></div>
                    </div>
                    <div class="route-arrow" style="font-size: 32px; color: #1e3a8a; opacity: 0.2;">&rarr;</div>
                    <div class="route-point to">
                        <div class="city-label" style="text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 5px;">Arrival</div>
                        <div class="city-name" style="font-size: 28px;"><%= Destination %></div>
                    </div>
                </div>

                <div class="info-grid" style="padding: 0 10px;">
                    <div class="info-item">
                        <div class="label">Transport</div>
                        <div class="value" style="font-size: 17px;"><%= TransportName %></div>
                    </div>
                    <div class="info-item">
                        <div class="label">Total Fare Paid</div>
                        <div class="value" style="color: #059669; font-size: 20px;"><%= Price %></div>
                    </div>
                    <div class="info-item">
                        <div class="label">Departure Date</div>
                        <div class="value" style="font-size: 17px;"><%= Convert.ToDateTime(DepartureTime).ToString("D") %></div>
                    </div>
                    <div class="info-item">
                        <div class="label">Scheduled Time</div>
                        <div class="value" style="font-size: 17px; color: #1e3a8a;"><%= Convert.ToDateTime(DepartureTime).ToString("HH:mm") %></div>
                    </div>
                    <div class="info-item">
                        <div class="label">Mode of Transaction</div>
                        <div class="value" style="font-size: 17px; color: #2563eb;"><%= PaymentMethod %></div>
                    </div>
                </div>

                <div class="text-center mt-5" style="border-top: 1px solid #f3f4f6; padding-top: 20px;">
                    <h3 style="color: #1e3a8a; font-weight: 800; letter-spacing: -0.01em;">Thank You!</h3>
                    <p style="color: #6b7280; font-size: 14px;">Thank you for choosing TravelBook. Have a safe journey!</p>
                </div>

                <div class="barcode-placeholder">
                    <div style="font-family: monospace; font-size: 12px; margin-bottom: 5px;">*<%= BookingID.PadLeft(10, '0') %>*</div>
                    <div style="height: 30px; background: repeating-linear-gradient(90deg, #000, #000 1px, transparent 1px, transparent 3px);"></div>
                </div>
            </div>
        </div>
    </form>

    <script>
        function generatePDF() {
            const element = document.getElementById('ticket-content');
            const opt = {
                margin:       [0.2, 0.2],
                filename:     'TravelBook_Ticket_<%= BookingID %>.pdf',
                image:        { type: 'jpeg', quality: 0.98 },
                html2canvas:  { scale: 2, useCORS: true, letterRendering: true },
                jsPDF:        { unit: 'in', format: 'a4', orientation: 'portrait' },
                pagebreak:    { mode: ['avoid-all', 'css', 'legacy'] }
            };

            html2pdf().set(opt).from(element).save();
        }
    </script>
</body>
</html>
