<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Bean.Booking, Dao.BookingDAO, java.sql.Timestamp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enter Meter Values</title>
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

        /* ======= Form Styles ======= */
        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            font-weight: 500;
            color: #555;
            font-size: 14px;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            border-color: #667eea;
            outline: none;
        }

        .form-control[readonly] {
            background-color: #f8f9fa;
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

            .form-control {
                padding: 8px;
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Enter Meter Values</h1>

        <%
            // Retrieve bookingId from the request
            String bookingIdParam = request.getParameter("bookingId");
            if (bookingIdParam == null || bookingIdParam.isEmpty()) {
        %>
                <div class="alert alert-danger">
                    Booking ID not found. Please go back and try again.
                </div>
        <%
            } else {
                int bookingId = 0;
                try {
                    bookingId = Integer.parseInt(bookingIdParam);
                } catch (NumberFormatException e) {
        %>
                    <div class="alert alert-danger">
                        Invalid Booking ID. Please go back and try again.
                    </div>
        <%
                    return; // Stop further execution
                }

                // Fetch ride details using the bookingId
                BookingDAO bookingDAO = new BookingDAO();
                Booking booking = bookingDAO.getBookingById(bookingId);

                if (booking == null) {
        %>
                    <div class="alert alert-danger">
                        No booking found for the provided ID. Please go back and try again.
                    </div>
        <%
                } else {
                    // Fetch additional details for the booking
                    String customerName = bookingDAO.getCustomerNameByBookingId(bookingId);
                    String customerPhone = bookingDAO.getCustomerPhoneByBookingId(bookingId);
                    String pickupLocation = booking.getPickupLocation();
                    String dropLocation = booking.getDropLocation();
                    String paymentMethod = booking.getPaymentMethod(); // Fetch payment method

                    // Debug log
                    System.out.println("Payment Method from Database: " + paymentMethod);
        %>
                    <form action="CalculateBillServlet" method="post">
                        <!-- Hidden fields for bookingId and other details -->
                        <input type="hidden" name="bookingId" value="<%= bookingId %>" />
                        <input type="hidden" name="customerName" value="<%= customerName %>" />
                        <input type="hidden" name="customerPhone" value="<%= customerPhone %>" />
                        <input type="hidden" name="pickupLocation" value="<%= pickupLocation %>" />
                        <input type="hidden" name="dropLocation" value="<%= dropLocation %>" />
                        <input type="hidden" name="paymentMethod" value="<%= paymentMethod %>" />

                        <!-- Display ride details -->
                        <div class="form-group">
                            <label>Customer Name:</label>
                            <input type="text" class="form-control" value="<%= customerName %>" readonly />
                        </div>
                        <div class="form-group">
                            <label>Customer Phone:</label>
                            <input type="text" class="form-control" value="<%= customerPhone %>" readonly />
                        </div>
                        <div class="form-group">
                            <label>Pickup Location:</label>
                            <input type="text" class="form-control" value="<%= pickupLocation %>" readonly />
                        </div>
                        <div class="form-group">
                            <label>Drop Location:</label>
                            <input type="text" class="form-control" value="<%= dropLocation %>" readonly />
                        </div>
                        <div class="form-group">
                            <label>Payment Method:</label>
                            <input type="text" class="form-control" value="<%= paymentMethod != null ? paymentMethod : "Not Specified" %>" readonly />
                        </div>

                        <!-- Input fields for meter values -->
                        <div class="form-group">
                            <label for="startingMeter">Starting Meter (KM):</label>
                            <input type="number" step="0.01" name="startingMeter" id="startingMeter" class="form-control" required />
                        </div>
                        <div class="form-group">
                            <label for="endingMeter">Ending Meter (KM):</label>
                            <input type="number" step="0.01" name="endingMeter" id="endingMeter" class="form-control" required />
                        </div>

                        <button type="submit" class="btn">Calculate Bill</button>
                    </form>
        <%
                }
            }
        %>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>