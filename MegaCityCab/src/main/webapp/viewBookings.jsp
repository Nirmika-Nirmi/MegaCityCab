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
                                <th>Driver Name</th>
                                <th>Driver Phone</th>
                                <th>Status</th>
                                <th>Fare</th>
                                <th>Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Booking booking : bookings) {
                                    String driverName = bookingDAO.getDriverNameByBookingId(booking.getBookingId());
                                    String driverPhone = bookingDAO.getDriverPhoneByBookingId(booking.getBookingId());
                            %>
                                <tr>
                                    <td><%= booking.getBookingId() %></td>
                                    <td><%= booking.getPickupLocation() %></td>
                                    <td><%= booking.getDropLocation() %></td>
                                    <td><%= driverName != null ? driverName : "Not Assigned" %></td>
                                    <td><%= driverPhone != null ? driverPhone : "Not Assigned" %></td>
                                    <td><%= booking.getStatus() %></td>
                                    <td>$<%= booking.getFare() %></td>
                                    <td><%= booking.getBookingDate() %></td>
                                    <td>
                                        <% if (booking.getStatus().equals("Pending")) { %>
                                            <!-- Button to trigger the cancellation -->
                                            <form action="CancelBookingServlet" method="post" style="display: inline;">
                                                <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                                                <button type="submit" class="btn btn-danger btn-sm">Cancel Booking</button>
                                            </form>
                                        <% } %>
                                    </td>
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

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>