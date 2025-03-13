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
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        /* ======= General Styles ======= */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f4f7fa, #e8eef7);
            margin: 0;
            padding: 0;
            color: #333;
        }

        /* ======= Header ======= */
        .header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .header h1 {
            margin: 0;
            font-size: 28px;
            font-weight: 600;
        }

        /* ======= Navigation Bar ======= */
        .navbar {
            background: white;
            padding: 10px 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: center;
        }

        .navbar a {
            color: #555;
            padding: 10px 20px;
            margin: 0 5px;
            text-decoration: none;
            font-weight: 500;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .navbar a:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(102, 126, 234, 0.3);
        }

        /* ======= Dashboard Content ======= */
        .dashboard-content {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .dashboard-content h3 {
            margin-top: 0;
            font-size: 24px;
            font-weight: 600;
            color: #444;
        }

        /* ======= Profile Section ======= */
        .profile-section {
            margin-top: 20px;
        }

        .profile-section h4 {
            font-size: 20px;
            font-weight: 500;
            color: #555;
            margin-bottom: 15px;
        }

        .profile-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .profile-card p {
            margin: 10px 0;
            font-size: 16px;
            color: #555;
        }

        .profile-card p strong {
            color: #444;
        }

        /* ======= Bookings Section ======= */
        .bookings-section {
            margin-top: 20px;
        }

        .bookings-section h4 {
            font-size: 20px;
            font-weight: 500;
            color: #555;
            margin-bottom: 15px;
        }

        .bookings-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .bookings-card p {
            margin: 10px 0;
            font-size: 16px;
            color: #555;
        }

        .bookings-card p strong {
            color: #444;
        }

        /* ======= Footer ======= */
        .footer {
            background: #2c3e50; /* Dark blue color to match admin dashboard */
            color: white;
            text-align: center;
            padding: 15px;
            margin-top: 30px;
            font-size: 14px;
        }

        .footer a {
            color: #667eea;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        /* ======= Responsive Design ======= */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                align-items: center;
            }

            .navbar a {
                margin: 5px 0;
                width: 100%;
                text-align: center;
            }

            .dashboard-content {
                margin: 10px;
                padding: 15px;
            }
        }
    </style>
</head>
<body>

    <!-- Header -->
    <div class="header">
        <h1>Welcome, <c:out value="${sessionScope.fullName != null ? sessionScope.fullName : 'Guest'}" /></h1>
    </div>

    <!-- Navigation Bar -->
    <nav class="navbar">
        <a href="customerDashboard.jsp">Dashboard</a>
        <a href="viewBookings.jsp">View Bookings</a>
        <a href="customerDriversList.jsp">Driver List</a>
        <a href="PaymentHistoryServlet">Payment History</a>
        <a href="edit-profile.jsp">Edit Profile</a>
        <a href="#" onclick="confirmLogout()">Logout</a>
    </nav>

    <!-- Dashboard Content -->
    <div class="dashboard-content">
        <h3>Customer Dashboard</h3>

        <!-- Profile Information -->
        <div class="profile-section">
            <h4>Profile Information</h4>
            <div class="profile-card">
                <p><strong>Full Name:</strong> <c:out value="${sessionScope.fullName != null ? sessionScope.fullName : 'Not Available'}" /></p>
                <p><strong>Email:</strong> <c:out value="${sessionScope.email != null ? sessionScope.email : 'Not Available'}" /></p>
                <p><strong>Phone:</strong> <c:out value="${sessionScope.phone != null ? sessionScope.phone : 'Not Available'}" /></p>
            </div>
        </div>

        <!-- Booking Information -->
        <div class="bookings-section">
            <h4>Booking Information</h4>
            <div class="bookings-card">
                <p><strong>Upcoming Bookings:</strong> <c:out value="${sessionScope.upcomingBookingsCount != null ? sessionScope.upcomingBookingsCount : 0}" /> bookings.</p>
            </div>
        </div>
    </div>



    <!-- Footer -->
    <footer class="footer">
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