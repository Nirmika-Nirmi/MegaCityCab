package Servlet;

import Dao.CustomerDAO;
import Bean.CustomerBean;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/ViewCustomersServlet")
public class ViewCustomersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the action parameter from the request
        String action = request.getParameter("action");

        // Handle delete action
        if ("delete".equals(action)) {
            deleteCustomer(request, response);
        } else {
            // Default action: display customers
            displayCustomers(request, response);
        }
    }

    // Method to display customers
    private void displayCustomers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch the list of customers from the database
        CustomerDAO customerDAO = new CustomerDAO();
        List<CustomerBean> customers;

        // Check if a search query is provided
        String searchQuery = request.getParameter("search");
        if (searchQuery != null && !searchQuery.isEmpty()) {
            // Perform search
            customers = customerDAO.searchCustomers(searchQuery);
        } else {
            // Fetch all customers
            customers = customerDAO.getAllCustomers();
        }

        // Set the list of customers as a request attribute
        request.setAttribute("customers", customers);

        // Forward the request to the viewCustomers.jsp page
        request.getRequestDispatcher("viewCustomers.jsp").forward(request, response);
    }

    // Method to delete a customer
    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the customer ID from the request
        int customerId = Integer.parseInt(request.getParameter("customerId"));

        // Delete the customer from the database
        CustomerDAO customerDAO = new CustomerDAO();
        boolean isDeleted = customerDAO.deleteCustomer(customerId);

        // Redirect to the ViewCustomersServlet after deletion
        if (isDeleted) {
            response.sendRedirect("ViewCustomersServlet");
        } else {
            request.setAttribute("errorMessage", "Failed to delete customer.");
            request.getRequestDispatcher("viewCustomers.jsp").forward(request, response);
        }
    }
}