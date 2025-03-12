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
    <!-- Custom CSS -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .navbar {
            background-color: #343a40; /* Dark navbar */
        }
        .navbar-brand, .navbar-nav .nav-link {
            color: #ffffff !important; /* White text */
        }
        .navbar-nav .nav-link:hover {
            color: #17a2b8 !important; /* Highlight on hover */
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #ffffff;
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
            background-color: #17a2b8; /* Teal header */
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
            background-color: #f8f9fa; /* Light background for ride items */
        }
        .earnings-summary {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .footer {
            text-align: center;
            margin-top: 20px;
            padding: 10px;
            background-color: #343a40; /* Dark footer */
            color: #ffffff;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Mega City Cab</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="driverDashboard.jsp">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="driver-bookings.jsp">View All Rides</a>
                    </li>
                    <li class="nav-item">
                         <a class="nav-link" href="DriverEarningsHistory.jsp">Earnings History</a> 
                   </li>
                    <li class="nav-item">
                        <a class="nav-link" href="driverProfile.jsp">Edit Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
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
    int completedRides = bookingDAO.getCompletedRidesCount(driverId);

    // Debug statements
    out.println("<p>Total Earnings : $" + totalEarnings + "</p>");
    out.println("<p>Completed Rides : " + completedRides + "</p>");
%>
        <p><a href="driverEarningsHistory.jsp" class="btn btn-info">View Earnings History</a></p> <!-- Add this line -->
    </div>
</div>



    <!-- Footer -->
    <div class="footer">
        &copy; 2023 Mega City Cab. All rights reserved.
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>