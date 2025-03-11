package Dao;

import Bean.Billing;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BillingDAO {
    private static final Logger logger = Logger.getLogger(BillingDAO.class.getName());
    private Connection connection;

    public BillingDAO() {
        connection = DBConnection.getConnection();
    }

    // Method to generate a bill
    public boolean generateBill(Billing billing) {
        String query = "INSERT INTO billing (booking_id, bill_number, customer_name, customer_phone, driver_name, driver_phone, " +
                       "pickup_location, drop_location, distance, starting_meter, ending_meter, final_amount, payment_method, payment_status) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, billing.getBookingId());
            stmt.setString(2, billing.getBillNumber());
            stmt.setString(3, billing.getCustomerName());
            stmt.setString(4, billing.getCustomerPhone());
            stmt.setString(5, billing.getDriverName());
            stmt.setString(6, billing.getDriverPhone());
            stmt.setString(7, billing.getPickupLocation());
            stmt.setString(8, billing.getDropLocation());
            stmt.setDouble(9, billing.getDistance());
            stmt.setDouble(10, billing.getStartingMeter());
            stmt.setDouble(11, billing.getEndingMeter());
            stmt.setDouble(12, billing.getFinalAmount());
            stmt.setString(13, billing.getPaymentMethod());
            stmt.setString(14, billing.getPaymentStatus());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "SQL Error in generateBill: " + e.getMessage(), e);
        }
        return false;
    }

    // Method to fetch a bill by booking ID
    public Billing getBillByBookingId(int bookingId) {
        String query = "SELECT * FROM billing WHERE booking_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToBilling(rs);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "SQL Error in getBillByBookingId: " + e.getMessage(), e);
        }
        return null;
    }

    // Helper method to map ResultSet to Billing object
    private Billing mapResultSetToBilling(ResultSet rs) throws SQLException {
        Billing billing = new Billing();
        billing.setBillId(rs.getInt("bill_id"));
        billing.setBookingId(rs.getInt("booking_id"));
        billing.setBillNumber(rs.getString("bill_number"));
        billing.setCustomerName(rs.getString("customer_name"));
        billing.setCustomerPhone(rs.getString("customer_phone"));
        billing.setDriverName(rs.getString("driver_name"));
        billing.setDriverPhone(rs.getString("driver_phone"));
        billing.setPickupLocation(rs.getString("pickup_location"));
        billing.setDropLocation(rs.getString("drop_location"));
        billing.setDistance(rs.getDouble("distance"));
        billing.setStartingMeter(rs.getDouble("starting_meter"));
        billing.setEndingMeter(rs.getDouble("ending_meter"));
        billing.setFinalAmount(rs.getDouble("final_amount"));
        billing.setPaymentMethod(rs.getString("payment_method"));
        billing.setPaymentStatus(rs.getString("payment_status"));
        billing.setBillDate(rs.getTimestamp("bill_date"));
        return billing;
    }
}