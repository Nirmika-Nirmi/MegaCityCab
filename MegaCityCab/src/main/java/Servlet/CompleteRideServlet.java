package Servlet;

import Dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CompleteRideServlet")
public class CompleteRideServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        double fare = Double.parseDouble(request.getParameter("fare"));

        BookingDAO bookingDAO = new BookingDAO();
        boolean success = bookingDAO.completeRide(bookingId, fare);

        if (success) {
            response.sendRedirect("driverDashboard.jsp");
        } else {
            response.sendRedirect("error.jsp?message=Failed to complete ride");
        }
    }
}