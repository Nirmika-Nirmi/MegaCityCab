package Servlet;

import Dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CalculateBillServlet")
public class CalculateBillServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve parameters from the request
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            double startKm = Double.parseDouble(request.getParameter("startingMeter"));
            double endKm = Double.parseDouble(request.getParameter("endingMeter"));
            String customerName = request.getParameter("customerName");
            String customerPhone = request.getParameter("customerPhone");
            String pickupLocation = request.getParameter("pickupLocation");
            String dropLocation = request.getParameter("dropLocation");
            String paymentMethod = request.getParameter("paymentMethod");

            // Calculate distance
            double distance = endKm - startKm;

            // Calculate fare (example: $2.50 per km)
            double perKmRate = 2.50;
            double finalAmount = distance * perKmRate;

            // Set attributes for the next page
            request.setAttribute("bookingId", bookingId);
            request.setAttribute("customerName", customerName);
            request.setAttribute("customerPhone", customerPhone);
            request.setAttribute("pickupLocation", pickupLocation);
            request.setAttribute("dropLocation", dropLocation);
            request.setAttribute("startingMeter", startKm);
            request.setAttribute("endingMeter", endKm);
            request.setAttribute("distance", distance);
            request.setAttribute("finalAmount", finalAmount);
            request.setAttribute("paymentMethod", paymentMethod);

            // Forward to the payment confirmation page
            request.getRequestDispatcher("paymentConfirmation.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect("error.jsp?message=An unexpected error occurred");
        }
    }
}