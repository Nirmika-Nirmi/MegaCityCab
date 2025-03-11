package Servlet;

import Bean.Billing;
import Dao.BillingDAO;
import Dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CalculateBillServlet")
public class CalculateBillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
  
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            double startKm = Double.parseDouble(request.getParameter("startingMeter"));
            double endKm = Double.parseDouble(request.getParameter("endingMeter"));
            

            // Fetch ride details
            BookingDAO bookingDAO = new BookingDAO();
            String customerName = bookingDAO.getCustomerNameByBookingId(bookingId);
            String customerPhone = bookingDAO.getCustomerPhoneByBookingId(bookingId);
            String pickupLocation = request.getParameter("pickupLocation");
            String dropLocation = request.getParameter("dropLocation");
            String paymentMethod = request.getParameter("paymentMethod");
            // Calculate fare
            double perKmRate = 2.50; // Default rate per km
            double distance = endKm - startKm;
            double baseFare = distance * perKmRate;
            double discount = 0.00; // No discount by default
            double finalAmount = baseFare - discount;

            // Store payment details in the request
            request.setAttribute("bookingId", bookingId);
            request.setAttribute("customerName", customerName);
            request.setAttribute("customerPhone", customerPhone);
            request.setAttribute("pickupLocation", pickupLocation);
            request.setAttribute("dropLocation", dropLocation);
            request.setAttribute("paymentMethod", paymentMethod);
            request.setAttribute("distance", distance);
            request.setAttribute("startingMeter", startKm);
            request.setAttribute("endingMeter", endKm);
            request.setAttribute("finalAmount", finalAmount);


            // Forward to the payment confirmation page
            request.getRequestDispatcher("paymentConfirmation.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp?message=Invalid input format");
        } catch (Exception e) {
            response.sendRedirect("error.jsp?message=An unexpected error occurred");
        }
    }
}