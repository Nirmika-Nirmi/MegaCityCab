<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Bean.Booking, Dao.BookingDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings</title>
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
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        /* ======= Table Styles ======= */
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .table th, .table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table th {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            font-weight: 500;
        }

        .table tbody tr:hover {
            background-color: rgba(102, 126, 234, 0.05);
        }

        /* ======= Button Styles ======= */
        .btn {
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 6px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            border: none;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(220, 53, 69, 0.3);
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

            h1 {
                font-size: 24px;
            }

            .table th, .table td {
                padding: 8px;
                font-size: 14px;
            }

            .btn {
                padding: 5px 10px;
                font-size: 13px;
            }
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        <h1>My Bookings</h1>
    </header>

    <!-- Navigation Bar -->
    <nav>
        <a href="customer-dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
        <a href="viewBookings.jsp"><i class="fas fa-calendar-alt"></i> View Bookings</a>
        <a href="customerDriversList.jsp"><i class="fas fa-users"></i> Driver List</a>
        <a href="PaymentHistoryServlet"><i class="fas fa-history"></i> Payment History</a>
        <a href="submitFeedback.jsp"><i class="fas fa-comments"></i> Feedback</a>
        <a href="customerProfile.jsp"><i class="fas fa-user-edit"></i> Profile</a>
        <a href="#" onclick="confirmLogout()"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <%
            // Retrieve customer ID from session
            Integer customerId = (Integer) session.getAttribute("customerId");
            if (customerId == null) {
        %>
                <p>Customer ID not found in session. Please <a href="customerLogin.jsp">log in again</a>.</p>
        <%
            } else {
                // Fetch bookings for the customer
                BookingDAO bookingDAO = new BookingDAO();
                List<Booking> bookings = bookingDAO.getBookingsByCustomerId(customerId);

                if (bookings.isEmpty()) {
        %>
                    <p class="text-center">No bookings found.</p>
        <%
                } else {
        %>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Booking ID</th>
                                <th>Pickup Location</th>
                                <th>Drop Location</th>
                                <th>Driver Name</th>
                                <th>Driver Phone</th>
                                <th>Status</th>
                                <th>Fare</th>
                                <th>Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Booking booking : bookings) {
                                    String driverName = bookingDAO.getDriverNameByBookingId(booking.getBookingId());
                                    String driverPhone = bookingDAO.getDriverPhoneByBookingId(booking.getBookingId());
                            %>
                                <tr>
                                    <td><%= booking.getBookingId() %></td>
                                    <td><%= booking.getPickupLocation() %></td>
                                    <td><%= booking.getDropLocation() %></td>
                                    <td><%= driverName != null ? driverName : "Not Assigned" %></td>
                                    <td><%= driverPhone != null ? driverPhone : "Not Assigned" %></td>
                                    <td><%= booking.getStatus() %></td>
                                    <td>$<%= booking.getFare() %></td>
                                    <td><%= booking.getBookingDate() %></td>
                                    <td>
                                        <% if (booking.getStatus().equals("Pending")) { %>
                                            <!-- Button to trigger the cancellation -->
                                            <form action="CancelBookingServlet" method="post" style="display: inline;">
                                                <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                                                <button type="submit" class="btn btn-danger">Cancel Booking</button>
                                            </form>
                                        <% } %>
                                    </td>
                                </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
        <%
                }
            }
        %>
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