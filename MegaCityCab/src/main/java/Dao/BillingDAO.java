package Dao;

import Bean.Billing;
import Bean.Booking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BillingDAO {
    private static final Logger logger = Logger.getLogger(BillingDAO.class.getName());

    // Method to generate a bill
    public boolean generateBill(Billing billing) {
        String query = "INSERT INTO billing (booking_id, bill_number, customer_id, driver_id, customer_name, customer_phone, "
                     + "driver_name, driver_phone, pickup_location, drop_location, distance, starting_meter, ending_meter, "
                     + "final_amount, payment_method, payment_status) "
                     + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, billing.getBookingId());
            stmt.setString(2, billing.getBillNumber());
            stmt.setInt(3, billing.getCustomerId());
            stmt.setInt(4, billing.getDriverId());
            stmt.setString(5, billing.getCustomerName());
            stmt.setString(6, billing.getCustomerPhone());
            stmt.setString(7, billing.getDriverName());
            stmt.setString(8, billing.getDriverPhone());
            stmt.setString(9, billing.getPickupLocation());
            stmt.setString(10, billing.getDropLocation());
            stmt.setDouble(11, billing.getDistance());
            stmt.setDouble(12, billing.getStartingMeter());
            stmt.setDouble(13, billing.getEndingMeter());
            stmt.setDouble(14, billing.getFinalAmount());
            stmt.setString(15, billing.getPaymentMethod());
            stmt.setString(16, billing.getPaymentStatus());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "SQL Error in generateBill: " + e.getMessage(), e);
            return false;
        }
    }

    // Method to fetch billing details by bookingId
    public Billing getBillByBookingId(int bookingId) {
        String query = "SELECT * FROM billing WHERE booking_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Billing billing = new Billing();
                billing.setBillId(rs.getInt("bill_id"));
                billing.setBookingId(rs.getInt("booking_id"));
                billing.setCustomerId(rs.getInt("customer_id"));
                billing.setDriverId(rs.getInt("driver_id"));
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
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "SQL Error in getBillByBookingId: " + e.getMessage(), e);
        }
        return null; // Return null if no billing record is found
    }
    
    public double getTotalRevenue() {
        String query = "SELECT SUM(final_amount) AS total FROM billing WHERE payment_status = 'Paid'";
        try (Connection connection = DBConnection.getConnection(); // Initialize the connection
             PreparedStatement stmt = connection.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0; // Return 0.0 if no revenue is found or an error occurs
    }
    
    
    public List<Billing> getPaymentHistoryByCustomerId(int customerId) {
        List<Billing> paymentHistory = new ArrayList<>();
        String query = "SELECT * FROM billing WHERE customer_id = ? ORDER BY bill_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Billing billing = new Billing();
                billing.setBillNumber(rs.getString("bill_number"));
                billing.setCustomerName(rs.getString("customer_name"));
                billing.setCustomerPhone(rs.getString("customer_phone"));
                billing.setPickupLocation(rs.getString("pickup_location"));
                billing.setDropLocation(rs.getString("drop_location"));
                billing.setDistance(rs.getDouble("distance"));
                billing.setFinalAmount(rs.getDouble("final_amount"));
                billing.setPaymentMethod(rs.getString("payment_method"));
                billing.setPaymentStatus(rs.getString("payment_status"));
                billing.setBillDate(rs.getTimestamp("bill_date"));
                paymentHistory.add(billing);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return paymentHistory;
    }
    
    public List<Billing> getAllBillingDetails() {
        List<Billing> billingList = new ArrayList<>();
        String query = "SELECT * FROM billing ORDER BY bill_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Billing billing = new Billing();
                billing.setBillId(rs.getInt("bill_id"));
                billing.setBookingId(rs.getInt("booking_id"));
                billing.setCustomerId(rs.getInt("customer_id"));
                billing.setDriverId(rs.getInt("driver_id"));
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

                billingList.add(billing);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return billingList;
    }
    
}