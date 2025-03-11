<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Bean.Billing, Dao.DriverDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Earnings History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>Earnings History</h1>

        <%
            // Retrieve driver ID from session
            Integer driverId = (Integer) session.getAttribute("driverId");
            if (driverId == null) {
                out.println("<p class='alert alert-danger'>Driver ID not found in session. Please <a href='driverLogin.jsp'>log in again</a>.</p>");
            } else {
                // Fetch earnings history for the driver
                DriverDAO driverDAO = new DriverDAO();
                List<Billing> earnings = driverDAO.getEarningsHistory(driverId);

                if (earnings.isEmpty()) {
                    out.println("<p class='alert alert-info'>No earnings found.</p>");
                } else {
        %>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Bill Number</th>
                                <th>Amount</th>
                                <th>Payment Method</th>
                                <th>Status</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Billing billing : earnings) {
                            %>
                                <tr>
                                    <td><%= billing.getBillNumber() %></td>
                                    <td>$<%= billing.getFinalAmount() %></td>
                                    <td><%= billing.getPaymentMethod() %></td>
                                    <td><%= billing.getPaymentStatus() %></td>
                                    <td><%= billing.getBillDate() %></td>
                                </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
        <%
                }
            }
        %>
    </div>
</body>
</html>