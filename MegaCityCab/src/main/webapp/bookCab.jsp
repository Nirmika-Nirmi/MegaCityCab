<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Cab</title>
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
        .booking-form {
            margin: 20px;
            padding: 20px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
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
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header bg-dark text-white text-center py-3">
        <h1>Book a Cab</h1>
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
                        <a class="nav-link" href="customerDriversList.jsp">Driver List</a>
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

    <!-- Booking Form -->
    <div class="booking-form">
        <form action="BookCabServlet" method="post">
            <input type="hidden" name="driverId" value="<%= request.getParameter("driverId") %>">
            <div class="mb-3">
                <label for="pickupLocation" class="form-label">Pickup Location</label>
                <input type="text" class="form-control" id="pickupLocation" name="pickupLocation" required>
            </div>
            <div class="mb-3">
                <label for="dropLocation" class="form-label">Drop Location</label>
                <input type="text" class="form-control" id="dropLocation" name="dropLocation" required>
            </div>
            <div class="mb-3">
                 <label for="pickupTime" class="form-label">Pickup Date and Time</label>
                 <input type="datetime-local" class="form-control" id="pickupTime" name="pickupTime" required>
            </div>
            <div class="mb-3">
                <label for="numPassengers" class="form-label">Number of Passengers</label>
                <input type="number" class="form-control" id="numPassengers" name="numPassengers" min="1" max="5" required>
            </div>
            <div class="mb-3">
                <label for="paymentMethod" class="form-label">Payment Method</label>
                <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                    <option value="">Select Payment Method</option>
                    <option value="Cash">Cash</option>
                    <option value="Card">Card</option>

                </select>
            </div>
            <div class="mb-3">
                <label for="specialRequests" class="form-label">Special Requests</label>
                <textarea class="form-control" id="specialRequests" name="specialRequests" rows="3"></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Book Now</button>
        </form>
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