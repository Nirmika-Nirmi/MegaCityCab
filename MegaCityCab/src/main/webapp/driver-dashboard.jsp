<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Bean.Driver, Bean.Car, Bean.Booking, Dao.DriverDAO, Dao.CarDao, Dao.BookingDAO, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .card-header {
            background-color: #17a2b8;
            color: white;
            border-radius: 10px 10px 0 0;
            padding: 15px;
        }
        .card-body {
            padding: 20px;
        }
        .btn {
            margin-right: 10px;
        }
        .driver-details p {
            margin-bottom: 10px;
        }
        .ride-item {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 10px;
        }
        .earnings-summary {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1>Driver Dashboard</h1>
        </div>

        <!-- Driver Details -->
        <div class="card">
            <div class="card-header">
                <h3>Driver Details</h3>
            </div>
            <div class="card-body driver-details">
                <%
                    // Retrieve driver ID from session
                    Integer driverId = (Integer) session.getAttribute("driverId");
                    if (driverId == null) {
                        response.sendRedirect("driverLogin.jsp"); // Redirect to login if session is invalid
                        return;
                    }

                    // Fetch driver details
                    DriverDAO driverDAO = new DriverDAO();
                    Driver driver = driverDAO.getDriverById(driverId);

                    if (driver != null) {
                %>
                    <p><strong>Name:</strong> <%= driver.getFullName() %></p>
                    <p><strong>Email:</strong> <%= driver.getEmail() %></p>
                    <p><strong>Phone:</strong> <%= driver.getPhoneNumber() %></p>
                    <p><strong>License Number:</strong> <%= driver.getLicenseNumber() %></p>
                    <p><strong>Status:</strong> <%= driver.getStatus() %></p>
                <%
                    } else {
                        out.println("<p>Driver details not found.</p>");
                    }
                %>
            </div>
        </div>

        <!-- Car Details -->
        <div class="card">
            <div class="card-header">
                <h3>Car Details</h3>
            </div>
            <div class="card-body">
                <%
    CarDao carDao = new CarDao();
    Car car = carDao.getCarByDriverId(driverId);

    if (car != null) {
%>
    <p><strong>Model:</strong> <%= car.getModel() %></p>
    <p><strong>Plate Number:</strong> <%= car.getPlateNumber() %></p>
    <p><strong>Capacity:</strong> <%= car.getCapacity() %></p>
    <p><strong>Fuel Type:</strong> <%= car.getFuelType() %></p>
    <p><strong>AC:</strong> <%= car.isAc() ? "Yes" : "No" %></p>
    <p><strong>GPS:</strong> <%= car.isGps() ? "Yes" : "No" %></p>
<%
    } else {
        out.println("<p>No car assigned.</p>");
    }
%>
            </div>
        </div>

        <!-- Earnings Summary -->
        <div class="card">
            <div class="card-header">
                <h3>Earnings Summary</h3>
            </div>
            <div class="card-body earnings-summary">
                <%
                    BookingDAO bookingDAO = new BookingDAO();
                    double totalEarnings = bookingDAO.getTotalEarnings(driverId);
                %>
                <p><strong>Total Earnings:</strong> $<%= String.format("%.2f", totalEarnings) %></p>
                <p><strong>Completed Rides:</strong> <%= bookingDAO.getCompletedRidesCount(driverId) %></p>
            </div>
        </div>

        <!-- Assigned Rides -->
        <div class="card">
            <div class="card-header">
                <h3>Assigned Rides</h3>
            </div>
            <div class="card-body">
                <%
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
                        <%
                            if (ride.getStatus().equals("Pending")) {
                        %>
                            <form action="${pageContext.request.contextPath}/RideActionServlet" method="post" style="display: inline;">
                                <input type="hidden" name="bookingId" value="<%= ride.getBookingId() %>" />
                                <button type="submit" name="action" value="accept" class="btn btn-success">Accept</button>
                                <button type="submit" name="action" value="reject" class="btn btn-danger">Reject</button>
                            </form>
                        <%
                            } else if (ride.getStatus().equals("Confirmed")) {
                        %>
                            <form action="${pageContext.request.contextPath}/CompleteRideServlet" method="post" style="display: inline;">
                                <input type="hidden" name="bookingId" value="<%= ride.getBookingId() %>" />
                                <button type="submit" class="btn btn-primary">Complete Ride</button>
                            </form>
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

        <!-- Navigation Links -->
        <div class="text-center">
            <a href="driver-bookings.jsp" class="btn btn-primary">View All Rides</a>
            <a href="driverProfile.jsp" class="btn btn-secondary">Edit Profile</a>
            <a href="logout.jsp" class="btn btn-danger">Logout</a>
        </div>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>