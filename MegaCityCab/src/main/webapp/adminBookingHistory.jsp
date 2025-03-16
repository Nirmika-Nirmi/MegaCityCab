<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Bean.Billing, java.text.DecimalFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Billing History</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
        }

        /* ======= Header ======= */
        header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        header h1 {
            margin: 0;
            font-size: 28px;
            font-weight: 600;
        }

        /* ======= Navigation Bar ======= */
        nav {
            background: white;
            padding: 10px 20px;
            display: flex;
            justify-content: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        nav a {
            color: #555;
            padding: 10px 20px;
            margin: 0 5px;
            text-decoration: none;
            font-weight: 500;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        nav a:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(102, 126, 234, 0.3);
        }

        /* ======= Main Content ======= */
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        /* ======= Total Revenue Summary ======= */
        .total-revenue {
            
           text-color:black;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .total-revenue h3 {
            margin: 0;
            font-size: 24px;
            font-weight: 500;
        }

        /* ======= Table Styles ======= */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            font-weight: 500;
        }

        tr:hover {
            background-color: rgba(102, 126, 234, 0.05);
        }

        /* ======= Payment Status Badges ======= */
        .payment-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
            display: inline-block;
        }

        .payment-badge.paid {
            background: linear-gradient(135deg, #28a745, #218838);
            color: white;
        }

        .payment-badge.unpaid {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }

        .payment-badge.pending {
            background: linear-gradient(135deg, #ffc107, #e0a800);
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
        footer {
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 15px;
            margin-top: 30px;
            font-size: 14px;
        }

        footer a {
            color: #667eea;
            text-decoration: none;
        }

        footer a:hover {
            text-decoration: underline;
        }

        /* ======= Responsive Design ======= */
        @media (max-width: 768px) {
            nav {
                flex-direction: column;
                align-items: center;
            }

            nav a {
                width: 100%;
                text-align: center;
                margin: 5px 0;
            }

            table {
                font-size: 14px;
            }

            th, td {
                padding: 8px;
            }
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        <h1>Admin - Billing History</h1>
    </header>

    <!-- Navigation Bar -->
    <nav>
        <a href="admin-dashboard.jsp"><i class="fas fa-home"></i> Home</a>
        <a href="viewDrivers.jsp"><i class="fas fa-users"></i> View Drivers</a>
        <a href="viewCustomers.jsp"><i class="fas fa-user-friends"></i> View Customers</a>
        <a href="AdminBookingHistoryServlet"><i class="fas fa-calendar-alt"></i> Manage Bookings</a>
        <a href="AdminViewCarsServlet"><i class="fas fa-car"></i> Manage Cars</a>
        <a href="adminFeedback.jsp"><i class="fas fa-comments"></i> Reports</a>
        <a href="adminProfile.jsp"><i class="fas fa-user-cog"></i> Profile</a>
        <a href="logout.jsp" style="color: #ff4444;"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <%
            List<Billing> billingList = (List<Billing>) request.getAttribute("billingList");
            if (billingList == null) {
        %>
                <div class="alert alert-danger">
                    <strong>Error:</strong> The billingList attribute is null. Check if the servlet is setting the attribute correctly.
                </div>
        <%
            } else if (billingList.isEmpty()) {
        %>
                <div class="alert alert-info">
                    No billing records found in the database.
                </div>
        <%
            } else {
                // Calculate total revenue
                double totalRevenue = 0;
                for (Billing billing : billingList) {
                    totalRevenue += billing.getFinalAmount();
                }
                DecimalFormat df = new DecimalFormat("#.00");
        %>
                <!-- Total Revenue Summary -->
                <div class="total-revenue">
                    <h3>Total Revenue: $<%= df.format(totalRevenue) %></h3>
                </div>

                <!-- Billing History Table -->
                <table>
                    <thead>
                        <tr>
                            <th>Bill ID</th>
                            <th>Booking ID</th>
                            <th>Customer Name</th>
                            <th>Customer Phone</th>
                            <th>Driver Name</th>
                            <th>Pickup Location</th>
                            <th>Drop Location</th>
                            <th>Distance (KM)</th>
                            <th>Fare ($)</th>
                            <th>Payment Method</th>
                            <th>Status</th>
                            <th>Bill Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Billing billing : billingList) {
                        %>
                                <tr>
                                    <td><%= billing.getBillId() %></td>
                                    <td><%= billing.getBookingId() %></td>
                                    <td><%= billing.getCustomerName() %></td>
                                    <td><%= billing.getCustomerPhone() %></td>
                                    <td><%= billing.getDriverName() %></td>
                                    <td><%= billing.getPickupLocation() %></td>
                                    <td><%= billing.getDropLocation() %></td>
                                    <td><%= billing.getDistance() %></td>
                                    <td>$<%= df.format(billing.getFinalAmount()) %></td>
                                    <td><%= billing.getPaymentMethod() %></td>
                                    <td>
                                        <span class="payment-badge <%= billing.getPaymentStatus().toLowerCase() %>">
                                            <%= billing.getPaymentStatus() %>
                                        </span>
                                    </td>
                                    <td><%= billing.getBillDate() %></td>
                                </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
        <%
            }
        %>
    </div>

    <!-- Footer -->
    <footer>
        &copy; 2023 Mega City Cab. All rights reserved. | <a href="#">Privacy Policy</a>
    </footer>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>