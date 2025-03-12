<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Bean.Billing" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment History</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
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
    </style>
</head>
<body>
    <div class="container">
        <h1>Payment History</h1>

        <%
            List<Billing> paymentHistory = (List<Billing>) request.getAttribute("paymentHistory");
            if (paymentHistory == null || paymentHistory.isEmpty()) {
        %>
                <p class="alert alert-info text-center">No payment history found.</p>
        <%
            } else {
        %>
                <table class="table">
                    <thead>
                        <tr>
                            <th>Bill Number</th>
                            <th>Customer Name</th>
                            <th>Pickup Location</th>
                            <th>Drop Location</th>
                            <th>Distance (KM)</th>
                            <th>Fare ($)</th>
                            <th>Payment Method</th>
                            <th>Status</th>
                            <th>Date</th>
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
                                    <td><%= billing.getFinalAmount() %></td>
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

    <!-- Bootstrap JS (optional) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>