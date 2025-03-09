<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Login</title>
</head>
<body>
    <h2>Driver Login</h2>
    <form action="${pageContext.request.contextPath}/loginDriver" method="post">
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required>
    <br>
    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required>
    <br>
    <button type="submit">Login</button>
</form>

    <p>Don't have an account? <a href="driverRegister.jsp">Register here</a></p>
</body>
</html>
