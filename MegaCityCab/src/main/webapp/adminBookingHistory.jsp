<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Bean.Booking, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Booking and Payment History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1 class="my-4">Booking and Payment History</h1>

        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>Booking ID</th>
                    <th>Customer ID</th>
                    <th>Driver ID</th>
                    <th>Pickup Location</th>
                    <th>Drop Location</th>
                    <th>Booking Date</th>
                    <th>Status</th>
                    <th>Fare</th>
                    <th>Payment Status</th>
                    <th>Payment Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
                    if (bookings != null && !bookings.isEmpty()) {
                        for (Booking booking : bookings) {
                %>
                            <tr>
                                <td><%= booking.getBookingId() %></td>
                                <td><%= booking.getCustomerId() %></td>
                                <td><%= booking.getDriverId() %></td>
                                <td><%= booking.getPickupLocation() %></td>
                                <td><%= booking.getDropLocation() %></td>
                                <td><%= booking.getBookingDate() %></td>
                                <td><%= booking.getStatus() %></td>
                                <td>$<%= booking.getFare() %></td>
                                <td><%= booking.getBilling().getPaymentStatus() %></td>
                                <td><%= booking.getBilling().getBillDate() %></td>
                            </tr>
                <%
                        }
                    } else {
                %>
                        <tr>
                            <td colspan="10" class="text-center">No bookings found.</td>
                        </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>