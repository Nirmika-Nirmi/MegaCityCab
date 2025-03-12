<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Bean.Billing, Dao.DriverDAO, java.text.DecimalFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Earnings History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #343a40;
        }
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
            background-color: #17a2b8;
            color: white;
        }
        .table tbody tr:hover {
            background-color: #f1f1f1;
        }
        .alert {
            margin-bottom: 20px;
        }
        .total-earnings {
            font-size: 1.2em;
            font-weight: bold;
            margin-bottom: 20px;
            color: #28a745;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Earnings History</h1>

        <%
            // Retrieve driver ID from session
            Integer driverId = (Integer) session.getAttribute("driverId");
            if (driverId == null) {
                out.println("<p class='alert alert-danger'>Driver ID not found in session. Please <a href='driverLogin.jsp'>log in again</a>.</p>");
            } else {
                // Fetch earnings history for the driver
                DriverDAO driverDAO = new DriverDAO();
                List<Billing> earnings = driverDAO.getEarningsHistory(driverId);

                if (earnings.isEmpty()) {
                    out.println("<p class='alert alert-info'>No earnings found.</p>");
                } else {
                    // Calculate total earnings
                    double totalEarnings = 0;
                    for (Billing billing : earnings) {
                        totalEarnings += billing.getFinalAmount();
                    }
                    DecimalFormat df = new DecimalFormat("#.00");
        %>
                    <!-- Total Earnings Summary -->
                    <div class="total-earnings">
                        Total Earnings: $<%= df.format(totalEarnings) %>
                    </div>

                    <!-- Earnings Table -->
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Bill Number</th>
                                <th>Customer Name</th>
                                <th>Customer Phone</th>
                                <th>Pickup Location</th>
                                <th>Drop Location</th>
                                <th>Amount</th>
                                <th>Payment Method</th>
                                <th>Status</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Billing billing : earnings) {
                            %>
                                <tr>
                                    <td><%= billing.getBillNumber() %></td>
                                    <td><%= billing.getCustomerName() %></td>
                                    <td><%= billing.getCustomerPhone() %></td>
                                    <td><%= billing.getPickupLocation() %></td>
                                    <td><%= billing.getDropLocation() %></td>
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
            }
        %>
    </div>
</body>
</html>