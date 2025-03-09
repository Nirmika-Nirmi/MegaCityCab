<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
</head>
<body>
    <h2>Admin Login</h2>
    <form action="AdminLoginServlet" method="POST">
        <label>Email:</label>
        <input type="email" name="email" required><br>

        <label>Password:</label>
        <input type="password" name="password" required><br>

        <button type="submit">Login</button>
    </form>

    <%-- Display error message if login fails --%>
    <% String errorMessage = (String) request.getAttribute("errorMessage"); 
       if (errorMessage != null) { %>
        <p style="color: red;"><%= errorMessage %></p>
    <% } %>
</body>
</html>
