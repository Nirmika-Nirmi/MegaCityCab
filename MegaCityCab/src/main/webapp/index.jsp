<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab - Welcome</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 150px;
        }
        .button {
            padding: 15px 30px;
            font-size: 18px;
            margin: 20px;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            margin-top: 30px;
        }
        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h2>Welcome to Mega City Cab!</h2>
    <p>Please choose your role to proceed:</p><br>
    
    <!-- Buttons for Customer and Driver Login -->
    <a href="customerLogin.jsp" class="button">Customer Login</a><br><br><br><br>
    <a href="driverLogin.jsp" class="button">Driver Login</a><br>
    

</body>
</html>
