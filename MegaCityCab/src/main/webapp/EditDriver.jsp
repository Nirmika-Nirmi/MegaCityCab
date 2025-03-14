<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Bean.Driver" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Driver</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        /* ======= General Styles ======= */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #333;
        }

        /* ======= Form Container ======= */
        .form-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-container h1 {
            margin-bottom: 20px;
            color: #444;
            font-size: 24px;
            font-weight: 600;
        }

        /* ======= Input Groups ======= */
        .input-group {
            text-align: left;
            margin-bottom: 15px;
        }

        .input-group label {
            display: block;
            font-weight: 500;
            margin-bottom: 5px;
            color: #555;
            font-size: 14px;
        }

        .input-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }

        .input-group input:focus {
            border-color: #667eea;
            outline: none;
        }

        /* ======= Button ======= */
        .btn {
            width: 100%;
            padding: 10px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            font-weight: 500;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0px 5px 15px rgba(102, 126, 234, 0.4);
        }

        /* ======= Responsive Design ======= */
        @media (max-width: 480px) {
            .form-container {
                padding: 20px;
            }

            .form-container h1 {
                font-size: 22px;
            }

            .input-group input {
                padding: 8px;
                font-size: 13px;
            }
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        <h1>Edit My Profile (Driver)</h1>
    </header>

    <!-- Navigation Bar -->
    <nav>
        <a href="driver-dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
        <a href="driver-bookings.jsp"><i class="fas fa-calendar-alt"></i> View All Rides</a>
        <a href="DriverEarningsHistory.jsp"><i class="fas fa-dollar-sign"></i> Earnings History</a>
        <a href="driverEditProfile.jsp"><i class="fas fa-user-edit"></i> Edit Profile</a>
        <a href="#" onclick="confirmLogout()"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </nav>

    <!-- Debugging Statements -->
    <%
        Driver driver = (Driver) request.getAttribute("driver");
        if (driver == null) {
            out.println("<div class='error-message'>Driver object is null!</div>");
        } else {
            out.println("<div class='success-message'>Driver Name: " + driver.getFullName() + "</div>");
        }
    %>

    <!-- Form Container -->
    <div class="form-container">
        <!-- Display error message if update fails -->
        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <div class="error-message"><%= errorMessage %></div>
        <% } %>

        <!-- Form to edit driver profile -->
        <form action="DriverServlet" method="post">
            <input type="hidden" name="driverId" value="${driver.driverId}">
            

            <!-- Full Name -->
            <div class="input-group">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName" value="${driver.fullName}" required>
            </div>

            <!-- Email -->
            <div class="input-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="${driver.email}" required>
            </div>

            <!-- Phone Number -->
            <div class="input-group">
                <label for="phoneNumber">Phone Number</label>
                <input type="text" id="phoneNumber" name="phoneNumber" value="${driver.phoneNumber}" required>
            </div>

            <!-- Address -->
            <div class="input-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" value="${driver.address}" required>
            </div>

            <!-- License Number -->
            <div class="input-group">
                <label for="licenseNumber">License Number</label>
                <input type="text" id="licenseNumber" name="licenseNumber" value="${driver.licenseNumber}" required>
            </div>

            <!-- Status (Read-Only for Driver) -->
            <div class="input-group">
                <label for="status">Status</label>
                <input type="text" id="status" name="status" value="${driver.status}" readonly>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn">Update Profile</button>
        </form>
    </div>

</body>
</html>