<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Bean.Driver, Dao.DriverDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver List</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .header {
            background-color: #2c3e50;
            color: white;
            padding: 10px 20px;
            text-align: center;
        }
        .navbar {
            padding: 15px;
            background-color: #34495e;
            color: white;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            margin-right: 20px;
        }
        .navbar a:hover {
            text-decoration: underline;
        }
        .driver-list {
            margin: 20px;
            padding: 20px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .driver-list table {
            width: 100%;
            border-collapse: collapse;
        }
        .driver-list th, .driver-list td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .driver-list th {
            background-color: #f2f2f2;
        }
        .btn {
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header bg-dark text-white text-center py-3">
        <h1>Available Drivers</h1>
    </div>

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Mega City Cab</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="customerDashboard.jsp">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="view-bookings.jsp">View Bookings</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="customerDriversList.jsp">Driver List</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="edit-profile.jsp">Edit Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" onclick="confirmLogout()">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Driver List -->
    <div class="driver-list">
        <%
            DriverDAO driverDAO = new DriverDAO();
            List<Driver> drivers = driverDAO.getAvailableDrivers();
        %>
        <table>
            <tr>
                <th>Driver Name</th>
                <th>Email</th>
                <th>Phone Number</th>
                <th>License Number</th>
                <th>Car Model</th>
                <th>Plate Number</th>
                <th>Fuel Type</th>
                <th>AC</th>
                <th>GPS</th>
                <th>Rating</th>
                <th>Action</th>
            </tr>
            <% for (Driver driver : drivers) { %>
            <tr>
                <td><%= driver.getFullName() %></td>
                <td><%= driver.getEmail() %></td>
                <td><%= driver.getPhoneNumber() %></td>
                <td><%= driver.getLicenseNumber() %></td>
                <td><%= driver.getCar().getModel() %></td>
                <td><%= driver.getCar().getPlateNumber() %></td>
                <td><%= driver.getCar().getFuelType() %></td>
                <td><%= driver.getCar().isAc() ? "Yes" : "No" %></td>
                <td><%= driver.getCar().isGps() ? "Yes" : "No" %></td>
                <td><%= driver.getAverageRating() %></td>
                <td>
                    <a href="bookCab.jsp?driverId=<%= driver.getDriverId() %>" class="btn btn-primary btn-sm">Book Now</a>
                </td>
            </tr>
            <% } %>
        </table>
    </div>

    <!-- Footer -->
    <footer class="footer mt-auto py-3 bg-dark text-white text-center">
        <div class="container">
            <span>&copy; 2023 Mega City Cab. All rights reserved.</span>
        </div>
    </footer>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script>
        function confirmLogout() {
            if (confirm("Are you sure you want to logout?")) {
                window.location.href = "logout.jsp";
            }
        }
    </script>
</body>
</html>