package Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static Connection conn = null;

    // Database Credentials
    private static final String URL = "jdbc:mysql://localhost:3306/MegaCityCabDB?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String USER = "root";  // Change if necessary
    private static final String PASSWORD = "Wj28@krhps";  // Replace with your actual MySQL password

    // Method to establish a connection
    public static Connection getConnection() {
        try {
            if (conn == null || conn.isClosed()) { // Ensure a fresh connection if closed
                Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL JDBC Driver
                conn = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("✅ Database Connected Successfully!");
            }
        } catch (ClassNotFoundException e) {
            System.err.println("❌ JDBC Driver Not Found! Ensure MySQL Connector JAR is added.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("❌ Database Connection Failed! Check URL, username, password, or database status.");
            e.printStackTrace();
        }
        return conn;
    }
    
    // Method to close the connection when done
    public static void closeConnection() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
                System.out.println("✅ Database Connection Closed.");
            }
        } catch (SQLException e) {
            System.err.println("❌ Error Closing Database Connection.");
            e.printStackTrace();
        }
    }
}
