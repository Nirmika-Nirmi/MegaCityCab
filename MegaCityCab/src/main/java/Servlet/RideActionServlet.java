package Servlet;

import Dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RideActionServlet")
public class RideActionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String action = request.getParameter("action"); // "accept", "reject", or "complete"

        BookingDAO bookingDAO = new BookingDAO();
        boolean success = false;

        switch (action) {
            case "accept":
                success = bookingDAO.acceptRide(bookingId);
                break;
            case "reject":
                success = bookingDAO.rejectRide(bookingId);
                break;
            case "complete":
                // Redirect to calculate fare page
                response.sendRedirect("calculateFare.jsp?bookingId=" + bookingId);
                return;
        }

        if (success) {
            response.sendRedirect("driverDashboard.jsp");
        } else {
            response.sendRedirect("error.jsp?message=Failed to process ride action");
        }
    }
}