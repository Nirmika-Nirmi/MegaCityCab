<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab - Welcome</title>
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
            text-align: center;
        }

        /* ======= Container ======= */
        .welcome-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* ======= Header ======= */
        h2 {
            font-size: 28px;
            font-weight: 600;
            color: #444;
            margin-bottom: 20px;
        }

        p {
            font-size: 16px;
            color: #555;
            margin-bottom: 30px;
        }

        /* ======= Button Styles ======= */
        .button {
            display: inline-block;
            padding: 15px 30px;
            font-size: 16px;
            font-weight: 500;
            color: white;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none;
            border-radius: 6px;
            text-decoration: none;
            margin: 10px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .button:hover {
            transform: translateY(-2px);
            box-shadow: 0px 5px 15px rgba(102, 126, 234, 0.4);
        }

        /* ======= Responsive Design ======= */
        @media (max-width: 480px) {
            .welcome-container {
                padding: 20px;
            }

            h2 {
                font-size: 24px;
            }

            p {
                font-size: 14px;
            }

            .button {
                padding: 12px 24px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="welcome-container">
        <h2>Welcome to Mega City Cab!</h2>
        <p>Please choose your role to proceed:</p>

        <!-- Buttons for Customer and Driver Login -->
        <a href="customerLogin.jsp" class="button">Customer Login</a>
        <a href="driverLogin.jsp" class="button">Driver Login</a>
    </div>
</body>
</html>