<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        form {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            font-size: 14px;
        }
    </style>
    <script>
        function validateForm() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            var errorDiv = document.getElementById("passwordError");

            if (password !== confirmPassword) {
                errorDiv.style.display = "block";
                return false;
            } else {
                errorDiv.style.display = "none";
                return true;
            }
        }
    </script>
</head>
<body>
    <h2>Customer Registration</h2>
    <form action="CustomerServlet" method="post" onsubmit="return validateForm();">
        <input type="hidden" name="action" value="register">

        <!-- Full Name -->
        <label for="fullName">Full Name:</label>
        <input type="text" id="fullName" name="fullName" required><br>

        <!-- Address -->
        <label for="address">Address:</label>
        <input type="text" id="address" name="address" required><br>

        <!-- NIC Number -->
        <label for="nicNumber">NIC Number:</label>
        <input type="text" id="nicNumber" name="nicNumber" pattern="\d{9}[Vv]|\d{12}" required><br>

        <!-- Phone Number -->
        <label for="phoneNumber">Phone Number:</label>
        <input type="text" id="phoneNumber" name="phoneNumber" pattern="\d{10}" required><br>

        <!-- Email -->
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>

        <!-- Password -->
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>

        <!-- Confirm Password -->
        <label for="confirmPassword">Confirm Password:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required><br>
        <div id="passwordError" class="error" style="display: none;">Passwords do not match!</div>

        <!-- Submit Button -->
        <button type="submit">Register</button>
    </form>

    <p>Already have an account? <a href="customerLogin.jsp">Login here</a></p>
    <p id="successMessage" style="color: green; display: none;">Registration successful! Please <a href="customerLogin.jsp">login</a>.</p>
</body>
</html>