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
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        // Create a CustomerBean object
        CustomerBean customer = new CustomerBean();
        customer.setCustomerId(customerId);
        customer.setFullName(fullName);
        customer.setEmail(email);
        customer.setPhoneNumber(phoneNumber);
        customer.setAddress(address);
        customer.setNicNumber(nicNumber);

        // Update the customer's profile in the database
        CustomerDAO customerDAO = new CustomerDAO();
        boolean isUpdated = customerDAO.updateCustomer(customer, currentPassword, newPassword);

        if (isUpdated) {
            // Redirect to the customer profile page with a success message
            response.sendRedirect("editCustomerProfile.jsp?message=Profile+Updated+Successfully");
        } else {
            // Redirect back to the edit profile page with an error message
            request.setAttribute("errorMessage", "Failed to update profile. Please check your current password.");
            request.getRequestDispatcher("editCustomerProfile.jsp").forward(request, response);
        }
    }
}