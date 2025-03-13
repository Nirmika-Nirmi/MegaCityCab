package Servlet;

import Dao.BillingDAO;
import Dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import Bean.Billing;
import Bean.Booking;

@WebServlet("/AdminBookingHistoryServlet")
public class AdminBookingHistoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch all billing details
        BillingDAO billingDAO = new BillingDAO();
        List<Billing> billingList = billingDAO.getAllBillingDetails();

        // Debug: Print the size of the billing list
        System.out.println("Number of billing records fetched: " + billingList.size());

        // Debug: Print the first few records (if any)
        if (!billingList.isEmpty()) {
            for (Billing billing : billingList) {
                System.out.println("Bill ID: " + billing.getBillId() + ", Customer: " + billing.getCustomerName());
            }
        }

        // Set the data in the request attribute
        request.setAttribute("billingList", billingList);

        // Forward to the JSP page
        request.getRequestDispatcher("adminBookingHistory.jsp").forward(request, response);
    }
}