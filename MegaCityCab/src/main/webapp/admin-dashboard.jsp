<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Bean.Admin" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #333;
            color: white;
            padding: 1rem;
            text-align: center;
        }

        nav {
            background-color: #444;
            overflow: hidden;
        }

        nav a {
            color: white;
            padding: 14px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
        }

        nav a:hover {
            background-color: #ddd;
            color: black;
        }

        .container {
            padding: 2rem;
        }

        .welcome {
            font-size: 20px;
        }

        .overview {
            margin-top: 30px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
        }

        .actions {
            margin-top: 20px;
        }

        .actions a {
            padding: 10px 20px;
            margin: 10px;
            background-color: #007BFF;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .actions a:hover {
            background-color: #0056b3;
        }

        .logout-btn {
            background-color: #dc3545;
        }

        .logout-btn:hover {
            background-color: #c82333;
        }

        /* Notification Styles */
        .notification {
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            text-align: center;
        }

        .notification.success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .notification.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        <h1>Admin Dashboard</h1>
    </header>

    <!-- Navigation Bar -->
    <nav>
        <a href="adminDashboard.jsp">Home</a>
        <a href="viewDrivers.jsp">View Drivers</a>
        <a href="viewCustomers.jsp">View Customers</a>
        <a href="manageBookings.jsp">Manage Bookings</a>
        <a href="manageCars.jsp">Manage Cars</a>
        <a href="reports.jsp">Reports</a>
        <a href="adminProfile.jsp">Profile</a>
        <a href="changePassword.jsp">Change Password</a>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <% 
            Admin admin = (Admin) session.getAttribute("admin");
            if (admin != null) {
        %>
            <div class="welcome">
                <p>Hello, <%= admin.getFullName() %>! Welcome back.</p>
                <p>Today is: <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %></p>
            </div>
        <% 
            } 
        %>








</body>
</html>