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
        <h1>Payment Details</h1><br>

        <!-- Payment Details -->
        <div class="mb-3">
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

        <!-- Confirmation Button -->
<form action="ConfirmPaymentServlet" method="post">
    <input type="hidden" name="bookingId" value="${bookingId}" />
    <input type="hidden" name="customerName" value="${customerName}" />
    <input type="hidden" name="customerPhone" value="${customerPhone}" />
    <input type="hidden" name="pickupLocation" value="${pickupLocation}" />
    <input type="hidden" name="dropLocation" value="${dropLocation}" />
    <input type="hidden" name="startingMeter" value="${startingMeter}" />
    <input type="hidden" name="endingMeter" value="${endingMeter}" />
    <input type="hidden" name="distance" value="${distance}" />
    <input type="hidden" name="finalAmount" value="${finalAmount}" />
    <input type="hidden" name="paymentMethod" value="${paymentMethod}" />
    <button type="submit" class="btn btn-primary">Confirm Payment</button>
</form>
    </div>
</body>
</html>