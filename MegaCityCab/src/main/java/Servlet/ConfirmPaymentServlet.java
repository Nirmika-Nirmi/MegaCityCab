package Servlet;

import Bean.Billing;
import Dao.BillingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ConfirmPaymentServlet")
public class ConfirmPaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            double finalAmount = Double.parseDouble(request.getParameter("finalAmount"));
            String paymentMethod = request.getParameter("paymentMethod");

            // Create Billing object
            Billing billing = new Billing();
            billing.setBookingId(bookingId);
            billing.setBillNumber("BILL-" + System.currentTimeMillis()); // Unique bill number
            billing.setFinalAmount(finalAmount);
            billing.setPaymentMethod(paymentMethod);
            billing.setPaymentStatus("Paid"); // Update payment status to "Paid"

            // Generate bill
            BillingDAO billingDAO = new BillingDAO();
            boolean billGenerated = billingDAO.generateBill(billing);

            if (billGenerated) {
                // Redirect to the driver's dashboard with a success message
                response.sendRedirect("driverDashboard.jsp?message=Payment confirmed successfully!");
            } else {
                response.sendRedirect("error.jsp?message=Failed to confirm payment");
            }
        } catch (Exception e) {
            response.sendRedirect("error.jsp?message=An unexpected error occurred");
        }
    }
}