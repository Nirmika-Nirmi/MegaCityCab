<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* ======= General Styles ======= */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }

        /* ======= Login Container ======= */
        .login-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.1);
            width: 320px;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .login-container h2 {
            margin-bottom: 20px;
            color: #444;
            font-size: 22px;
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
            padding: 10px 40px 10px 40px; /* Adjusted padding for icons */
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
            top: 50%;
            transform: translateY(-50%);
            color: #888;
            font-size: 16px;
        }

        .input-group .fa-envelope {
            right: 10px; 
            bottom:60px;
            color: #667eea;
        }

        .input-group .fa-lock {
            right: 10px;
            bottum:60px; 
            color: #667eea;
        }

        /* ======= Button ======= */
        .btn {
            width: 100%;
            padding: 10px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-weight: 500;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            font-size: 14px;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0px 5px 15px rgba(102, 126, 234, 0.4);
        }

        /* ======= Error Message ======= */
        .error-message {
            color: #ff4757;
            margin-top: 10px;
            font-size: 13px;
            font-weight: 500;
        }

        /* ======= Responsive Design ======= */
        @media (max-width: 480px) {
            .login-container {
                width: 90%;
                padding: 20px;
            }
        }
    </style>
</head>
<body>

    <div class="login-container">
        <h2>Admin Login</h2>
        <form action="AdminLoginServlet" method="POST">
            <!-- Email Input -->
            <div class="input-group">
                <label>Email</label>
                <input type="email" name="email" placeholder="Enter your email" required>
                <i class="fas fa-envelope"></i>
            </div>

            <!-- Password Input -->
            <div class="input-group">
                </i><label>Password</label>
                <input type="password" name="password" id="password" placeholder="Enter your password" required>
                <i class="fas fa-lock" ></i>
            </div>

            <!-- Login Button -->
            <button type="submit" class="btn">Login</button>
        </form>

        <%-- Display error message if login fails --%>
        <% String errorMessage = (String) request.getAttribute("errorMessage"); 
           if (errorMessage != null) { %>
            <p class="error-message"><%= errorMessage %></p>
        <% } %>
    </div>



</body>
</html>