<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Bean.Car, Dao.DBConnection, java.sql.Connection, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Cars</title>
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
            background: linear-gradient(135deg, #f4f7fa, #e8eef7);
            margin: 0;
            padding: 0;
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

        .container h2 {
            font-size: 24px;
            font-weight: 600;
            color: #444;
            margin-bottom: 20px;
        }

        /* ======= Table Styles ======= */
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .table thead {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .table th, .table td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        .table th {
            font-weight: 500;
            background: linear-gradient(135deg, #667eea, #764ba2);
            text-color:white;
        }

        .table tbody tr:hover {
            background-color: rgba(102, 126, 234, 0.1);
        }

        .table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        /* ======= No Data Message ======= */
        .no-data {
            text-align: center;
            color: #777;
            padding: 20px;
        }

        /* ======= Debugging Information ======= */
        .debug-info {
            background-color: #fff3e0;
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-family: monospace;
            font-size: 14px;
        }
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

            .table th, .table td {
                padding: 8px;
            }
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        <h1>Admin Dashboard - View Cars</h1>
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
        

        <!-- Debugging Information -->
        <div class="debug-info">
            <%
                // Declare the cars variable here
                List<Car> cars = (List<Car>) request.getAttribute("cars");
            %>
            <p><strong>Number of Cars:</strong> <%= cars == null ? "null" : cars.size() %></p>
        </div>

        <!-- Car List Table -->
        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <th>Car ID</th>
                    <th>Model</th>
                    <th>Plate Number</th>
                    <th>Capacity</th>
                    <th>Fuel Type</th>
                    <th>AC</th>
                    <th>GPS</th>
                    <th>Driver ID</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (cars != null && !cars.isEmpty()) {
                        for (Car car : cars) {
                %>
                    <tr>
                        <td><%= car.getCarId() %></td>
                        <td><%= car.getModel() %></td>
                        <td><%= car.getPlateNumber() %></td>
                        <td><%= car.getCapacity() %></td>
                        <td><%= car.getFuelType() %></td>
                        <td><%= car.isAc() ? "Yes" : "No" %></td>
                        <td><%= car.isGps() ? "Yes" : "No" %></td>
                        <td><%= car.getDriverId() %></td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="8" class="no-data">No cars found.</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- Footer -->
    <footer>
        &copy; 2023 Admin Dashboard. All rights reserved. | <a href="#">Privacy Policy</a>
    </footer>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>