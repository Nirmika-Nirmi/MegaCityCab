<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calculate Fare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>Calculate Fare</h1>
        <form action="CompleteRideServlet" method="post">
            <input type="hidden" name="bookingId" value="<%= request.getParameter("bookingId") %>" />
            <div class="mb-3">
                <label for="fare" class="form-label">Fare:</label>
                <input type="number" step="0.01" name="fare" id="fare" class="form-control" required />
            </div>
            <button type="submit" class="btn btn-primary">Submit Fare</button>
        </form>
    </div>
</body>
</html>