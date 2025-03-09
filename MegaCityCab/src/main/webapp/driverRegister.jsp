<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Registration</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #343a40;
        }
        .form-label {
            font-weight: bold;
            color: #495057;
        }
        .form-control, .form-select {
            border-radius: 5px;
            padding: 10px;
            border: 1px solid #ced4da;
            font-size: 1rem;
        }
        .form-control:focus, .form-select:focus {
            border-color: #17a2b8;
            box-shadow: 0 0 5px rgba(23, 162, 184, 0.5);
        }
        .btn-primary {
            background-color: #17a2b8;
            border: none;
            padding: 10px 20px;
            font-size: 1rem;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #138496;
        }
        .form-check-input {
            margin-top: 0.3rem;
        }
        .form-check-label {
            margin-left: 0.5rem;
        }
        .text-center {
            text-align: center;
        }
        a {
            color: #17a2b8;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        .alert {
            margin-top: 20px;
        }
    </style>
    <script>
        function validateForm() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;

            if (password !== confirmPassword) {
                alert("Passwords do not match!");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Driver Registration</h2>

        <!-- Display success or error message -->
        <% 
            String message = (String) request.getAttribute("message");
            if (message != null) {
        %>
            <div class="alert alert-info">
                <%= message %>
            </div>
        <%
            }
        %>

        <form action="${pageContext.request.contextPath}/DriverRegisterServlet" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="action" value="register">

            <!-- Driver Details -->
            <div class="mb-3">
                <label for="fullName" class="form-label">Full Name</label>
                <input type="text" class="form-control" id="fullName" name="fullName" required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label">Phone</label>
                <input type="text" class="form-control" id="phone" name="phone" required>
            </div>

            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
            </div>

            <div class="mb-3">
                <label for="nic" class="form-label">NIC</label>
                <input type="text" class="form-control" id="nic" name="nic" required>
            </div>

            <div class="mb-3">
                <label for="licenseNumber" class="form-label">License Number</label>
                <input type="text" class="form-control" id="licenseNumber" name="licenseNumber" required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>

            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Confirm Password</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
            </div>

            <!-- Car Details -->
            <div class="mb-3">
                <label for="carModel" class="form-label">Car Model</label>
                <input type="text" class="form-control" id="carModel" name="carModel" required>
            </div>

            <div class="mb-3">
                <label for="plateNumber" class="form-label">Plate Number</label>
                <input type="text" class="form-control" id="plateNumber" name="plateNumber" required>
            </div>

            <div class="mb-3">
                <label for="capacity" class="form-label">Capacity</label>
                <input type="number" class="form-control" id="capacity" name="capacity" min="1" max="10" required>
            </div>

            <div class="mb-3">
                <label for="fuelType" class="form-label">Fuel Type</label>
                <select class="form-select" id="fuelType" name="fuelType" required>
                    <option value="Petrol">Petrol</option>
                    <option value="Diesel">Diesel</option>
                    <option value="Electric">Electric</option>
                    <option value="Hybrid">Hybrid</option>
                </select>
            </div>

            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="hasAC" name="hasAC">
                <label class="form-check-label" for="hasAC">AC</label>
            </div>

            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="hasGPS" name="hasGPS">
                <label class="form-check-label" for="hasGPS">GPS</label>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-primary">Register</button>
            </div>
        </form>

        <p class="text-center mt-3">Already have an account? <a href="driverLogin.jsp">Login here</a></p>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>