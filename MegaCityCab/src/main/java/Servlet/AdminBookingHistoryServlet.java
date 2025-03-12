package Servlet;

import Dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import Bean.Booking;

@WebServlet("/AdminBookingHistoryServlet")
public class AdminBookingHistoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch all bookings with payment details
        BookingDAO bookingDAO = new BookingDAO();
        List<Booking> bookings = bookingDAO.getAllBookingsWithPayments();

        // Set the data in the request attribute
        request.setAttribute("bookings", bookings);

        // Forward to the JSP page
        request.getRequestDispatcher("adminBookingHistory.jsp").forward(request, response);
    }
}