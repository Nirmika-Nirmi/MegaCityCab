<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Cab</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        /* ======= General Styles ======= */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
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

        /* ======= Booking Form ======= */
        .booking-form {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .booking-form label {
            font-weight: 500;
            color: #555;
        }

        .booking-form input,
        .booking-form select,
        .booking-form textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }

        .booking-form input:focus,
        .booking-form select:focus,
        .booking-form textarea:focus {
            border-color: #667eea;
            outline: none;
        }

        .booking-form button {
            width: 100%;
            padding: 10px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            font-weight: 500;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .booking-form button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
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

            .booking-form {
                margin: 10px;
                padding: 15px;
            }
        }
    </style>
</head>
<body>

    <!-- Header -->
    <div class="header">
        <h1>Book a Cab</h1>
    </div>

    <!-- Navigation Bar -->
    <nav class="navbar">
        <a href="customerDashboard.jsp">Dashboard</a>
        <a href="view-bookings.jsp">View Bookings</a>
        <a href="customerDriversList.jsp">Driver List</a>
        <a href="edit-profile.jsp">Edit Profile</a>
        <a href="#" onclick="confirmLogout()">Logout</a>
    </nav>

    <!-- Booking Form -->
    <div class="booking-form">
        <form action="BookCabServlet" method="post">
            <input type="hidden" name="driverId" value="<%= request.getParameter("driverId") %>">
            <div class="mb-3">
                <label for="pickupLocation" class="form-label">Pickup Location</label>
                <input type="text" class="form-control" id="pickupLocation" name="pickupLocation" required>
            </div>
            <div class="mb-3">
                <label for="dropLocation" class="form-label">Drop Location</label>
                <input type="text" class="form-control" id="dropLocation" name="dropLocation" required>
            </div>
            <div class="mb-3">
                <label for="pickupTime" class="form-label">Pickup Date and Time</label>
                <input type="datetime-local" class="form-control" id="pickupTime" name="pickupTime" required>
            </div>
            <div class="mb-3">
                <label for="numPassengers" class="form-label">Number of Passengers</label>
                <input type="number" class="form-control" id="numPassengers" name="numPassengers" min="1" max="5" required>
            </div>
            <div class="mb-3">
                <label for="paymentMethod" class="form-label">Payment Method</label>
                <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                    <option value="">Select Payment Method</option>
                    <option value="Cash">Cash</option>
                    <option value="Card">Card</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="specialRequests" class="form-label">Special Requests</label>
                <textarea class="form-control" id="specialRequests" name="specialRequests" rows="3"></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Book Now</button>
        </form>
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