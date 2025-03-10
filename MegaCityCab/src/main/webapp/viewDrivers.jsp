<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Bean.Driver" %>
<%@ page import="Dao.DriverDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Drivers</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .search-form {
            margin-bottom: 20px;
            text-align: center;
        }
        .search-form input[type="text"] {
            padding: 8px;
            width: 300px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .search-form button {
            padding: 8px 16px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .search-form button:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
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
    </style>
</head>
<body>
    <h1>Driver List</h1>

    <!-- Search Form -->
    <form action="DriverServlet" method="get" class="search-form">
        <input type="text" name="search" placeholder="Search by name, email, or phone..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
        <button type="submit">Search</button>
    </form>

    <!-- Fetch the list of drivers from the database -->
    <%
        DriverDAO driverDAO = new DriverDAO();
        List<Driver> driverList;

        // Check if a search query is provided
        String searchQuery = request.getParameter("search");
        if (searchQuery != null && !searchQuery.isEmpty()) {
            // Perform search
            driverList = driverDAO.searchDrivers(searchQuery);
        } else {
            // Fetch all drivers
            driverList = driverDAO.getAllDrivers();
        }
    %>

    <!-- Display the list of drivers in a table -->
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Phone Number</th>
                <th>Address</th>
                <th>NIC</th>
                <th>License Number</th>
                <th>Status</th>
                <th>Average Rating</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (driverList != null && !driverList.isEmpty()) {
                    for (Driver driver : driverList) {
            %>
                <tr>
                    <td><%= driver.getDriverId() %></td>
                    <td><%= driver.getFullName() %></td>
                    <td><%= driver.getEmail() %></td>
                    <td><%= driver.getPhoneNumber() %></td>
                    <td><%= driver.getAddress() %></td>
                    <td><%= driver.getNicNumber() %></td>
                    <td><%= driver.getLicenseNumber() %></td>
                    <td><%= driver.getStatus() %></td>
                    <td><%= driver.getAverageRating() %></td>
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
                    <td colspan="10" style="text-align: center;">No drivers found.</td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>