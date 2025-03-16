<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Bean.Admin" %>
<%@ page import="Dao.CustomerDAO, Dao.DriverDAO, Dao.BookingDAO, Dao.BillingDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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

        nav a i {
            margin-right: 8px;
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
            margin-bottom: 30px;
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

        /* ======= Quick Stats Cards ======= */
        .card-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
        }

        .card i {
            font-size: 32px;
            color: #667eea;
            margin-bottom: 10px;
        }

        .card h3 {
            font-size: 20px;
            font-weight: 600;
            color: #444;
            margin: 10px 0;
        }

        .card p {
            font-size: 16px;
            color: #777;
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

            .card-container {
                grid-template-columns: 1fr;
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
        <a href="admin-dashboard.jsp"><i class="fas fa-home"></i> Home</a>
        <a href="viewDrivers.jsp"><i class="fas fa-users"></i> View Drivers</a>
        <a href="viewCustomers.jsp"><i class="fas fa-user-friends"></i> View Customers</a>
        <a href="AdminBookingHistoryServlet"><i class="fas fa-calendar-alt"></i> Manage Bookings</a>
        <a href="AdminViewCarsServlet"><i class="fas fa-car"></i> Manage Cars</a>
        <a href="adminFeedback.jsp"><i class="fas fa-comments"></i> Reports</a>
        <a href="adminProfile.jsp"><i class="fas fa-user-cog"></i> Profile</a>
        <a href="logout.jsp" style="color: #ff4444;"><i class="fas fa-sign-out-alt"></i> Logout</a>
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

        <!-- Quick Stats Cards -->
        <div class="card-container">
            <div class="card">
                <i class="fas fa-users"></i>
                <h3>Total Customers</h3>
                <p><%= new CustomerDAO().getTotalCustomers() %></p>
            </div>
            <div class="card">
                <i class="fas fa-car"></i>
                <h3>Total Drivers</h3>
                <p><%= new DriverDAO().getTotalDrivers() %></p>
            </div>
            <div class="card">
                <i class="fas fa-calendar-check"></i>
                <h3>Total Bookings</h3>
                <p><%= new BookingDAO().getTotalBookings() %></p>
            </div>
            <div class="card">
                <i class="fas fa-dollar-sign"></i>
                <h3>Total Revenue</h3>
                <p>$<%= String.format("%.2f", new BillingDAO().getTotalRevenue()) %></p>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        &copy; 2023 Admin Dashboard. All rights reserved. | <a href="#">Privacy Policy</a>
    </footer>

</body>
</html>