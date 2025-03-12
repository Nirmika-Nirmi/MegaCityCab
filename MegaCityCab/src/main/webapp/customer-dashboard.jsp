<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List, Bean.Driver, Dao.DriverDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
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
        .dashboard-content {
            padding: 20px;
            margin: 20px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .dashboard-content h3 {
            margin-top: 0;
        }
        .profile-section {
            margin-top: 20px;
        }
        .footer {
            background-color: #2c3e50;
            color: white;
            text-align: center;
            padding: 10px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        .driver-list {
            margin-top: 20px;
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
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header bg-dark text-white text-center py-3">
        <h1>Welcome, <c:out value="${sessionScope.fullName != null ? sessionScope.fullName : 'Guest'}" /></h1>
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
        <a class="nav-link" href="viewBookings.jsp">View Bookings</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="customerDriversList.jsp">Driver List</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="PaymentHistoryServlet">Payment History</a> <!-- Link to Payment History -->
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

    <!-- Dashboard Content -->
    <div class="container mt-4">
        <div class="card">
            <div class="card-header bg-info text-white">
                <h3>Customer Dashboard</h3>
            </div>
            <div class="card-body">
                <p class="lead">Welcome to your personal dashboard! Here you can manage your bookings, update your profile, and more.</p>

                <!-- Profile Information -->
                <div class="profile-section mb-4">
                    <h4>Profile Information</h4>
                    <div class="list-group">
                        <div class="list-group-item">
                            <strong>Full Name:</strong> <c:out value="${sessionScope.fullName != null ? sessionScope.fullName : 'Not Available'}" />
                        </div>
                        <div class="list-group-item">
                            <strong>Email:</strong> <c:out value="${sessionScope.email != null ? sessionScope.email : 'Not Available'}" />
                        </div>
                        <div class="list-group-item">
                            <strong>Phone:</strong> <c:out value="${sessionScope.phone != null ? sessionScope.phone : 'Not Available'}" />
                        </div>
                    </div>
                </div>

                <!-- Booking Information -->
                <div class="bookings-section">
                    <h4>Booking Information</h4>
                    <div class="alert alert-info">
                        <strong>Upcoming Bookings:</strong> <c:out value="${sessionScope.upcomingBookingsCount != null ? sessionScope.upcomingBookingsCount : 0}" /> bookings.
                    </div>
                </div>
            </div>
        </div>
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