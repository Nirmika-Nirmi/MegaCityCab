<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Bean.Booking, Dao.BookingDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assigned Rides</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: Arial, sans-serif; background-color: #f8f9fa; }
        .container { max-width: 800px; margin: 20px auto; padding: 20px; background-color: #fff; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); }
        .header { text-align: center; margin-bottom: 20px; }
        .ride-item { border: 1px solid #ddd; border-radius: 5px; padding: 15px; margin-bottom: 10px; }
        .btn { margin-right: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Assigned Rides</h1>
        </div>

        <!-- Assigned Rides -->
        <div class="card">
            <div class="card-header">
                <h3>Your Assigned Rides</h3>
            </div>
            <div class="card-body">
                <%
                    // Retrieve driver ID from session
                    Integer driverId = (Integer) session.getAttribute("driverId");
                    if (driverId == null) {
                        out.println("<p>Driver ID not found in session. Please <a href='driverLogin.jsp'>log in again</a>.</p>");
                        return;
                    }

                    // Fetch assigned rides for the driver
                    BookingDAO bookingDAO = new BookingDAO();
                    List<Booking> assignedRides = bookingDAO.getAssignedRides(driverId);

                    if (assignedRides.isEmpty()) {
                %>
                    <p>No rides assigned.</p>
                <%
                    } else {
                        for (Booking ride : assignedRides) {
                %>
                    <div class="ride-item">
                        <p><strong>Ride ID:</strong> <%= ride.getBookingId() %></p>
                        <p><strong>Pickup Location:</strong> <%= ride.getPickupLocation() %></p>
                        <p><strong>Drop Location:</strong> <%= ride.getDropLocation() %></p>
                        <p><strong>Status:</strong> <%= ride.getStatus() %></p>
                        <p><strong>Fare:</strong> $<%= ride.getFare() %></p>
                        <%
                            if (ride.getStatus().equals("Pending")) {
                        %>
                            <a href="${pageContext.request.contextPath}/RideActionServlet?action=accept&bookingId=<%= ride.getBookingId() %>" class="btn btn-success">Accept</a>
                            <a href="${pageContext.request.contextPath}/RideActionServlet?action=reject&bookingId=<%= ride.getBookingId() %>" class="btn btn-danger">Reject</a>
                        <%
                            } else if (ride.getStatus().equals("Confirmed")) {
                        %>
                            <a href="${pageContext.request.contextPath}/RideActionServlet?action=complete&bookingId=<%= ride.getBookingId() %>" class="btn btn-primary">Mark as Completed</a>
                        <%
                            }
                        %>
                    </div>
                <%
                        }
                    }
                %>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>