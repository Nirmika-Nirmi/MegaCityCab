<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Bean.Billing, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Billing History</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        /* ======= General Styles ======= */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f4f7fa, #e8eef7);
            margin: 0;
            padding: 0;
            color: #333;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* ======= Header ======= */
        .header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .header h1 {
            margin: 0;
            font-size: 28px;
            font-weight: 600;
        }

        /* ======= Navigation Bar ======= */
        .navbar {
            background: white;
            padding: 10px 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
        }

        .navbar a {
            color: #555;
            padding: 10px 20px;
            margin: 5px;
            text-decoration: none;
            font-weight: 500;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .navbar a:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(102, 126, 234, 0.3);
        }

        /* ======= Main Content ======= */
        .container {
            margin-top: 20px;
            margin-bottom: 40px;
            flex: 1; /* Allow the container to grow and take up remaining space */
        }

        .container h1 {
            font-size: 28px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 20px;
        }

        /* ======= Table Styles ======= */
        .table {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .table thead {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .table th {
            font-weight: 500;
            padding: 15px;
            text-align: center;
        }

        .table td {
            padding: 12px;
            text-align: center;
            vertical-align: middle;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(102, 126, 234, 0.05);
        }

        .table-hover tbody tr:hover {
            background-color: rgba(102, 126, 234, 0.1);
        }

        .table-bordered {
            border: 1px solid #dee2e6;
        }

        .table-bordered th,
        .table-bordered td {
            border: 1px solid #dee2e6;
        }

        /* ======= Payment Status Badges ======= */
        .payment-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
        }

        .payment-badge.paid {
            background-color: #28a745;
            color: white;
        }

        .payment-badge.unpaid {
            background-color: #dc3545;
            color: white;
        }

        .payment-badge.pending {
            background-color: #ffc107;
            color: black;
        }

        /* ======= No Data Message ======= */
        .no-data {
            font-size: 16px;
            color: #6c757d;
            text-align: center;
            padding: 20px;
        }

        /* ======= Footer ======= */
        .footer {
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 15px;
            font-size: 14px;
            position: fixed;
            left: 0;
            bottom: 0;
            width: 100%;
        }

        .footer a {
            color: #667eea;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        /* ======= Responsive Design ======= */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                align-items: center;
            }

            .navbar a {
                width: 100%;
                text-align: center;
                margin: 5px 0;
            }

            .container {
                margin: 10px;
                padding: 15px;
            }

            .table th,
            .table td {
                font-size: 14px;
                padding: 10px;
            }

            h1 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>

    <!-- Header -->
    <div class="header">
        <h1>Admin Dashboard - Billing History</h1>
    </div>

    <!-- Navigation Bar -->
    <nav class="navbar">
        <a href="admin-dashboard.jsp"><i class="fas fa-home"></i> Home</a>
        <a href="viewDrivers.jsp"><i class="fas fa-users"></i> View Drivers</a>
        <a href="viewCustomers.jsp"><i class="fas fa-user-friends"></i> View Customers</a>
        <a href="adminBookingHistory.jsp"><i class="fas fa-calendar-alt"></i> Manage Bookings</a>
        <a href="adminViewCars.jsp"><i class="fas fa-car"></i> Manage Cars</a>
        <a href="adminFeedback.jsp"><i class="fas fa-comments"></i> Reports</a>
        <a href="adminProfile.jsp"><i class="fas fa-user-cog"></i> Profile</a>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h1>Billing History</h1>

        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <th>Bill ID</th>
                    <th>Booking ID</th>
                    <th>Customer Name</th>
                    <th>Customer Phone</th>
                    <th>Driver Name</th>
                    <th>Driver Phone</th>
                    <th>Pickup Location</th>
                    <th>Drop Location</th>
                    <th>Distance (KM)</th>
                    <th>Starting Meter</th>
                    <th>Ending Meter</th>
                    <th>Final Amount</th>
                    <th>Payment Method</th>
                    <th>Payment Status</th>
                    <th>Bill Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Billing> billingList = (List<Billing>) request.getAttribute("billingList");
                    if (billingList == null) {
                        System.out.println("Billing list is null.");
                    } else if (billingList.isEmpty()) {
                        System.out.println("Billing list is empty.");
                    }

                    if (billingList != null && !billingList.isEmpty()) {
                        for (Billing billing : billingList) {
                            String paymentClass = billing.getPaymentStatus().toLowerCase();
                %>
                    <tr>
                        <td><%= billing.getBillId() %></td>
                        <td><%= billing.getBookingId() %></td>
                        <td><%= billing.getCustomerName() %></td>
                        <td><%= billing.getCustomerPhone() %></td>
                        <td><%= billing.getDriverName() %></td>
                        <td><%= billing.getDriverPhone() %></td>
                        <td><%= billing.getPickupLocation() %></td>
                        <td><%= billing.getDropLocation() %></td>
                        <td><%= billing.getDistance() %></td>
                        <td><%= billing.getStartingMeter() %></td>
                        <td><%= billing.getEndingMeter() %></td>
                        <td>$<%= billing.getFinalAmount() %></td>
                        <td><%= billing.getPaymentMethod() %></td>
                        <td>
                            <span class="payment-badge <%= paymentClass %>">
                                <%= billing.getPaymentStatus() %>
                            </span>
                        </td>
                        <td><%= billing.getBillDate() %></td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="15" class="no-data">No billing records found.</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <span>&copy; 2025 Mega City Cab. All rights reserved.</span>
        </div>
    </footer>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>