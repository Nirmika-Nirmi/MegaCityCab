
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Login</title>
</head>
<body>
    <h2>Customer Login</h2>
    <form action="CustomerLoginServlet" method="post">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>

        <button type="submit">Login</button>
    </form>

    <%-- Display error message if login fails --%>
    <p style="color: red;">
        <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
    </p>

    <p>Don't have an account? <a href="customerRegister.jsp">Register here</a></p>
</body>
</html>
