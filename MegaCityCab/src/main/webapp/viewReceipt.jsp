<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Bean.Billing, Dao.BillingDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Receipt</title>
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
            max-width: 800px;
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
            margin-bottom: 10px;
            font-size: 16px;
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
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Receipt Details</h1>

        <%
            // Retrieve billId from the request
            String billIdParam = request.getParameter("billId");
            if (billIdParam == null || billIdParam.isEmpty()) {
        %>
                <div class="alert alert-danger">
                    Bill ID not found. Please go back and try again.
                </div>
        <%
            } else {
                int billId = Integer.parseInt(billIdParam);

                // Fetch billing details using the billId
                BillingDAO billingDAO = new BillingDAO();
                Billing billing = billingDAO.getBillByBookingId(billId);

                if (billing == null) {
        %>
                    <div class="alert alert-danger">
                        Invalid bill ID. Please go back and try again.
                    </div>
        <%
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

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>