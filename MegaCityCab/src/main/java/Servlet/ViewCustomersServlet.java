package Servlet;

import Dao.CustomerDAO;
import Dao.DBConnection;
import Bean.CustomerBean;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/viewCustomers")
public class ViewCustomersServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch the list of customers from the database using the DAO
        List<CustomerBean> customers = CustomerDAO.getAllCustomers();

        // Set the list of customers as a request attribute
        request.setAttribute("customers", customers);

        // Forward the request to the viewCustomers.jsp page to display the data
        request.getRequestDispatcher("viewCustomers.jsp").forward(request, response);

        // Optionally, print the customer list size for debugging
        System.out.println("Fetched customers: " + customers.size());
    }

    // This is where you fetch customers from the database
    private List<CustomerBean> getAllCustomers() {
        List<CustomerBean> customers = new ArrayList<>();
        String query = "SELECT * FROM customers";  // Your SQL query to fetch customers

        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                CustomerBean customer = new CustomerBean();
                customer.setCustomerId(rs.getInt("customerId"));
                customer.setFullName(rs.getString("name"));
                customer.setEmail(rs.getString("email"));
                customer.setPhoneNumber(rs.getString("phone"));
                customer.setAddress(rs.getString("address"));
                customer.setStatus(rs.getString("status"));
                customers.add(customer);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customers;  // Return the list of customers
    }
}


