<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Bean.Booking, Dao.BookingDAO, java.sql.Timestamp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assigned Rides</title>
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

        /* ======= Container ======= */
        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        /* ======= Card Styles ======= */
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
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

        /* ======= Ride Item Styles ======= */
        .ride-item {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .ride-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .ride-item p {
            margin: 5px 0;
            font-size: 14px;
            color: #555;
        }

        .ride-item p strong {
            color: #444;
        }

        /* ======= Button Styles ======= */
        .btn {
            margin-right: 10px;
            padding: 8px 16px;
            font-size: 14px;
            border-radius: 6px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .btn-success {
            background: linear-gradient(135deg, #28a745, #218838);
            border: none;
            color: white;
        }

        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            border: none;
            color: white;
        }

        .btn-primary {
            background: linear-gradient(135deg, #007bff, #0056b3);
            border: none;
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
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

            .header h1 {
                font-size: 24px;
            }

            .card-header h3 {
                font-size: 20px;
            }

            .ride-item p {
                font-size: 13px;
            }

            .btn {
                padding: 6px 12px;
                font-size: 13px;
            }
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        <h1>Assigned Rides</h1>
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
        <!-- Assigned Rides -->
        <div class="card">
            <div class="card-header">
                <h3>Your Assigned Rides</h3>
            </div>
            <div class="card-body">
                <%
                    // Retrieve driver ID from session
                    Integer driverId = (Integer) session.getAttribute("driverId");
                    if (driverId == null) {
                        out.println("<p>Driver ID not found in session. Please <a href='driverLogin.jsp'>log in again</a>.</p>");
                        return;
                    }

                    // Fetch assigned rides for the driver
                    BookingDAO bookingDAO = new BookingDAO();
                    List<Booking> assignedRides = bookingDAO.getAssignedRides(driverId);

                    if (assignedRides.isEmpty()) {
                %>
                    <p>No rides assigned.</p>
                <%
                    } else {
                        for (Booking ride : assignedRides) {
                            // Fetch additional details for the booking
                            String customerName = bookingDAO.getCustomerNameByBookingId(ride.getBookingId());
                            String customerPhone = bookingDAO.getCustomerPhoneByBookingId(ride.getBookingId());
                            Timestamp bookingDate = bookingDAO.getBookingDateByBookingId(ride.getBookingId());
                %>
                    <div class="ride-item">
                        <p><strong>Ride ID:</strong> <%= ride.getBookingId() %></p>
                        <p><strong>Customer Name:</strong> <%= customerName %></p>
                        <p><strong>Customer Phone:</strong> <%= customerPhone %></p>
                        <p><strong>Pickup Location:</strong> <%= ride.getPickupLocation() %></p>
                        <p><strong>Drop Location:</strong> <%= ride.getDropLocation() %></p>
                        <p><strong>Payment Method:</strong> <%= ride.getPaymentMethod() != null ? ride.getPaymentMethod() : "Not Specified" %></p>
                        <p><strong>Number of Passengers:</strong> <%= ride.getNumPassengers() %></p>
                        <p><strong>Special Requests:</strong> <%= ride.getSpecialRequests() != null ? ride.getSpecialRequests() : "None" %></p>
                        <p><strong>Booking Date:</strong> <%= bookingDate != null ? bookingDate : "Not Available" %></p>
                        <p><strong>Status:</strong> <%= ride.getStatus() %></p>

                        <%
                            if (ride.getStatus().equals("Pending")) {
                        %>
                            <form action="${pageContext.request.contextPath}/RideActionServlet" method="post" style="display: inline;">
                                <input type="hidden" name="bookingId" value="<%= ride.getBookingId() %>" />
                                <input type="hidden" name="action" value="accept" />
                                <button type="submit" class="btn btn-success">Accept</button>
                            </form>
                            <form action="${pageContext.request.contextPath}/RideActionServlet" method="post" style="display: inline;">
                                <input type="hidden" name="bookingId" value="<%= ride.getBookingId() %>" />
                                <input type="hidden" name="action" value="reject" />
                                <button type="submit" class="btn btn-danger">Reject</button>
                            </form>
                        <%
                            } else if (ride.getStatus().equals("Confirmed")) {
                        %>
                            <form action="${pageContext.request.contextPath}/RideActionServlet" method="post" style="display: inline;">
                                <input type="hidden" name="bookingId" value="<%= ride.getBookingId() %>" />
                                <input type="hidden" name="action" value="complete" />
                                <button type="submit" class="btn btn-primary">Mark as Completed</button>
                            </form>
                        <%
                            }
                        %>
                    </div>
                <%
                        }
                    }
                %>
            </div>
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