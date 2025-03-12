<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Bean.Admin" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap">
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

        /* ======= Main Container ======= */
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        /* ======= Welcome Section ======= */
        .welcome {
            text-align: center;
            padding: 20px;
            background: linear-gradient(135deg, #f4f7fa, #e8eef7);
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }

        .welcome p {
            margin: 10px 0;
            font-size: 18px;
            color: #444;
        }

        .welcome p:first-child {
            font-size: 24px;
            font-weight: 600;
            color: #667eea;
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

            .container {
                margin: 10px;
                padding: 15px;
            }

            .welcome p {
                font-size: 16px;
            }

            .welcome p:first-child {
                font-size: 20px;
            }
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
        <a href="admin-dashboard.jsp">Home</a>
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
    </div>

</body>
</html>