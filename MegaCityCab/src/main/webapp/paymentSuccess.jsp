<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Successful</title>
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
            margin-bottom: 20px;
            font-size: 28px;
            font-weight: 600;
            color: #444;
        }

        /* ======= Card Styles ======= */
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border-radius: 10px 10px 0 0;
            padding: 15px;
        }

        .card-header h3 {
            margin: 0;
            font-size: 22px;
            font-weight: 500;
        }

        .card-body {
            padding: 20px;
        }

        .card-body p {
            margin: 10px 0;
            font-size: 14px;
            color: #555;
        }

        .card-body p strong {
            color: #444;
        }

        /* ======= Alert Styles ======= */
        .alert {
            padding: 12px;
            border-radius: 6px;
            font-size: 14px;
            margin-bottom: 20px;
        }

        .alert-danger {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
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

            .card-header h3 {
                font-size: 20px;
            }

            .card-body p {
                font-size: 13px;
            }
        }
    </style>
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
        %>
                <div class="alert alert-danger">
                    Booking ID not found. Please go back and try again.
                </div>
        <%
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

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>