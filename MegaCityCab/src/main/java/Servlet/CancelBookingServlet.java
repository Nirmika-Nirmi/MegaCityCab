package Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import Dao.BookingDAO;

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        BookingDAO bookingDAO = new BookingDAO();
        boolean isCancelled = bookingDAO.cancelBooking(bookingId);

        if (isCancelled) {
            response.sendRedirect("viewBookings.jsp?message=Booking+Cancelled+Successfully");
        } else {
            response.sendRedirect("viewBookings.jsp?error=Failed+to+Cancel+Booking");
        }
    }
}