<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Bean.CustomerBean" %>
<%@ page import="Dao.CustomerDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Customers</title>
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
            padding: 0;
            color: #333;
        }

        /* ======= Container ======= */
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
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
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .table th, .table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table th {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            font-weight: 500;
        }

        .table tbody tr:hover {
            background-color: rgba(102, 126, 234, 0.05);
        }

        /* ======= Button Styles ======= */
        .btn {
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 6px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            border: none;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(220, 53, 69, 0.3);
        }

        /* ======= No Data Message ======= */
        .no-data {
            text-align: center;
            padding: 20px;
            color: #777;
        }

        /* ======= Responsive Design ======= */
        @media (max-width: 768px) {
            .container {
                margin: 10px;
                padding: 15px;
            }

            h1 {
                font-size: 24px;
            }

            .search-form input[type="text"] {
                width: 100%;
            }

            .table th, .table td {
                padding: 8px;
                font-size: 14px;
            }

            .btn {
                padding: 5px 10px;
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Customer List</h1>

        <!-- Search Form -->
        <form action="ViewCustomersServlet" method="get" class="search-form">
            <input type="text" name="search" placeholder="Search by name, email, or phone..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
            <button type="submit">Search</button>
        </form>

        <!-- Fetch the list of customers from the database -->
        <%
            CustomerDAO customerDAO = new CustomerDAO();
            List<CustomerBean> customers;

            // Check if a search query is provided
            String searchQuery = request.getParameter("search");
            if (searchQuery != null && !searchQuery.isEmpty()) {
                // Perform search
                customers = customerDAO.searchCustomers(searchQuery);
            } else {
                // Fetch all customers
                customers = customerDAO.getAllCustomers();
            }
        %>

        <!-- Display the list of customers in a table -->
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Phone Number</th>
                    <th>Address</th>
                    <th>NIC</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (customers != null && !customers.isEmpty()) {
                        for (CustomerBean customer : customers) {
                %>
                    <tr>
                        <td><%= customer.getCustomerId() %></td>
                        <td><%= customer.getFullName() %></td>
                        <td><%= customer.getEmail() %></td>
                        <td><%= customer.getPhoneNumber() %></td>
                        <td><%= customer.getAddress() %></td>
                        <td><%= customer.getNicNumber() %></td>
                        <td><%= customer.getStatus() %></td>
                        <td>
                            <a href="ViewCustomersServlet?action=delete&customerId=<%= customer.getCustomerId() %>" class="btn btn-danger">Delete</a>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="8" class="no-data">No customers found.</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>