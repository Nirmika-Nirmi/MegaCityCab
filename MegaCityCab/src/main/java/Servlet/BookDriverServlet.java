package Servlet;

import Bean.Booking;
import Dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/BookDriverServlet")
public class BookDriverServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        int driverId = Integer.parseInt(request.getParameter("driverId"));
        String pickupLocation = request.getParameter("pickupLocation");
        String dropLocation = request.getParameter("dropLocation");
        int numPassengers = Integer.parseInt(request.getParameter("numPassengers"));
        String paymentMethod = request.getParameter("paymentMethod"); // Retrieve payment method

        // Create Booking object
        Booking booking = new Booking();
        booking.setCustomerId(customerId);
        booking.setDriverId(driverId);
        booking.setPickupLocation(pickupLocation);
        booking.setDropLocation(dropLocation);
        booking.setNumPassengers(numPassengers);
        booking.setPaymentMethod(paymentMethod); // Set payment method
        booking.setStatus("Pending"); // Booking is initially pending

        // Save booking to database
        BookingDAO bookingDAO = new BookingDAO();
        boolean isBooked = bookingDAO.saveBooking(booking);

        if (isBooked) {
            request.setAttribute("successMessage", "Booking request sent to the driver.");
        } else {
            request.setAttribute("errorMessage", "Failed to book the driver. Please try again.");
        }

        // Redirect to the customer dashboard
        request.getRequestDispatcher("customer-dashboard.jsp").forward(request, response);
    }
}