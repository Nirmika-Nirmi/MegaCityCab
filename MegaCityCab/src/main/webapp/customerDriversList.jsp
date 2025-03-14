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

        .navbar a.active {
            background: #667eea;
            color: white;
        }

        /* ======= Driver List ======= */
        .driver-list {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .driver-list table {
            width: 100%;
            border-collapse: collapse;
        }

        .driver-list th, .driver-list td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
            font-size: 14px;
        }

        .driver-list th {
            background-color: #f8f9fa; /* Light gray background */
            color: #333; /* Dark text color */
            font-weight: 600;
        }

        .driver-list tr:hover {
            background-color: rgba(102, 126, 234, 0.05);
        }

        .driver-list .btn {
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 6px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .driver-list .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(102, 126, 234, 0.3);
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

            .driver-list {
                margin: 10px;
                padding: 15px;
            }

            .driver-list th, .driver-list td {
                padding: 8px;
                font-size: 12px;
            }
        }
    </style>
</head>
<body>

    <!-- Header -->
    <div class="header">
        <h1>Available Drivers</h1>
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

    <!-- Driver List -->
    <div class="driver-list">
        <%
            DriverDAO driverDAO = new DriverDAO();
            List<Driver> drivers = driverDAO.getAvailableDrivers();
        %>
        <table>
            <thead>
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
            </thead>
            <tbody>
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
            </tbody>
        </table>
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