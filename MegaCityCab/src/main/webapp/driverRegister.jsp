<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Registration</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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

        /* ======= Registration Container ======= */
        .registration-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .registration-container h2 {
            margin-bottom: 20px;
            color: #444;
            font-size: 24px;
            font-weight: 600;
            text-align: center;
        }

        /* ======= Form Styles ======= */
        .form-label {
            font-weight: 500;
            color: #555;
            font-size: 14px;
        }

        .form-control, .form-select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            transition: border-color 0.3s ease;
            box-sizing: border-box;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            outline: none;
        }

        .form-check {
            margin-bottom: 15px;
        }

        .form-check-input {
            margin-right: 10px;
        }

        .form-check-label {
            font-size: 14px;
            color: #555;
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

        /* ======= Alert Styles ======= */
        .alert {
            margin-top: 20px;
            padding: 12px;
            border-radius: 6px;
            font-size: 14px;
        }

        .alert-info {
            background-color: #e9f5ff;
            border-color: #b8e2ff;
            color: #31708f;
        }

        /* ======= Login Link ======= */
        .login-link {
            margin-top: 15px;
            font-size: 14px;
            color: #555;
            text-align: center;
        }

        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        /* ======= Responsive Design ======= */
        @media (max-width: 768px) {
            .registration-container {
                padding: 20px;
            }

            .registration-container h2 {
                font-size: 22px;
            }

            .form-control, .form-select {
                padding: 8px;
                font-size: 13px;
            }

            .btn {
                padding: 8px;
                font-size: 14px;
            }
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

    <!-- Registration Container -->
    <div class="registration-container">
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
                <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Enter your full name" required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label">Phone</label>
                <input type="text" class="form-control" id="phone" name="phone" placeholder="Enter your phone number" required>
            </div>

            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <textarea class="form-control" id="address" name="address" rows="3" placeholder="Enter your address" required></textarea>
            </div>

            <div class="mb-3">
                <label for="nic" class="form-label">NIC</label>
                <input type="text" class="form-control" id="nic" name="nic" placeholder="Enter your NIC number" required>
            </div>

            <div class="mb-3">
                <label for="licenseNumber" class="form-label">License Number</label>
                <input type="text" class="form-control" id="licenseNumber" name="licenseNumber" placeholder="Enter your license number" required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
            </div>

            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Confirm Password</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
            </div>

            <!-- Car Details -->
            <div class="mb-3">
                <label for="carModel" class="form-label">Car Model</label>
                <input type="text" class="form-control" id="carModel" name="carModel" placeholder="Enter your car model" required>
            </div>

            <div class="mb-3">
                <label for="plateNumber" class="form-label">Plate Number</label>
                <input type="text" class="form-control" id="plateNumber" name="plateNumber" placeholder="Enter your plate number" required>
            </div>

            <div class="mb-3">
                <label for="capacity" class="form-label">Capacity</label>
                <input type="number" class="form-control" id="capacity" name="capacity" min="1" max="10" placeholder="Enter passenger capacity" required>
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

            <!-- AC and GPS Checkboxes -->
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="hasAC" name="hasAC">
                <label class="form-check-label" for="hasAC">AC</label>
            </div>

            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="hasGPS" name="hasGPS">
                <label class="form-check-label" for="hasGPS">GPS</label>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn">Register</button>
        </form>

        <!-- Login Link -->
        <p class="login-link">Already have an account? <a href="driverLogin.jsp">Login here</a></p>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>