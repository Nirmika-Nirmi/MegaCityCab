package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Bean.CustomerBean;

public class CustomerDashboardDao {
    private Connection connection;

    public CustomerDashboardDao() {
        connection = DBConnection.getConnection();
    }

    public CustomerBean getCustomerById(int customerId) {
        CustomerBean customer = null;
        String query = "SELECT * FROM customers WHERE customer_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            System.out.println("Executing query: " + query + " with customerId: " + customerId);  // Log query and parameter

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                customer = new CustomerBean();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setFullName(rs.getString("full_name"));
                customer.setEmail(rs.getString("email"));
                customer.setPhoneNumber(rs.getString("phone"));
            } else {
                System.out.println("No customer found for ID: " + customerId);  // No customer found in the result set
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customer;
    }

}
