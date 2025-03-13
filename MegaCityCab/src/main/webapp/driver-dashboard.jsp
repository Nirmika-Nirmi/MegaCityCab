<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Bean.Driver, Bean.Car, Bean.Booking, Dao.DriverDAO, Dao.CarDao, Dao.BookingDAO, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Dashboard</title>
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

        /* ======= Navbar ======= */
        .navbar {
            background: white;
            padding: 10px 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-size: 24px;
            font-weight: 600;
            color: #667eea !important;
        }

        .navbar-nav .nav-link {
            color: #555 !important;
            padding: 10px 20px;
            margin: 0 5px;
            font-weight: 500;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .navbar-nav .nav-link:hover {
            background: #667eea;
            color: white !important;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(102, 126, 234, 0.3);
        }

        .navbar-nav .nav-link.active {
            background: #667eea;
            color: white !important;
        }

        /* ======= Container ======= */
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        /* ======= Header ======= */
        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h1 {
            font-size: 28px;
            font-weight: 600;
            color: #444;
        }

        /* ======= Card Styles ======= */
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .card-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border-radius: 10px 10px 0 0;
            padding: 15px;
        }

        .card-header h3 {
            margin: 0;
            font-size: 22px;
            font-weight: 500;
        }

        .card-body {
            padding: 20px;
        }

        /* ======= Driver Details ======= */
        .driver-details p {
            margin-bottom: 10px;
            font-size: 14px;
            color: #555;
        }

        .driver-details p strong {
            color: #444;
        }

        /* ======= Earnings Summary ======= */
        .earnings-summary {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .earnings-summary p {
            margin-bottom: 10px;
            font-size: 14px;
            color: #555;
        }

        .earnings-summary p strong {
            color: #444;
        }

        /* ======= Footer ======= */
        .footer {
            text-align: center;
            margin-top: 20px;
            padding: 10px;
            background: #2c3e50;
            color: white;
            border-radius: 5px;
        }

        /* ======= Responsive Design ======= */
        @media (max-width: 768px) {
            .navbar-nav .nav-link {
                margin: 5px 0;
                width: 100%;
                text-align: center;
            }

            .container {
                margin: 10px;
                padding: 15px;
            }

            .header h1 {
                font-size: 24px;
            }

            .card-header h3 {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Mega City Cab</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="driverDashboard.jsp">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="driver-bookings.jsp">View All Rides</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="DriverEarningsHistory.jsp">Earnings History</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="driverProfile.jsp">Edit Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1>Driver Dashboard</h1>
        </div>

        <!-- Driver Details -->
        <div class="card">
            <div class="card-header">
                <h3>Driver Details</h3>
            </div>
            <div class="card-body driver-details">
                <%
                    // Retrieve driver ID from session
                    Integer driverId = (Integer) session.getAttribute("driverId");
                    if (driverId == null) {
                        response.sendRedirect("driverLogin.jsp"); // Redirect to login if session is invalid
                        return;
                    }

                    // Fetch driver details
                    DriverDAO driverDAO = new DriverDAO();
                    Driver driver = driverDAO.getDriverById(driverId);

                    if (driver != null) {
                %>
                    <p><strong>Name:</strong> <%= driver.getFullName() %></p>
                    <p><strong>Email:</strong> <%= driver.getEmail() %></p>
                    <p><strong>Phone:</strong> <%= driver.getPhoneNumber() %></p>
                    <p><strong>License Number:</strong> <%= driver.getLicenseNumber() %></p>
                    <p><strong>Status:</strong> <%= driver.getStatus() %></p>
                <%
                    } else {
                        out.println("<p>Driver details not found.</p>");
                    }
                %>
            </div>
        </div>

        <!-- Car Details -->
        <div class="card">
            <div class="card-header">
                <h3>Car Details</h3>
            </div>
            <div class="card-body">
                <%
                    CarDao carDao = new CarDao();
                    Car car = carDao.getCarByDriverId(driverId);

                    if (car != null) {
                %>
                    <p><strong>Model:</strong> <%= car.getModel() %></p>
                    <p><strong>Plate Number:</strong> <%= car.getPlateNumber() %></p>
                    <p><strong>Capacity:</strong> <%= car.getCapacity() %></p>
                    <p><strong>Fuel Type:</strong> <%= car.getFuelType() %></p>
                    <p><strong>AC:</strong> <%= car.isAc() ? "Yes" : "No" %></p>
                    <p><strong>GPS:</strong> <%= car.isGps() ? "Yes" : "No" %></p>
                <%
                    } else {
                        out.println("<p>No car assigned.</p>");
                    }
                %>
            </div>
        </div>

        <!-- Earnings Summary -->
        <div class="card">
            <div class="card-header">
                <h3>Earnings Summary</h3>
            </div>
            <div class="card-body earnings-summary">
                <%
                    BookingDAO bookingDAO = new BookingDAO();
                    double totalEarnings = bookingDAO.getTotalEarnings(driverId);
                    int completedRides = bookingDAO.getCompletedRidesCount(driverId);
                %>
                <p><strong>Total Earnings:</strong> $<%= totalEarnings %></p>
                <p><strong>Completed Rides:</strong> <%= completedRides %></p>
                <p><a href="driverEarningsHistory.jsp" class="btn btn-primary">View Earnings History</a></p>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        &copy; 2023 Mega City Cab. All rights reserved.
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>