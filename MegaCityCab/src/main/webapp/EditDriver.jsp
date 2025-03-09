<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Driver</title>
</head>
<body>
    <h1>Edit Driver</h1>

    <form action="DriverServlet" method="post">
        <input type="hidden" name="driverId" value="<%= request.getAttribute("driverId") %>" />
        <label for="fullName">Full Name:</label>
        <input type="text" name="fullName" value="<%= request.getAttribute("driverFullName") %>" required />

        <label for="email">Email:</label>
        <input type="email" name="email" value="<%= request.getAttribute("driverEmail") %>" required />

        <label for="phoneNumber">Phone Number:</label>
        <input type="text" name="phoneNumber" value="<%= request.getAttribute("driverPhone") %>" required />

        <label for="address">Address:</label>
        <input type="text" name="address" value="<%= request.getAttribute("driverAddress") %>" required />

        <label for="licenseNumber">License Number:</label>
        <input type="text" name="licenseNumber" value="<%= request.getAttribute("driverLicense") %>" required />

        <label for="vehicleType">Vehicle Type:</label>
        <input type="text" name="vehicleType" value="<%= request.getAttribute("driverVehicleType") %>" required />

        <label for="status">Status:</label>
        <input type="text" name="status" value="<%= request.getAttribute("driverStatus") %>" required />

        <input type="submit" value="Update Driver" />
    </form>
</body>
</html>
