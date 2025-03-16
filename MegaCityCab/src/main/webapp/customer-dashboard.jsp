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
    <!-- Font Awesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
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
            display: flex;
            align-items: center;
        }

        .profile-card img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            margin-right: 20px;
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

        /* ======= Car Booking Form ======= */
        .booking-form {
            margin-top: 20px;
        }

        .booking-form h4 {
            font-size: 20px;
            font-weight: 500;
            color: #555;
            margin-bottom: 15px;
        }

        .booking-form .form-group {
            margin-bottom: 15px;
        }

        .booking-form .form-group label {
            font-weight: 500;
            color: #555;
        }

        .booking-form .form-group input,
        .booking-form .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .booking-form .form-group input:focus,
        .booking-form .form-group select:focus {
            border-color: #667eea;
            outline: none;
        }

        .booking-form button {
            background: #667eea;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .booking-form button:hover {
            background: #5566c4;
        }

        /* ======= Car Photos Section ======= */
        .car-photos {
            margin-top: 20px;
        }

        .car-photos h4 {
            font-size: 20px;
            font-weight: 500;
            color: #555;
            margin-bottom: 15px;
        }

        .car-photos .car-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .car-photos .car-grid img {
            width: 100%;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .car-photos .car-grid img:hover {
            transform: scale(1.05);
        }

        /* ======= Map Section ======= */
        .map-section {
            margin-top: 20px;
        }

        .map-section h4 {
            font-size: 20px;
            font-weight: 500;
            color: #555;
            margin-bottom: 15px;
        }

        .map-section iframe {
            width: 100%;
            height: 300px;
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        /* ======= Footer ======= */
        .footer {
            background: #2c3e50;
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

            .profile-card {
                flex-direction: column;
                text-align: center;
            }

            .profile-card img {
                margin-right: 0;
                margin-bottom: 15px;
            }

            .car-photos .car-grid {
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
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
        <a href="customer-dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
        <a href="viewBookings.jsp"><i class="fas fa-calendar-alt"></i> View Bookings</a>
        <a href="customerDriversList.jsp"><i class="fas fa-users"></i> Driver List</a>
        <a href="PaymentHistoryServlet"><i class="fas fa-history"></i> Payment History</a>
        <a href="submitFeedback.jsp"><i class="fas fa-comments"></i> Feedback</a>
        <a href="customerProfile.jsp"><i class="fas fa-user-edit"></i> Profile</a>
        <a href="#" onclick="confirmLogout()"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </nav>

    <!-- Dashboard Content -->
    <div class="dashboard-content">
        <h3>Customer Dashboard</h3>

        <!-- Profile Information -->
        <div class="profile-section">
            <h4>Profile Information</h4>
            <div class="profile-card">
                <img src="images.png" alt="Profile Picture">
                <div>
                    <p><strong>Full Name:</strong> <c:out value="${sessionScope.fullName != null ? sessionScope.fullName : 'Not Available'}" /></p>
                    <p><strong>Email:</strong> <c:out value="${sessionScope.email != null ? sessionScope.email : 'Not Available'}" /></p>
                    <p><strong>Phone:</strong> <c:out value="${sessionScope.phone != null ? sessionScope.phone : 'Not Available'}" /></p>
                </div>
            </div>
        </div>

        <!-- Booking Information -->
        <div class="bookings-section">
            <h4>Booking Information</h4>
            <div class="bookings-card">
                <p><strong>Upcoming Bookings:</strong> <c:out value="${sessionScope.upcomingBookingsCount != null ? sessionScope.upcomingBookingsCount : 0}" /> bookings.</p>
            </div>
        </div>



        <!-- Map Section -->
        <div class="map-section">
            <h4>Track Your Ride</h4>
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3153.8354345093747!2d144.9537353153166!3d-37.816279742021665!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x6ad642af0f11fd81%3A0xf577d6a32f8c23c!2sMelbourne%20VIC%2C%20Australia!5e0!3m2!1sen!2sus!4v1625070000000!5m2!1sen!2sus" allowfullscreen></iframe>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <span>&copy; 2025 Mega City Cab. All rights reserved.</span>
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