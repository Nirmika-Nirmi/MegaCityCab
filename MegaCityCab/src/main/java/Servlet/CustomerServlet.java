package Servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Bean.CustomerBean;
import Dao.CustomerDAO;

@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CustomerServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        // Handle registration
        if ("register".equals(action)) {
            String fullName = request.getParameter("fullName");
            String address = request.getParameter("address");
            String nicNumber = request.getParameter("nicNumber");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Create a CustomerBean object and set the attributes
            CustomerBean customer = new CustomerBean();
            customer.setFullName(fullName);
            customer.setAddress(address);
            customer.setNicNumber(nicNumber);
            customer.setPhoneNumber(phoneNumber);
            customer.setEmail(email);
            customer.setPassword(password); // In production, hash the password

            // Call DAO to insert the customer into the database
            CustomerDAO dao = new CustomerDAO();
            boolean success = dao.registerCustomer(customer);

            if (success) {
                response.sendRedirect("customerLogin.jsp"); // Redirect to login page after successful registration
            } else {
                response.getWriter().println("Registration failed, try again.");
            }
        }

       
        }
    
    
 

    }

