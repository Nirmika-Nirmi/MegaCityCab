package Servlet;

import Dao.BillingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

import Bean.Billing;

@WebServlet("/AdminBookingHistoryServlet")
public class AdminBookingHistoryServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(AdminBookingHistoryServlet.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch all billing details
        BillingDAO billingDAO = new BillingDAO();
        List<Billing> billingList = billingDAO.getAllBillingDetails();

        logger.info("Fetched billing list with size: " + billingList.size());

        // Set the data in the request attribute
        request.setAttribute("billingList", billingList);

        // Forward to the JSP page
        request.getRequestDispatcher("adminBookingHistory.jsp").forward(request, response);
    }
}