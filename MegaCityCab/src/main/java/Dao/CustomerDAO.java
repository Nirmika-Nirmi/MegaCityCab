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
    

    public int getTotalCustomers() {
        String query = "SELECT COUNT(*) AS total FROM customers";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    

     // Fetch all customers from the database
        public List<CustomerBean> getAllCustomers() {
            List<CustomerBean> customers = new ArrayList<>();
            String query = "SELECT * FROM customers";

            try (PreparedStatement stmt = conn.prepareStatement(query);
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    CustomerBean customer = new CustomerBean();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setFullName(rs.getString("full_name"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPhoneNumber(rs.getString("phone"));
                    customer.setAddress(rs.getString("address"));
                    customer.setNicNumber(rs.getString("nic"));
                    customer.setStatus(rs.getString("status"));
                    customers.add(customer);
                }
            } catch (SQLException e) {
                System.err.println("SQL Error in getAllCustomers: " + e.getMessage());
                e.printStackTrace();
            }

            return customers;
        }

        // Search customers by name, email, or phone
        public List<CustomerBean> searchCustomers(String query) {
            List<CustomerBean> customers = new ArrayList<>();
            String sql = "SELECT * FROM customers WHERE full_name LIKE ? OR email LIKE ? OR phone LIKE ?";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, "%" + query + "%");
                stmt.setString(2, "%" + query + "%");
                stmt.setString(3, "%" + query + "%");

                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    CustomerBean customer = new CustomerBean();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setFullName(rs.getString("full_name"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPhoneNumber(rs.getString("phone"));
                    customer.setAddress(rs.getString("address"));
                    customer.setNicNumber(rs.getString("nic"));
                    customer.setStatus(rs.getString("status"));
                    customers.add(customer);
                }
            } catch (SQLException e) {
                System.err.println("SQL Error in searchCustomers: " + e.getMessage());
                e.printStackTrace();
            }

            return customers;
        }

        // Delete a customer by ID
        public boolean deleteCustomer(int customerId) {
            String query = "DELETE FROM customers WHERE customer_id = ?";

            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, customerId);
                int rowsAffected = stmt.executeUpdate();
                return rowsAffected > 0; // Return true if deletion is successful
            } catch (SQLException e) {
                System.err.println("SQL Error in deleteCustomer: " + e.getMessage());
                e.printStackTrace();
            }

            return false; // Return false if deletion fails
        }
        
        

    
    
    public void toggleCustomerStatus(int customerId) throws SQLException {
        String sql = "UPDATE customers SET status = CASE WHEN status = 'Active' THEN 'Inactive' ELSE 'Active' END WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, customerId);
        stmt.executeUpdate();
    }
    
    

}
