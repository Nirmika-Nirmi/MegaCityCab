<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Bean.CustomerBean, Dao.CustomerDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Customer Profile</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        /* ======= General Styles ======= */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #333;
        }

        /* ======= Form Container ======= */
        .form-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-container h2 {
            margin-bottom: 20px;
            color: #444;
            font-size: 24px;
            font-weight: 600;
        }

        /* ======= Input Groups ======= */
        .form-group {
            text-align: left;
            margin-bottom: 15px;
            position: relative;
        }

        .form-group label {
            display: block;
            font-weight: 500;
            margin-bottom: 5px;
            color: #555;
            font-size: 14px;
        }

        .form-group input {
            width: 100%;
            padding: 10px 10px 10px 40px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            transition: border-color 0.3s ease;
            box-sizing: border-box;
        }

        .form-group input:focus {
            border-color: #667eea;
            outline: none;
        }

        .form-group i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
            font-size: 16px;
        }

        /* ======= Button ======= */
        .btn {
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

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0px 5px 15px rgba(102, 126, 234, 0.4);
        }

        /* ======= Error and Success Messages ======= */
        .error-message {
            color: #ff4757;
            margin-top: 10px;
            font-size: 14px;
            font-weight: 500;
        }

        .success-message {
            color: #28a745;
            margin-top: 10px;
            font-size: 14px;
            font-weight: 500;
        }

        /* ======= Navigation Bar ======= */
        .navbar {
            background: white;
            padding: 10px 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }

        .navbar a {
            color: #555;
            padding: 10px 20px;
            margin: 5px;
            text-decoration: none;
            font-weight: 500;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .navbar a:hover {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(102, 126, 234, 0.3);
        }

        /* ======= Responsive Design ======= */
        @media (max-width: 768px) {
            .form-container {
                padding: 20px;
            }

            .form-container h2 {
                font-size: 22px;
            }

            .form-group input {
                padding: 8px 8px 8px 35px;
                font-size: 13px;
            }

            .form-group i {
                font-size: 14px;
            }

            .btn {
                padding: 8px;
                font-size: 14px;
            }

            .navbar {
                flex-direction: column;
                align-items: center;
            }

            .navbar a {
                width: 100%;
                text-align: center;
                margin: 5px 0;
            }
        }
    </style>
</head>
<body>

    <!-- Form Container -->
    <div class="form-container">
        <h2>Edit Customer Profile</h2>

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

        <%-- Display success or error messages --%>
        <%
            String successMessage = (String) request.getParameter("message");
            String errorMessage = (String) request.getAttribute("errorMessage");
            
            if (successMessage != null) {
        %>
            <div class="success-message"><%= successMessage %></div>
        <% } %>

        <% if (errorMessage != null) { %>
            <div class="error-message"><%= errorMessage %></div>
        <% } %>

        <%
            // Fetch customerId from the session
            Integer customerId = (Integer) session.getAttribute("customerId");

            if (customerId == null) {
                response.sendRedirect("customer-dashboard.jsp"); // Redirect if customerId is missing
                return;
            }

            CustomerDAO customerDAO = new CustomerDAO();
            CustomerBean customer = customerDAO.getCustomerById(customerId);

            if (customer == null) {
                response.sendRedirect("customer-dashboard.jsp"); // Redirect if customer not found
                return;
            }
        %>

        <form action="UpdateCustomerProfileServlet" method="post" onsubmit="return validatePasswords()">
            <input type="hidden" name="customerId" value="<%= customer.getCustomerId() %>">

            <!-- Personal Details Section -->
            <div class="form-group">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName" value="<%= customer.getFullName() %>" required>
                <i class="fas fa-user"></i>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="<%= customer.getEmail() %>" required>
                <i class="fas fa-envelope"></i>
            </div>

            <div class="form-group">
                <label for="phoneNumber">Phone Number</label>
                <input type="text" id="phoneNumber" name="phoneNumber" value="<%= customer.getPhoneNumber() %>" required>
                <i class="fas fa-phone"></i>
            </div>

            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" value="<%= customer.getAddress() %>" required>
                <i class="fas fa-map-marker-alt"></i>
            </div>

            <div class="form-group">
                <label for="nicNumber">NIC Number</label>
                <input type="text" id="nicNumber" name="nicNumber" value="<%= customer.getNicNumber() %>" required>
                <i class="fas fa-id-card"></i>
            </div>

            <!-- Change Password Section -->
            <div class="form-group">
                <label for="currentPassword">Current Password</label>
                <input type="password" id="currentPassword" name="currentPassword" required>
                <i class="fas fa-lock"></i>
            </div>

            <div class="form-group">
                <label for="newPassword">New Password</label>
                <input type="password" id="newPassword" name="newPassword">
                <i class="fas fa-lock"></i>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm New Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword">
                <i class="fas fa-lock"></i>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn">Save Changes</button>
        </form>
    </div>

    <!-- JavaScript for Password Validation -->
    <script>
        function validatePasswords() {
            const newPassword = document.getElementById("newPassword").value;
            const confirmPassword = document.getElementById("confirmPassword").value;

            if (newPassword !== confirmPassword) {
                alert("New Password and Confirm Password do not match.");
                return false;
            }
            return true;
        }

        function confirmLogout() {
            if (confirm("Are you sure you want to logout?")) {
                window.location.href = "logout.jsp";
            }
        }
    </script>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>