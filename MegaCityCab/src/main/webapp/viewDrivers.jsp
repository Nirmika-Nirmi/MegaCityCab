<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Bean.Driver" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        .btn {
            background-color: #007BFF;
            color: white;
            padding: 5px 10px;
            text-decoration: none;
            border-radius: 3px;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .delete-btn {
            background-color: #dc3545;
        }

        .delete-btn:hover {
            background-color: #c82333;
        }

        .search-form {
            margin-top: 20px;
            text-align: center;
        }

        .search-input {
            padding: 5px;
            font-size: 16px;
        }

        .search-btn {
            padding: 5px 15px;
            font-size: 16px;
            background-color: #007BFF;
            color: white;
            border: none;
            cursor: pointer;
        }

        .search-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h1>Driver List</h1>
    
    <!-- Search Form -->
    <form action="DriverServlet" method="get" class="search-form">
        <input type="text" name="search" placeholder="Search Drivers" class="search-input" />
        <input type="submit" value="Search" class="search-btn" />
    </form>

    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Phone Number</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Driver> driverList = (List<Driver>) request.getAttribute("driverList");
                if (driverList != null && !driverList.isEmpty()) {
                    for (Driver driver : driverList) {
            %>
                <tr>
                    <td><%= driver.getDriverId() %></td>
                    <td><%= driver.getFullName() %></td>
                    <td><%= driver.getEmail() %></td>
                    <td><%= driver.getPhoneNumber() %></td>
                    <td><%= driver.getStatus() %></td>
                    <td>
                        <a href="DriverServlet?action=edit&driverId=<%= driver.getDriverId() %>" class="btn">Edit</a>
                        <a href="DriverServlet?action=delete&driverId=<%= driver.getDriverId() %>" class="btn delete-btn">Delete</a>
                    </td>
                </tr>
            <% 
                    }
                } else {
            %>
                <tr>
                    <td colspan="6">No drivers found.</td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>