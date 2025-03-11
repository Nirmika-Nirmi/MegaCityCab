<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Bean.Billing, Dao.BillingDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Receipt</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>Payment Receipt</h1>

        <%
            // Retrieve billId from the request
            String billIdParam = request.getParameter("billId");
            if (billIdParam == null || billIdParam.isEmpty()) {
                out.println("<p class='alert alert-danger'>Bill ID not found. Please go back and try again.</p>");
            } else {
                int billId = Integer.parseInt(billIdParam);

                // Fetch billing details using the billId
                BillingDAO billingDAO = new BillingDAO();
                Billing billing = billingDAO.getBillByBookingId(billId);

                if (billing == null) {
                    out.println("<p class='alert alert-danger'>Invalid bill ID. Please go back and try again.</p>");
                } else {
        %>
                    <div class="card">
                        <div class="card-header">
                            <h3>Receipt Details</h3>
                        </div>
                        <div class="card-body">
                            <p><strong>Bill Number:</strong> <%= billing.getBillNumber() %></p>
                            <p><strong>Customer Name:</strong> <%= billing.getCustomerName() %></p>
                            <p><strong>Customer Phone:</strong> <%= billing.getCustomerPhone() %></p>
                            <p><strong>Pickup Location:</strong> <%= billing.getPickupLocation() %></p>
                            <p><strong>Drop Location:</strong> <%= billing.getDropLocation() %></p>
                            <p><strong>Distance:</strong> <%= billing.getDistance() %> KM</p>
                            <p><strong>Starting Meter:</strong> <%= billing.getStartingMeter() %> KM</p>
                            <p><strong>Ending Meter:</strong> <%= billing.getEndingMeter() %> KM</p>
                            <p><strong>Fare:</strong> $<%= billing.getFinalAmount() %></p>
                            <p><strong>Payment Method:</strong> <%= billing.getPaymentMethod() %></p>
                            <p><strong>Payment Status:</strong> <%= billing.getPaymentStatus() %></p>
                        </div>
                    </div>
        <%
                }
            }
        %>
    </div>
</body>
</html>