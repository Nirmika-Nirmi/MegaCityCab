<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Bean.Billing, java.text.DecimalFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment History</title>
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

        /* ======= Container ======= */
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        /* ======= Table Styles ======= */
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .table th, .table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table th {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            font-weight: 500;
        }

        .table tbody tr:hover {
            background-color: rgba(102, 126, 234, 0.05);
        }

        /* ======= Alert Styles ======= */
        .alert {
            padding: 12px;
            border-radius: 6px;
            font-size: 14px;
            margin-bottom: 20px;
        }

        .alert-info {
            background-color: #e9f5ff;
            border-color: #b8e2ff;
            color: #31708f;
        }

        /* ======= Total Earnings ======= */
        .total-earnings {
            font-size: 1.2em;
            font-weight: 600;
            margin-bottom: 20px;
            color: #28a745;
            text-align: center;
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
                margin: 5px 0;
                width: 100%;
                text-align: center;
            }

            .container {
                margin: 10px;
                padding: 15px;
            }

            h1 {
                font-size: 24px;
            }

            .table th, .table td {
                padding: 8px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        <h1>Payment History</h1>
    </header>

    <!-- Navigation Bar -->
    <nav class="navbar">
        <a href="customer-dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
        <a href="viewBookings.jsp"><i class="fas fa-calendar-alt"></i> View Bookings</a>
        <a href="customerDriversList.jsp"><i class="fas fa-users"></i> Driver List</a>
        <a href="PaymentHistoryServlet"><i class="fas fa-history"></i> Payment History</a>
        <a href="submitFeedback.jsp"><i class="fas fa-comments"></i> Feedback</a>
        <a href="customerProfile.jsp"><i class="fas fa-user-edit"></i> Profile</a>
        <a href="#" onclick="confirmLogout()"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </nav>
    
    <!-- Main Content -->
    <div class="container">
        <%
            List<Billing> paymentHistory = (List<Billing>) request.getAttribute("paymentHistory");
            if (paymentHistory == null || paymentHistory.isEmpty()) {
        %>
                <div class="alert alert-info text-center">
                    No payment history found.
                </div>
        <%
            } else {
                // Calculate total earnings
                double totalEarnings = 0;
                for (Billing billing : paymentHistory) {
                    totalEarnings += billing.getFinalAmount();
                }
                DecimalFormat df = new DecimalFormat("#.00");
        %>
                <!-- Total Earnings Summary -->
                <div class="total-earnings">
                    Total Amount Paid: $<%= df.format(totalEarnings) %>
                </div>

                <!-- Payment History Table -->
                <table class="table">
                    <thead>
                        <tr>
                            <th><i class="fas fa-file-invoice"></i> Bill Number</th>
                            <th><i class="fas fa-user"></i> Customer Name</th>
                            <th><i class="fas fa-map-marker-alt"></i> Pickup Location</th>
                            <th><i class="fas fa-map-marker"></i> Drop Location</th>
                            <th><i class="fas fa-road"></i> Distance (KM)</th>
                            <th><i class="fas fa-dollar-sign"></i> Fare ($)</th>
                            <th><i class="fas fa-credit-card"></i> Payment Method</th>
                            <th><i class="fas fa-check-circle"></i> Status</th>
                            <th><i class="fas fa-calendar"></i> Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Billing billing : paymentHistory) {
                        %>
                                <tr>
                                    <td><%= billing.getBillNumber() %></td>
                                    <td><%= billing.getCustomerName() %></td>
                                    <td><%= billing.getPickupLocation() %></td>
                                    <td><%= billing.getDropLocation() %></td>
                                    <td><%= billing.getDistance() %></td>
                                    <td>$<%= df.format(billing.getFinalAmount()) %></td>
                                    <td><%= billing.getPaymentMethod() %></td>
                                    <td><%= billing.getPaymentStatus() %></td>
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
    <!-- Custom JS -->
    <script>
        function confirmLogout() {
            if (confirm("Are you sure you want to logout?")) {
                window.location.href = "logout.jsp";
            }
        }
    </script>
</body>
</html>