package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Bean.CustomerBean;

public class CustomerDAO {
    private Connection conn;
    private static final String SEARCH_CUSTOMERS = "SELECT * FROM customers WHERE fullName LIKE ? OR email LIKE ?";

    public CustomerDAO() {
        conn = DBConnection.getConnection();
    }


    // Method to register a customer in the database
    public boolean registerCustomer(CustomerBean customer) {
        String query = "INSERT INTO customers (full_name, email, phone, address, nic, password, status) "
                     + "VALUES (?, ?, ?, ?, ?, ?, 'Active')";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, customer.getFullName());
            stmt.setString(2, customer.getEmail());
            stmt.setString(3, customer.getPhoneNumber());
            stmt.setString(4, customer.getAddress());
            stmt.setString(5, customer.getNicNumber());
            stmt.setString(6, customer.getPassword()); // Correct password field assignment

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    // Method to validate customer login
    public boolean validateCustomerLogin(String email, String password) {
        String query = "SELECT * FROM customers WHERE email = ? AND password = ? AND status = 'Active'";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);  // Use email to login
            stmt.setString(2, password);  // In production, you should hash the password!
            
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return true; // Login successful
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Invalid login
    }
    
    
    public int getCustomerIdByEmail(String email) {
        String query = "SELECT customer_id FROM customers WHERE email = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("customer_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Return -1 if customer not found
    }
    
    

        public static List<CustomerBean> getAllCustomers() {
            List<CustomerBean> customers = new ArrayList<>();
            Connection conn = DBConnection.getConnection();

            String query = "SELECT * FROM customers"; // Adjust this to your actual table and column names
            try (PreparedStatement stmt = conn.prepareStatement(query);
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    CustomerBean customer = new CustomerBean();
                    customer.setCustomerId(rs.getInt("id"));
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
            return customers;
        }
    



    public List<CustomerBean> searchCustomers(String searchTerm) {
        List<CustomerBean> customers = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SEARCH_CUSTOMERS)) {

            stmt.setString(1, "%" + searchTerm + "%");
            stmt.setString(2, "%" + searchTerm + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CustomerBean customer = new CustomerBean();
                    customer.setCustomerId(rs.getInt("customerId"));
                    customer.setFullName(rs.getString("fullName"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPhoneNumber(rs.getString("phoneNumber"));
                    customer.setAddress(rs.getString("address"));
                    customer.setStatus(rs.getString("status"));
                    customers.add(customer);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }
    

    public void deleteCustomer(int customerId) throws SQLException {
        String sql = "DELETE FROM customers WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, customerId);
        stmt.executeUpdate();
    }
    
    
    public void toggleCustomerStatus(int customerId) throws SQLException {
        String sql = "UPDATE customers SET status = CASE WHEN status = 'Active' THEN 'Inactive' ELSE 'Active' END WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, customerId);
        stmt.executeUpdate();
    }
    
    

}
