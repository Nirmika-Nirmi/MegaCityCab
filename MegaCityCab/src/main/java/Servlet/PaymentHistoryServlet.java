package Servlet;

import Bean.Billing;
import Dao.BillingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/PaymentHistoryServlet")
public class PaymentHistoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");

        if (customerId == null) {
            response.sendRedirect("customerLogin.jsp"); // Redirect to login if session is invalid
            return;
        }

        // Fetch payment history for the customer
        BillingDAO billingDAO = new BillingDAO();
        List<Billing> paymentHistory = billingDAO.getPaymentHistoryByCustomerId(customerId);

        // Set payment history as a request attribute
        request.setAttribute("paymentHistory", paymentHistory);

        // Forward to the payment history page
        request.getRequestDispatcher("paymentHistory.jsp").forward(request, response);
    }
}