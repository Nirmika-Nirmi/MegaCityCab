package Servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Dao.CustomerDAO;

@WebServlet("/CustomerLoginServlet")
public class CustomerLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CustomerLoginServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        CustomerDAO dao = new CustomerDAO();
        boolean isValid = dao.validateCustomerLogin(email, password);

        if (isValid) {
            // Fetch the customer ID after successful login
            int customerId = dao.getCustomerIdByEmail(email);
            HttpSession session = request.getSession();
            session.setAttribute("customerId", customerId); // Store customerId in session

            System.out.println("Customer ID after login: " + customerId); // Debugging log

            // Redirect to the Customer Dashboard
            response.sendRedirect("CustomerDashboardServlet");
        } else {
            // Show error message if login fails
            request.setAttribute("errorMessage", "Invalid credentials. Please try again.");
            request.getRequestDispatcher("customerLogin.jsp").forward(request, response);
        }
    }
    }

