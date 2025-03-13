package Dao;

import Bean.Feedback;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO {
    private Connection conn;

    public FeedbackDAO() {
        conn = DBConnection.getConnection();
    }

    // Method to submit feedback
    public boolean submitFeedback(Feedback feedback) {
        String query = "INSERT INTO driver_feedback (booking_id, driver_id, customer_id, rating, comments) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, feedback.getBookingId());
            stmt.setInt(2, feedback.getDriverId());
            stmt.setInt(3, feedback.getCustomerId());
            stmt.setDouble(4, feedback.getRating());
            stmt.setString(5, feedback.getComments());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to get feedback for a specific driver
    public List<Feedback> getFeedbackByDriverId(int driverId) {
        List<Feedback> feedbackList = new ArrayList<>();
        String query = "SELECT * FROM driver_feedback WHERE driver_id = ? ORDER BY feedback_date DESC";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, driverId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackId(rs.getInt("feedback_id"));
                feedback.setBookingId(rs.getInt("booking_id"));
                feedback.setDriverId(rs.getInt("driver_id"));
                feedback.setCustomerId(rs.getInt("customer_id"));
                feedback.setRating(rs.getDouble("rating"));
                feedback.setComments(rs.getString("comments"));
                feedback.setFeedbackDate(rs.getTimestamp("feedback_date"));
                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbackList;
    }

    // Method to get all feedback for admin
    public List<Feedback> getAllFeedback() {
        List<Feedback> feedbackList = new ArrayList<>();
        String query = "SELECT * FROM driver_feedback ORDER BY feedback_date DESC";
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackId(rs.getInt("feedback_id"));
                feedback.setBookingId(rs.getInt("booking_id"));
                feedback.setDriverId(rs.getInt("driver_id"));
                feedback.setCustomerId(rs.getInt("customer_id"));
                feedback.setRating(rs.getDouble("rating"));
                feedback.setComments(rs.getString("comments"));
                feedback.setFeedbackDate(rs.getTimestamp("feedback_date"));
                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbackList;
    }
    
    
}