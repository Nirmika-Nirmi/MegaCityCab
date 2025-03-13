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
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        /* ======= General Styles ======= */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f4f7fa, #e8eef7);
            margin: 0;
            padding: 20px;
            color: #333;
        }

        /* ======= Header ======= */
        h1 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 28px;
            font-weight: 600;
            color: #444;
        }

        /* ======= Search Form ======= */
        .search-form {
            margin-bottom: 20px;
            text-align: center;
        }

        .search-form input[type="text"] {
            padding: 10px;
            width: 300px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }

        .search-form input[type="text"]:focus {
            border-color: #667eea;
            outline: none;
        }

        .search-form button {
            padding: 10px 20px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .search-form button:hover {
            transform: translateY(-2px);
            box-shadow: 0px 5px 15px rgba(102, 126, 234, 0.4);
        }

        /* ======= Table Styles ======= */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            font-weight: 500;
        }

        tr:hover {
            background-color: rgba(102, 126, 234, 0.05);
        }

        /* ======= Button Styles ======= */
        .btn {
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 6px;
            text-decoration: none;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0px 5px 15px rgba(102, 126, 234, 0.4);
        }

        /* ======= Responsive Design ======= */
        @media (max-width: 768px) {
            .search-form input[type="text"] {
                width: 100%;
                margin-bottom: 10px;
            }

            table {
                font-size: 14px;
            }

            th, td {
                padding: 8px;
            }
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
                        <a href="DriverServlet?action=edit&driverId=<%= driver.getDriverId() %>" class="btn btn-primary">Edit</a>
                        <a href="DriverServlet?action=delete&driverId=<%= driver.getDriverId() %>" class="btn btn-danger">Delete</a>
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

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>