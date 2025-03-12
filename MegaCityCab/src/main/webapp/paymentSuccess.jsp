<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Success</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>Payment Successful</h1>

        <%
            // Retrieve parameters from the request
            String bookingId = request.getParameter("bookingId");
            String customerName = request.getParameter("customerName");
            String customerPhone = request.getParameter("customerPhone");
            String pickupLocation = request.getParameter("pickupLocation");
            String dropLocation = request.getParameter("dropLocation");
            String distance = request.getParameter("distance");
            String startingMeter = request.getParameter("startingMeter");
            String endingMeter = request.getParameter("endingMeter");
            String finalAmount = request.getParameter("finalAmount");
            String paymentMethod = request.getParameter("paymentMethod");

            if (bookingId == null || bookingId.isEmpty()) {
                out.println("<p class='alert alert-danger'>Booking ID not found. Please go back and try again.</p>");
            } else {
        %>
                <div class="card">
                    <div class="card-header">
                        <h3>Receipt Details</h3>
                    </div>
                    <div class="card-body">
                        <p><strong>Customer Name:</strong> <%= customerName %></p>
                        <p><strong>Customer Phone:</strong> <%= customerPhone %></p>
                        <p><strong>Pickup Location:</strong> <%= pickupLocation %></p>
                        <p><strong>Drop Location:</strong> <%= dropLocation %></p>
                        <p><strong>Distance:</strong> <%= distance %> KM</p>
                        <p><strong>Starting Meter:</strong> <%= startingMeter %> KM</p>
                        <p><strong>Ending Meter:</strong> <%= endingMeter %> KM</p>
                        <p><strong>Fare:</strong> $<%= finalAmount %></p>
                        <p><strong>Payment Method:</strong> <%= paymentMethod %></p>
                        <p><strong>Payment Status:</strong> Paid</p>
                    </div>
                </div>
        <%
            }
        %>
    </div>
</body>
</html>