<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Bean.Driver" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Driver</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 20px; }
        h1 { text-align: center; color: #333; }
        form { max-width: 500px; margin: 0 auto; background-color: #fff; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }
        label { display: block; margin-bottom: 8px; font-weight: bold; }
        input[type="text"], input[type="email"], input[type="number"] { width: 100%; padding: 8px; margin-bottom: 15px; border: 1px solid #ddd; border-radius: 4px; }
        button { background-color: #4CAF50; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background-color: #45a049; }
    </style>
</head>
<body>
    <h1>Edit Driver</h1>
    <form action="DriverServlet" method="post">
    <input type="hidden" name="driverId" value="${driver.driverId}">
    <label for="fullName">Full Name:</label>
    <input type="text" id="fullName" name="fullName" value="${driver.fullName}" required><br>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" value="${driver.email}" required><br>

    <label for="phoneNumber">Phone Number:</label>
    <input type="text" id="phoneNumber" name="phoneNumber" value="${driver.phoneNumber}" required><br>

    <label for="address">Address:</label>
    <input type="text" id="address" name="address" value="${driver.address}" required><br>

    <label for="licenseNumber">License Number:</label>
    <input type="text" id="licenseNumber" name="licenseNumber" value="${driver.licenseNumber}" required><br>

    <label for="status">Status:</label>
    <input type="text" id="status" name="status" value="${driver.status}" required><br>

    <button type="submit">Update Driver</button>
</form>
</body>
</html>