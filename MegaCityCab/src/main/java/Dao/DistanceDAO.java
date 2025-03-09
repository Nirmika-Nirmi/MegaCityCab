package Dao;

import Bean.Distance;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DistanceDAO {
    private Connection connection;

    public DistanceDAO() {
        connection = DBConnection.getConnection();
        if (connection == null) {
            System.err.println("Failed to establish database connection.");
        } else {
            System.out.println("Database connection established successfully.");
        }
    }

    // Method to get the distance between two areas
    public Distance getDistance(String fromArea, String toArea) {
        String query = "SELECT * FROM distances WHERE from_area = ? AND to_area = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, fromArea);
            stmt.setString(2, toArea);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Distance distance = new Distance();
                distance.setFromArea(rs.getString("from_area"));
                distance.setToArea(rs.getString("to_area"));
                distance.setDistanceKm(rs.getDouble("distance_km"));
                return distance;
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in getDistance: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Return null if no distance is found
    }

    // Method to add a new distance record
    public boolean addDistance(Distance distance) {
        String query = "INSERT INTO distances (from_area, to_area, distance_km) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, distance.getFromArea());
            stmt.setString(2, distance.getToArea());
            stmt.setDouble(3, distance.getDistanceKm());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Returns true if the record is added successfully
        } catch (SQLException e) {
            System.err.println("SQL Error in addDistance: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    
    public static void main(String[] args) {
        DistanceDAO distanceDAO = new DistanceDAO();

        // Add a new distance record
        Distance newDistance = new Distance();
        newDistance.setFromArea("Downtown");
        newDistance.setToArea("Uptown");
        newDistance.setDistanceKm(15.5);
        boolean isAdded = distanceDAO.addDistance(newDistance);
        System.out.println("Distance added: " + isAdded);

        // Retrieve a distance record
        Distance distance = distanceDAO.getDistance("Downtown", "Uptown");
        if (distance != null) {
            System.out.println("Distance: " + distance);
        } else {
            System.out.println("Distance not found.");
        }
    }
    
    
    
}