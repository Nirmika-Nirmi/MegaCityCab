<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>Payment Confirmation</h1>

        <!-- Debugging: Print all request attributes -->
        <div class="alert alert-info">
            <strong>Debugging:</strong><br>
            bookingId: ${bookingId}<br>
            customerName: ${customerName}<br>
            customerPhone: ${customerPhone}<br>
            pickupLocation: ${pickupLocation}<br>
            dropLocation: ${dropLocation}<br>
            distance: ${distance}<br>
            startingMeter: ${startingMeter}<br>
            endingMeter: ${endingMeter}<br>
            finalAmount: ${finalAmount}<br>
            paymentMethod: ${paymentMethod}<br>
        </div>

        <div class="card">
            <div class="card-header">
                <h3>Payment Details</h3>
            </div>
            <div class="card-body">
                <p><strong>Customer Name:</strong> ${customerName}</p>
                <p><strong>Customer Phone:</strong> ${customerPhone}</p>
                <p><strong>Pickup Location:</strong> ${pickupLocation}</p>
                <p><strong>Drop Location:</strong> ${dropLocation}</p>
                <p><strong>Distance:</strong> ${distance} KM</p>
                <p><strong>Starting Meter:</strong> ${startingMeter} KM</p>
                <p><strong>Ending Meter:</strong> ${endingMeter} KM</p>
                <p><strong>Fare:</strong> $${finalAmount}</p>
                <p><strong>Payment Method:</strong> ${paymentMethod}</p>
            </div>
        </div>

        <form action="ConfirmPaymentServlet" method="post" class="mt-3">
            <input type="hidden" name="bookingId" value="${bookingId}" />
            <input type="hidden" name="finalAmount" value="${finalAmount}" />
            <input type="hidden" name="paymentMethod" value="${paymentMethod}" />
            <button type="submit" class="btn btn-success">Confirm Payment</button>
        </form>
    </div>
</body>
</html>