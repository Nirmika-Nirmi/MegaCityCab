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
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/ConfirmPaymentServlet")
public class ConfirmPaymentServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(ConfirmPaymentServlet.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve parameters from the request
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            double startKm = Double.parseDouble(request.getParameter("startingMeter"));
            double endKm = Double.parseDouble(request.getParameter("endingMeter"));
            double distance = Double.parseDouble(request.getParameter("distance"));
            double finalAmount = Double.parseDouble(request.getParameter("finalAmount"));
            String paymentMethod = request.getParameter("paymentMethod");
            String customerName = request.getParameter("customerName");
            String customerPhone = request.getParameter("customerPhone");
            String pickupLocation = request.getParameter("pickupLocation");
            String dropLocation = request.getParameter("dropLocation");

            // Fetch driver details from the database
            BookingDAO bookingDAO = new BookingDAO();
            String driverName = bookingDAO.getDriverNameByBookingId(bookingId);
            String driverPhone = bookingDAO.getDriverPhoneByBookingId(bookingId);

            // Create and populate the Billing object
            Billing billing = new Billing();
            billing.setBookingId(bookingId);
            billing.setCustomerId(bookingDAO.getCustomerIdByBookingId(bookingId));
            billing.setDriverId(bookingDAO.getDriverIdByBookingId(bookingId));
            billing.setBillNumber("BILL-" + System.currentTimeMillis());
            billing.setCustomerName(customerName);
            billing.setCustomerPhone(customerPhone);
            billing.setDriverName(driverName);
            billing.setDriverPhone(driverPhone);
            billing.setPickupLocation(pickupLocation);
            billing.setDropLocation(dropLocation);
            billing.setDistance(distance); // Set distance
            billing.setStartingMeter(startKm); // Set starting meter
            billing.setEndingMeter(endKm); // Set ending meter
            billing.setFinalAmount(finalAmount);
            billing.setPaymentMethod(paymentMethod);
            billing.setPaymentStatus("Paid");

            // Save bill to the database
            BillingDAO billingDAO = new BillingDAO();
            boolean billGenerated = billingDAO.generateBill(billing);

            if (billGenerated) {
                // Redirect to paymentSuccess.jsp with parameters
                response.sendRedirect("paymentSuccess.jsp?bookingId=" + bookingId +
                        "&distance=" + distance +
                        "&startingMeter=" + startKm +
                        "&endingMeter=" + endKm +
                        "&finalAmount=" + finalAmount +
                        "&paymentMethod=" + paymentMethod +
                        "&customerName=" + customerName +
                        "&customerPhone=" + customerPhone +
                        "&pickupLocation=" + pickupLocation +
                        "&dropLocation=" + dropLocation);
            } else {
                response.sendRedirect("error.jsp?message=Failed to generate bill");
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "An unexpected error occurred: " + e.getMessage(), e);
            response.sendRedirect("error.jsp?message=An unexpected error occurred");
        }
    }
}