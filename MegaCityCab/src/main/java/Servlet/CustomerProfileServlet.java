package Servlet;

import Bean.CustomerBean;
import Dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CustomerProfileServlet")
public class CustomerProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String nicNumber = request.getParameter("nicNumber");
        String password = request.getParameter("password"); // Retrieve password

        // Create a CustomerBean object
        CustomerBean customer = new CustomerBean();
        customer.setCustomerId(customerId);
        customer.setFullName(fullName);
        customer.setEmail(email);
        customer.setPhoneNumber(phoneNumber);
        customer.setAddress(address);
        customer.setNicNumber(nicNumber);
        customer.setPassword(password); // Set password

        // Update the customer's profile in the database
        CustomerDAO customerDAO = new CustomerDAO();
        boolean isUpdated = customerDAO.updateCustomer(customer);

        if (isUpdated) {
            // Redirect to the customer dashboard with a success message
            response.sendRedirect("customer-dashboard.jsp?message=Profile+Updated+Successfully");
        } else {
            // Redirect back to the edit profile page with an error message
            response.sendRedirect("customerProfile.jsp?error=Failed+to+Update+Profile");
        }
    }
}