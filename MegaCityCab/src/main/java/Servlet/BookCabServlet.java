package Servlet;

import Bean.Booking;
import Dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/BookCabServlet")
public class BookCabServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

 // BookCabServlet.java
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = (Integer) request.getSession().getAttribute("customerId");
        int driverId = Integer.parseInt(request.getParameter("driverId"));
        String pickupLocation = request.getParameter("pickupLocation");
        String dropLocation = request.getParameter("dropLocation");
        int numPassengers = Integer.parseInt(request.getParameter("numPassengers"));
        String paymentMethod = request.getParameter("paymentMethod");
        String specialRequests = request.getParameter("specialRequests");

        Booking booking = new Booking();
        booking.setCustomerId(customerId);
        booking.setDriverId(driverId);
        booking.setPickupLocation(pickupLocation);
        booking.setDropLocation(dropLocation);
        booking.setNumPassengers(numPassengers);
        booking.setPaymentMethod(paymentMethod);
        booking.setSpecialRequests(specialRequests);
        booking.setStatus("Pending"); // Initial status

        BookingDAO bookingDAO = new BookingDAO();
        boolean isBooked = bookingDAO.saveBooking(booking);

        if (isBooked) {
            response.sendRedirect("payment.jsp?bookingId=" + booking.getBookingId());
        } else {
            request.setAttribute("errorMessage", "Booking failed. Please try again.");
            request.getRequestDispatcher("bookCab.jsp").forward(request, response);
        }
    }
}