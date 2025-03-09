<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Bean.Booking, Dao.BookingDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: Arial, sans-serif; background-color: #f8f9fa; }
        .container { max-width: 800px; margin: 20px auto; padding: 20px; background-color: #fff; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); }
        .header { text-align: center; margin-bottom: 20px; }
        .booking-item { border: 1px solid #ddd; border-radius: 5px; padding: 15px; margin-bottom: 10px; }
        .status-pending { color: #ffc107; }
        .status-confirmed { color: #28a745; }
        .status-completed { color: #007bff; }
        .status-cancelled { color: #dc3545; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>My Bookings</h1>
        </div>

        <!-- Bookings List -->
        <div class="bookings-list">
            <%
                // Retrieve customer ID from session
                Integer customerId = (Integer) session.getAttribute("customerId");
                if (customerId == null) {
                    out.println("<p>Customer ID not found in session. Please <a href='customerLogin.jsp'>log in again</a>.</p>");
                } else {
                    // Fetch bookings for the customer
                    BookingDAO bookingDAO = new BookingDAO();
                    List<Booking> bookings = bookingDAO.getBookingsByCustomerId(customerId);

                    if (bookings.isEmpty()) {
                        out.println("<p>No bookings found.</p>");
                    } else {
                        for (Booking booking : bookings) {
            %>
                            <div class="booking-item">
                                <p><strong>Booking ID:</strong> <%= booking.getBookingId() %></p>
                                <p><strong>Pickup Location:</strong> <%= booking.getPickupLocation() %></p>
                                <p><strong>Drop Location:</strong> <%= booking.getDropLocation() %></p>
                                <p><strong>Status:</strong> 
                                    <span class="status-<%= booking.getStatus().toLowerCase() %>">
                                        <%= booking.getStatus() %>
                                    </span>
                                </p>
                                <p><strong>Fare:</strong> $<%= booking.getFare() %></p>
                                <p><strong>Passengers:</strong> <%= booking.getNumPassengers() %></p>
                                <p><strong>Date:</strong> <%= booking.getBookingDate() %></p>
                            </div>
            <%
                        }
                    }
                }
            %>
        </div>

        <!-- Back to Dashboard -->
        <div class="text-center mt-4">
            <a href="customerDashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
        </div>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>