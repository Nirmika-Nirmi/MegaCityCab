package Servlet;

import Bean.Booking;
import Dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@WebServlet("/BookCabServlet")
public class BookCabServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = (Integer) request.getSession().getAttribute("customerId");
        int driverId = Integer.parseInt(request.getParameter("driverId"));
        String pickupLocation = request.getParameter("pickupLocation");
        String dropLocation = request.getParameter("dropLocation");
        int numPassengers = Integer.parseInt(request.getParameter("numPassengers"));
        String paymentMethod = request.getParameter("paymentMethod");
        String specialRequests = request.getParameter("specialRequests");
        String pickupTimeStr = request.getParameter("pickupTime"); // Get pickup time as a string

        // Convert pickup time string to Timestamp
        Timestamp pickupTime = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            pickupTime = new Timestamp(dateFormat.parse(pickupTimeStr).getTime());
        } catch (ParseException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid pickup date and time format.");
            request.getRequestDispatcher("bookCab.jsp").forward(request, response);
            return;
        }

        // Create Booking object
        Booking booking = new Booking();
        booking.setCustomerId(customerId);
        booking.setDriverId(driverId);
        booking.setPickupLocation(pickupLocation);
        booking.setDropLocation(dropLocation);
        booking.setNumPassengers(numPassengers);
        booking.setPaymentMethod(paymentMethod);
        booking.setSpecialRequests(specialRequests);
        booking.setStatus("Pending"); // Initial status
        booking.setBookingDate(pickupTime); // Set booking date and time

        // Save booking to the database
        BookingDAO bookingDAO = new BookingDAO();
        boolean isBooked = bookingDAO.saveBooking(booking);

        if (isBooked) {
            response.sendRedirect("customer-dashboard.jsp?bookingId=" + booking.getBookingId());
        } else {
            request.setAttribute("errorMessage", "Booking failed. Please try again.");
            request.getRequestDispatcher("bookCab.jsp").forward(request, response);
        }
    }
}