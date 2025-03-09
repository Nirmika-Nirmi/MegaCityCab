<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Bean.Booking, Dao.BookingDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>My Bookings</h1>
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
                    out.println("<p class='text-center'>No bookings found.</p>");
                } else {
        %>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Booking ID</th>
                                <th>Pickup Location</th>
                                <th>Drop Location</th>
                                <th>Status</th>
                                <th>Fare</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Booking booking : bookings) {
                            %>
                                <tr>
                                    <td><%= booking.getBookingId() %></td>
                                    <td><%= booking.getPickupLocation() %></td>
                                    <td><%= booking.getDropLocation() %></td>
                                    <td><%= booking.getStatus() %></td>
                                    <td>$<%= booking.getFare() %></td>
                                    <td><%= booking.getBookingDate() %></td>
                                </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
        <%
                }
            }
        %>
    </div>
</body>
</html>