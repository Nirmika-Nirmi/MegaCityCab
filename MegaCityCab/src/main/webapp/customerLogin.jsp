<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Login</title>
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
        }

        /* ======= Register Link ======= */
        .register-link {
            margin-top: 15px;
            font-size: 14px;
            color: #555;
        }

        .register-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }

        .register-link a:hover {
            text-decoration: underline;
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

    <!-- Login Container -->
    <div class="login-container">
        <h2>Customer Login</h2>
        <form action="CustomerLoginServlet" method="post">
            <!-- Email Input -->
            <div class="input-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
                <i class="fas fa-envelope"></i>
            </div>

            <!-- Password Input -->
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
                <i class="fas fa-lock"></i>
            </div>

            <!-- Login Button -->
            <button type="submit" class="btn">Login</button>
        </form>

        <!-- Error Message -->
        <p class="error-message">
            <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
        </p>

        <!-- Register Link -->
        <p class="register-link">Don't have an account? <a href="customerRegister.jsp">Register here</a></p>
    </div>

</body>
</html>