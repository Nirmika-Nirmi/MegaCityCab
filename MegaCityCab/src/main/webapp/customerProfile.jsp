<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Bean.CustomerBean" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Customer Profile</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        /* ======= General Styles ======= */
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7fa;
            color: #333;
        }

        /* ======= Header ======= */
        header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        header h1 {
            margin: 0;
            font-size: 28px;
            font-weight: 600;
        }

        /* ======= Navigation Bar ======= */
        nav {
            background: white;
            padding: 10px 20px;
            display: flex;
            justify-content: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        nav a {
            color: #555;
            padding: 10px 20px;
            margin: 0 5px;
            text-decoration: none;
            font-weight: 500;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        nav a:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(102, 126, 234, 0.3);
        }

        /* ======= Form Container ======= */
        .form-container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .form-container h1 {
            font-size: 24px;
            font-weight: 600;
            color: #444;
            margin-bottom: 20px;
            text-align: center;
        }

        .form-container .input-group {
            margin-bottom: 15px;
        }

        .form-container .input-group label {
            display: block;
            font-weight: 500;
            color: #555;
            margin-bottom: 5px;
        }

        .form-container .input-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .form-container .input-group input:focus {
            border-color: #667eea;
            outline: none;
        }

        .form-container .btn {
            width: 100%;
            background: #667eea;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .form-container .btn:hover {
            background: #5566c4;
        }

        /* ======= Footer ======= */
        footer {
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 15px;
            margin-top: 30px;
            font-size: 14px;
        }

        footer a {
            color: #667eea;
            text-decoration: none;
        }

        footer a:hover {
            text-decoration: underline;
        }

        /* ======= Responsive Design ======= */
        @media (max-width: 768px) {
            nav {
                flex-direction: column;
                align-items: center;
            }

            nav a {
                margin: 5px 0;
                width: 100%;
                text-align: center;
            }

            .form-container {
                margin: 10px;
                padding: 15px;
            }
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        <h1>Edit Customer Profile</h1>
    </header>

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

    <!-- Form Container -->
    <div class="form-container">
        <form action="CustomerProfileServlet" method="post">
            <input type="hidden" name="customerId" value="${customer.customerId}">

            <!-- Full Name -->
            <div class="input-group">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName" value="${customer.fullName}" required>
            </div>

            <!-- Email -->
            <div class="input-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="${customer.email}" required>
            </div>

            <!-- Phone Number -->
            <div class="input-group">
                <label for="phoneNumber">Phone Number</label>
                <input type="text" id="phoneNumber" name="phoneNumber" value="${customer.phoneNumber}" required>
            </div>

            <!-- Address -->
            <div class="input-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" value="${customer.address}" required>
            </div>

            <!-- NIC -->
            <div class="input-group">
                <label for="nicNumber">NIC</label>
                <input type="text" id="nicNumber" name="nicNumber" value="${customer.nicNumber}" required>
            </div>

            <!-- Password -->
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter new password" required>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn">Update Profile</button>
        </form>
    </div>

    <!-- Footer -->
    <footer>
        &copy; 2023 Mega City Cab. All rights reserved. | <a href="#">Privacy Policy</a>
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