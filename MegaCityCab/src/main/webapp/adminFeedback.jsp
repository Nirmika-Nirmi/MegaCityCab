<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Bean.Feedback, Dao.FeedbackDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Feedback</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>Driver Feedback</h1>
        <table class="table">
            <thead>
                <tr>
                    <th>Feedback ID</th>
                    <th>Booking ID</th>
                    <th>Driver ID</th>
                    <th>Customer ID</th>
                    <th>Rating</th>
                    <th>Comments</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    FeedbackDAO feedbackDAO = new FeedbackDAO();
                    List<Feedback> feedbackList = feedbackDAO.getAllFeedback();

                    for (Feedback feedback : feedbackList) {
                %>
                    <tr>
                        <td><%= feedback.getFeedbackId() %></td>
                        <td><%= feedback.getBookingId() %></td>
                        <td><%= feedback.getDriverId() %></td>
                        <td><%= feedback.getCustomerId() %></td>
                        <td><%= feedback.getRating() %></td>
                        <td><%= feedback.getComments() %></td>
                        <td><%= feedback.getFeedbackDate() %></td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>