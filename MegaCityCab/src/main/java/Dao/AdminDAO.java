package Dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import Bean.Admin;

public class AdminDAO {
    private Connection conn;

    public AdminDAO() {
        conn = DBConnection.getConnection();
    }

    // Method to validate admin login
    public Admin validateAdmin(String email, String password) {
        String query = "SELECT * FROM admin WHERE email = ? AND password = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            stmt.setString(2, password);  // In production, use hashed password!

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Admin admin = new Admin();
                admin.setAdminId(rs.getInt("admin_id"));
                admin.setFullName(rs.getString("full_name"));
                admin.setEmail(rs.getString("email"));
                admin.setPassword(rs.getString("password"));
                return admin;  // Admin found, return admin object
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Admin not found
    }
    
    
    
 // Method to update admin profile
    public boolean updateAdmin(Admin admin) {
        String query;
        if (admin.getPassword() != null && !admin.getPassword().isEmpty()) {
            // Update profile with password
            query = "UPDATE admin SET full_name = ?, email = ?, password = ? WHERE admin_id = ?";
        } else {
            // Update profile without password
            query = "UPDATE admin SET full_name = ?, email = ? WHERE admin_id = ?";
        }

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, admin.getFullName());
            stmt.setString(2, admin.getEmail());

            if (admin.getPassword() != null && !admin.getPassword().isEmpty()) {
                // Hash the password before storing it
                String hashedPassword = hashPassword(admin.getPassword());
                stmt.setString(3, hashedPassword);
                stmt.setInt(4, admin.getAdminId());
            } else {
                stmt.setInt(3, admin.getAdminId());
            }

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to hash the password (for security)
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }
}
