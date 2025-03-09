package Dao;

import java.sql.Connection;

public class TestConnection {
    public static void main(String[] args) {
        Connection conn = DBConnection.getConnection();
        if (conn != null) {
            System.out.println("✅ Connected Successfully!");
        } else {
            System.out.println("❌ Connection Failed!");
        }
        
        // Close connection after testing
        DBConnection.closeConnection();
        
        
        
    }
}
