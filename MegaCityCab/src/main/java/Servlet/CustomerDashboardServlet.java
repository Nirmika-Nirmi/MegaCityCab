package Servlet;

import java.io.IOException;
import Bean.CustomerBean;
import Dao.BookingDAO;
import Dao.CustomerDashboardDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CustomerDashboardServlet")
public class CustomerDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CustomerDashboardDao customerDAO = new CustomerDashboardDao();
    private BookingDAO bookingDAO = new BookingDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");

        if (customerId == null) {
            response.sendRedirect("customerLogin.jsp"); // Redirect to login if session is invalid
            return;
        }

        System.out.println("Customer ID in session: " + customerId); // Debugging log

        // Fetch customer details and set session attributes
        CustomerBean customer = customerDAO.getCustomerById(customerId);
        if (customer != null) {
            session.setAttribute("fullName", customer.getFullName());
            session.setAttribute("email", customer.getEmail());
            session.setAttribute("phone", customer.getPhoneNumber());
        }

        // Fetch upcoming bookings count
        int upcomingBookingsCount = bookingDAO.getUpcomingBookingsCount(customerId);
        session.setAttribute("upcomingBookingsCount", upcomingBookingsCount);

        request.getRequestDispatcher("/customer-dashboard.jsp").forward(request, response);
    }
}