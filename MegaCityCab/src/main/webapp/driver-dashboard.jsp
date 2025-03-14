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
    <!-- Font Awesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
/* ======= General Styles ======= */
body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #f0f4f8, #d9e2ef);
    margin: 0;
    padding: 0;
    color: #333;
}

/* ======= Header ======= */
header {
    background: linear-gradient(135deg, #4a90e2, #764ba2);
    color: white;
    padding: 1.5rem;
    text-align: center;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

header h1 {
    margin: 0;
    font-size: 30px;
    font-weight: 700;
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
    padding: 12px 20px;
    margin: 0 5px;
    text-decoration: none;
    font-weight: 500;
    border-radius: 5px;
    transition: all 0.3s ease-in-out;
}

nav a:hover {
    background: #4a90e2;
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(74, 144, 226, 0.3);
}

/* ======= Main Container ======= */
.container {
    max-width: 1200px;
    margin: 20px auto;
    padding: 25px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

/* ======= Welcome Section ======= */
.welcome {
    text-align: center;
    padding: 25px;
    background: linear-gradient(135deg, #f4f7fa, #e8eef7);
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
    margin-bottom: 30px;
}

.welcome p {
    margin: 10px 0;
    font-size: 18px;
    color: #444;
}

.welcome p:first-child {
    font-size: 26px;
    font-weight: 600;
    color: #4a90e2;
}

/* ======= Quick Stats Cards ======= */
.card-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 20px;
    margin-top: 20px;
}

.card {
    background: white;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    text-align: center;
    transition: all 0.3s ease-in-out;
    position: relative;
    overflow: hidden;
}

.card:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
}

.card i {
    font-size: 40px;
    color: #4a90e2;
    margin-bottom: 12px;
}

.card h3 {
    font-size: 22px;
    font-weight: 600;
    color: #444;
    margin-bottom: 5px;
}

.card p {
    font-size: 18px;
    font-weight: bold;
    color: #2c3e50;
}

/* ======= Recent Rides Table ======= */
.recent-rides {
    margin-top: 30px;
}

.recent-rides h3 {
    font-size: 24px;
    font-weight: 600;
    color: #333;
    margin-bottom: 15px;
}

.table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.table th, .table td {
    padding: 14px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

.table th {
    background: linear-gradient(135deg, #4a90e2, #764ba2);
    color: white;
    font-weight: 500;
}

.table tbody tr:hover {
    background-color: rgba(74, 144, 226, 0.1);
}

.table tbody tr:nth-child(even) {
    background-color: #f9f9f9;
}

/* ======= Footer ======= */
footer {
    background: #2c3e50;
    color: white;
    text-align: center;
    padding: 15px;
    margin-top: 30px;
    font-size: 14px;
    border-radius: 0 0 12px 12px;
}

footer a {
    color: #4a90e2;
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
        padding: 20px;
    }

    .welcome p {
        font-size: 16px;
    }

    .welcome p:first-child {
        font-size: 22px;
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
        <h1>Driver Dashboard</h1>
    </header>

    <!-- Navigation Bar -->
    <nav>
        <a href="driver-dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
        <a href="driver-bookings.jsp"><i class="fas fa-calendar-alt"></i> View All Rides</a>
        <a href="DriverEarningsHistory.jsp"><i class="fas fa-dollar-sign"></i> Earnings History</a>
        <a href="driverEditProfile.jsp"><i class="fas fa-user-edit"></i> Edit Profile</a>
        <a href="#" onclick="confirmLogout()"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <!-- Welcome Section -->
        <div class="welcome">
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
                <p>Hello, <%= driver.getFullName() %>! Welcome back.</p>
                <p>Today is: <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %></p>
            <%
                } else {
                    out.println("<p>Driver details not found.</p>");
                }
            %>
        </div>

        <!-- Quick Stats Cards -->
        <div class="card-container">
            <div class="card">
                <i class="fas fa-dollar-sign"></i>
                <h3>Total Earnings</h3>
                <%
                    BookingDAO bookingDAO = new BookingDAO();
                    double totalEarnings = bookingDAO.getTotalEarnings(driverId);
                %>
                <p>$<%= String.format("%.2f", totalEarnings) %></p>
            </div>
            <div class="card">
                <i class="fas fa-calendar-check"></i>
                <h3>Completed Rides</h3>
                <%
                    int completedRides = bookingDAO.getCompletedRidesCount(driverId);
                %>
                <p><%= completedRides %></p>
            </div>
            <div class="card">
                <i class="fas fa-clock"></i>
                <h3>Pending Rides</h3>
                <%
                    int pendingRides = bookingDAO.getPendingRidesCount(driverId);
                %>
                <p><%= pendingRides %></p>
            </div>
        </div>

        <!-- Recent Rides Section -->
        <div class="recent-rides">
            <h3>Recent Rides</h3>
            <table class="table">
                <thead>
                    <tr>
                        <th>Customer Name</th>
                        <th>Pickup Location</th>
                        <th>Drop Location</th>
                        <th>Fare</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Booking> recentRides = bookingDAO.getRecentRides(driverId);
                        if (recentRides != null && !recentRides.isEmpty()) {
                            for (Booking ride : recentRides) {
                    %>
                        <tr>
                            <td><%= ride.getCustomerId() %></td>
                            <td><%= ride.getPickupLocation() %></td>
                            <td><%= ride.getDropLocation() %></td>
                            <td>$<%= String.format("%.2f", ride.getFare()) %></td>
                            <td><%= ride.getStatus() %></td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="5" class="text-center">No recent rides found.</td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
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