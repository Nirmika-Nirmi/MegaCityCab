<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Confirmation</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #333;
        }

        /* ======= Container ======= */
        .container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        /* ======= Header ======= */
        h1 {
            text-align: center;
            font-size: 28px;
            font-weight: 600;
            color: #444;
            margin-bottom: 20px;
        }

        /* ======= Payment Details ======= */
        .payment-details p {
            margin-bottom: 10px;
            font-size: 16px;
            color: #555;
        }

        .payment-details p strong {
            color: #444;
        }

        /* ======= Button Styles ======= */
        .btn {
            width: 100%;
            padding: 10px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            font-weight: 500;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0px 5px 15px rgba(102, 126, 234, 0.4);
        }

        /* ======= Responsive Design ======= */
        @media (max-width: 768px) {
            .container {
                margin: 10px;
                padding: 15px;
            }

            h1 {
                font-size: 24px;
            }

            .payment-details p {
                font-size: 14px;
            }

            .btn {
                padding: 8px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Payment Details</h1>

        <!-- Payment Details -->
        <div class="payment-details">
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
            <button type="submit" class="btn">Confirm Payment</button>
        </form>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>