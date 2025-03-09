package Dao;

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
}
