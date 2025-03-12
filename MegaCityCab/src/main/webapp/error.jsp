<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>Error</h1>
        <p class="alert alert-danger">
            <%= request.getParameter("message") != null ? request.getParameter("message") : "An unexpected error occurred." %>
        </p>
        <a href="index.jsp" class="btn btn-primary">Go Back</a>
    </div>
</body>
</html>