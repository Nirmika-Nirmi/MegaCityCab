<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <!-- FontAwesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
            max-width: 400px;
            text-align: center;
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
        }

        /* ======= Input Groups ======= */
        .input-group {
            text-align: left;
            margin-bottom: 15px;
            position: relative;
        }

        .input-group label {
            display: block;
            font-weight: 500;
            margin-bottom: 5px;
            color: #555;
            font-size: 14px;
        }

        .input-group input {
            width: 100%;
            padding: 10px 10px 10px 40px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            transition: border-color 0.3s ease;
            box-sizing: border-box;
        }

        .input-group input:focus {
            border-color: #667eea;
            outline: none;
        }

        .input-group i {
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

        /* ======= Error Message ======= */
        .error-message {
            color: #ff4757;
            margin-top: 10px;
            font-size: 14px;
            font-weight: 500;
            display: none;
        }

        /* ======= Login Link ======= */
        .login-link {
            margin-top: 15px;
            font-size: 14px;
            color: #555;
        }

        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        /* ======= Success Message ======= */
        .success-message {
            color: #28a745;
            margin-top: 15px;
            font-size: 14px;
            font-weight: 500;
            display: none;
        }

        /* ======= Responsive Design ======= */
        @media (max-width: 480px) {
            .registration-container {
                padding: 20px;
            }

            .registration-container h2 {
                font-size: 22px;
            }

            .input-group input {
                padding: 8px 8px 8px 35px;
                font-size: 13px;
            }

            .input-group i {
                font-size: 14px;
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

    <!-- Registration Container -->
    <div class="registration-container">
        <h2>Customer Registration</h2>
        <form action="CustomerServlet" method="post" onsubmit="return validateForm();">
            <input type="hidden" name="action" value="register">

            <!-- Full Name -->
            <div class="input-group">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName" placeholder="Enter your full name" required>
                <i class="fas fa-user"></i>
            </div>

            <!-- Address -->
            <div class="input-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" placeholder="Enter your address" required>
                <i class="fas fa-map-marker-alt"></i>
            </div>

            <!-- NIC Number -->
            <div class="input-group">
                <label for="nicNumber">NIC Number</label>
                <input type="text" id="nicNumber" name="nicNumber" placeholder="Enter your NIC number" pattern="\d{9}[Vv]|\d{12}" required>
                <i class="fas fa-id-card"></i>
            </div>

            <!-- Phone Number -->
            <div class="input-group">
                <label for="phoneNumber">Phone Number</label>
                <input type="text" id="phoneNumber" name="phoneNumber" placeholder="Enter your phone number" pattern="\d{10}" required>
                <i class="fas fa-phone"></i>
            </div>

            <!-- Email -->
            <div class="input-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
                <i class="fas fa-envelope"></i>
            </div>

            <!-- Password -->
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
                <i class="fas fa-lock"></i>
            </div>

            <!-- Confirm Password -->
            <div class="input-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
                <i class="fas fa-lock"></i>
            </div>
            <div id="passwordError" class="error-message">Passwords do not match!</div>

            <!-- Submit Button -->
            <button type="submit" class="btn">Register</button>
        </form>

        <!-- Login Link -->
        <p class="login-link">Already have an account? <a href="customerLogin.jsp">Login here</a></p>

        <!-- Success Message -->
        <p id="successMessage" class="success-message">Registration successful! Please <a href="customerLogin.jsp">login</a>.</p>
    </div>

</body>
</html>