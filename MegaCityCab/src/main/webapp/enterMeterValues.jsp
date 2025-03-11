<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Bean.Booking, Dao.BookingDAO, java.sql.Timestamp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enter Meter Values</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>Enter Meter Values</h1>

        <%
            // Retrieve bookingId from the request
            String bookingIdParam = request.getParameter("bookingId");
            if (bookingIdParam == null || bookingIdParam.isEmpty()) {
                out.println("<p class='alert alert-danger'>Booking ID not found. Please go back and try again.</p>");
            } else {
                int bookingId = Integer.parseInt(bookingIdParam);

                // Fetch ride details using the bookingId
                BookingDAO bookingDAO = new BookingDAO();
                Booking booking = bookingDAO.getBookingById(bookingId);

                if (booking == null) {
                    out.println("<p class='alert alert-danger'>Invalid booking ID. Please go back and try again.</p>");
                } else {
                    // Fetch additional details for the booking
                    String customerName = bookingDAO.getCustomerNameByBookingId(bookingId);
                    String customerPhone = bookingDAO.getCustomerPhoneByBookingId(bookingId);
                    String pickupLocation = booking.getPickupLocation();
                    String dropLocation = booking.getDropLocation();
                    String paymentMethod = booking.getPaymentMethod(); // Fetch payment method
        %>
                    <form action="CalculateBillServlet" method="post">
                        <!-- Hidden fields for bookingId and other details -->
                        <input type="hidden" name="bookingId" value="<%= bookingId %>" />
                        <input type="hidden" name="customerId" value="<%= booking.getCustomerId() %>" />
                        <input type="hidden" name="pickupLocation" value="<%= pickupLocation %>" />
                        <input type="hidden" name="dropLocation" value="<%= dropLocation %>" />
                        <input type="hidden" name="paymentMethod" value="<%= paymentMethod %>" />

                        <!-- Display ride details -->
                        <div class="mb-3">
                            <label class="form-label">Customer Name:</label>
                            <input type="text" class="form-control" value="<%= customerName %>" readonly />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Customer Phone:</label>
                            <input type="text" class="form-control" value="<%= customerPhone %>" readonly />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Pickup Location:</label>
                            <input type="text" class="form-control" value="<%= pickupLocation %>" readonly />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Drop Location:</label>
                            <input type="text" class="form-control" value="<%= dropLocation %>" readonly />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Payment Method:</label>
                            <input type="text" class="form-control" value="<%= paymentMethod %>" readonly />
                        </div>

                        <!-- Input fields for meter values -->
                        <div class="mb-3">
                            <label for="startingMeter" class="form-label">Starting Meter (KM):</label>
                            <input type="number" step="0.01" name="startingMeter" id="startingMeter" class="form-control" required />
                        </div>
                        <div class="mb-3">
                            <label for="endingMeter" class="form-label">Ending Meter (KM):</label>
                            <input type="number" step="0.01" name="endingMeter" id="endingMeter" class="form-control" required />
                        </div>

                        <button type="submit" class="btn btn-primary">Calculate Bill</button>
                    </form>
        <%
                }
            }
        %>
    </div>
</body>
</html>