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
        h1 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 28px;
            font-weight: 600;
            color: #444;
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

        /* ======= Responsive Design ======= */
        @media (max-width: 768px) {
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
    <div class="container">
        <h1>My Bookings</h1>
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

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>