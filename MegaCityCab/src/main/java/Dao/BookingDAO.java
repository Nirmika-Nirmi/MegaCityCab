package Dao;

import java.security.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Bean.Booking;

public class BookingDAO {
    private Connection connection; // Use this variable consistently

    public BookingDAO() {
        connection = DBConnection.getConnection(); // Initialize the connection
        if (connection == null) {
            System.err.println("Failed to establish database connection.");
        } else {
            System.out.println("Database connection established successfully.");
        }
    }

    // Method to get the count of completed rides for a driver
    public int getCompletedRidesCount(int driverId) {
        String query = "SELECT COUNT(*) AS completed_rides FROM bookings WHERE driver_id = ? AND status = 'Completed'";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, driverId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("completed_rides");
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in getCompletedRidesCount: " + e.getMessage());
            e.printStackTrace();
        }
        return 0; // Return 0 if no completed rides are found
    }

    // Method to get the total earnings for a driver
    public double getTotalEarnings(int driverId) {
        String query = "SELECT SUM(fare) AS total_earnings FROM bookings WHERE driver_id = ? AND status = 'Completed'";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, driverId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total_earnings");
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in getTotalEarnings: " + e.getMessage());
            e.printStackTrace();
        }
        return 0.0; // Return 0.0 if no earnings are found
    }

    // Method to update driver availability
    public boolean updateDriverAvailability(int driverId, boolean isAvailable) {
        String query = "UPDATE drivers SET is_available = ? WHERE driver_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setBoolean(1, isAvailable);
            stmt.setInt(2, driverId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("SQL Error in updateDriverAvailability: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Method to get the email of a driver by ID
    public String getDriverEmailById(int driverId) {
        String query = "SELECT email FROM drivers WHERE driver_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, driverId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("email");
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in getDriverEmailById: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Return null if no email is found
    }

    // Method to get the count of upcoming bookings for a customer
    public int getUpcomingBookingsCount(int customerId) {
        String query = "SELECT COUNT(*) FROM bookings WHERE customer_id = ? AND status = 'Pending'";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Returns the count of pending bookings
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Return 0 if no bookings found
    }

    // Method to save a new booking
    public boolean saveBooking(Booking booking) {
        String query = "INSERT INTO bookings (customer_id, pickup_location, drop_location, booking_date, num_passengers, payment_method, special_requests, driver_id, car_id, status) "
                     + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending')";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, booking.getCustomerId());
            stmt.setString(2, booking.getPickupLocation());
            stmt.setString(3, booking.getDropLocation());
            stmt.setTimestamp(4, booking.getBookingDate()); // Set booking date
            stmt.setInt(5, booking.getNumPassengers());
            stmt.setString(6, booking.getPaymentMethod());
            stmt.setString(7, booking.getSpecialRequests());

            // Optional fields (driver_id and car_id)
            if (booking.getDriverId() == 0) {
                stmt.setNull(8, java.sql.Types.INTEGER); // Set driver_id to NULL
            } else {
                stmt.setInt(8, booking.getDriverId());
            }

            if (booking.getCarId() == 0) {
                stmt.setNull(9, java.sql.Types.INTEGER); // Set car_id to NULL
            } else {
                stmt.setInt(9, booking.getCarId());
            }

            System.out.println("Executing query: " + stmt.toString()); // Debugging log

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Returns true if booking is saved successfully
        } catch (SQLException e) {
            System.err.println("SQL Error in saveBooking: " + e.getMessage()); // Log SQL error
            e.printStackTrace();
            return false;
        }
    }

    // Method to get bookings by customer ID
    public List<Booking> getBookingsByCustomerId(int customerId) {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings WHERE customer_id = ? ORDER BY booking_date DESC";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setStatus(rs.getString("status"));
                booking.setFare(rs.getDouble("fare"));
                booking.setBookingDate(rs.getTimestamp("booking_date"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in getBookingsByCustomerId: " + e.getMessage());
            e.printStackTrace();
        }
        return bookings;
    }

    // Method to get assigned rides for a driver
    public List<Booking> getAssignedRides(int driverId) {
        List<Booking> rides = new ArrayList<>();
        String query = "SELECT * FROM bookings WHERE driver_id = ? AND status IN ('Pending', 'Confirmed')";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, driverId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setStatus(rs.getString("status"));
                booking.setFare(rs.getDouble("fare"));
                rides.add(booking);
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in getAssignedRides: " + e.getMessage());
            e.printStackTrace();
        }
        return rides;
    }

  

    // Method to mark a ride as completed
    public boolean completeRide(int bookingId) {
        String query = "UPDATE bookings SET status = 'Completed' WHERE booking_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to assign the nearest driver to a booking
    public int assignNearestDriver(String pickupArea) {
        String query = "SELECT dl.driver_id, d.distance_km " +
                       "FROM driver_locations dl " +
                       "JOIN distances d ON dl.area_name = d.from_area " +
                       "WHERE d.to_area = ? AND dl.driver_id IN " +
                       "(SELECT driver_id FROM drivers WHERE is_available = TRUE) " +
                       "ORDER BY d.distance_km ASC LIMIT 1";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, pickupArea);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("driver_id"); // Return the nearest driver's ID
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in assignNearestDriver: " + e.getMessage());
            e.printStackTrace();
        }
        return -1; // Return -1 if no available driver is found
    }

    // Method to assign a driver to a booking
    public boolean assignDriverToBooking(int bookingId, int driverId) {
        String query = "UPDATE bookings SET driver_id = ?, status = 'Confirmed' WHERE booking_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, driverId);
            stmt.setInt(2, bookingId);
            return stmt.executeUpdate() > 0; // Returns true if the assignment is successful
        } catch (SQLException e) {
            System.err.println("SQL Error in assignDriverToBooking: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Get all bookings assigned to the driver
    public List<Booking> getDriverBookings(int driverId) {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings WHERE driver_id = ? AND status IN ('Pending', 'Confirmed')";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, driverId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setStatus(rs.getString("status"));
                booking.setFare(rs.getDouble("fare"));
                booking.setNumPassengers(rs.getInt("num_passengers"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Accept a ride
    public boolean acceptRide(int bookingId) {
        String query = "UPDATE bookings SET status = 'Confirmed' WHERE booking_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Reject a ride
    public boolean rejectRide(int bookingId) {
        String query = "UPDATE bookings SET status = 'Rejected' WHERE booking_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Complete a ride and submit fare
    public boolean completeRide(int bookingId, double fare) {
        String query = "UPDATE bookings SET status = 'Completed', fare = ? WHERE booking_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setDouble(1, fare);
            stmt.setInt(2, bookingId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to get customer name by booking ID
    public String getCustomerNameByBookingId(int bookingId) {
        String query = "SELECT c.full_name FROM customers c JOIN bookings b ON c.customer_id = b.customer_id WHERE b.booking_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("full_name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if no customer name is found
    }

    // Method to get customer phone by booking ID
    public String getCustomerPhoneByBookingId(int bookingId) {
        String query = "SELECT c.phone FROM customers c JOIN bookings b ON c.customer_id = b.customer_id WHERE b.booking_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("phone");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if no customer phone is found
    }

    // Method to get driver name by booking ID
    public String getDriverNameByBookingId(int bookingId) {
        String query = "SELECT d.full_name FROM drivers d JOIN bookings b ON d.driver_id = b.driver_id WHERE b.booking_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("full_name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if no driver name is found
    }

    // Method to get driver phone by booking ID
    public String getDriverPhoneByBookingId(int bookingId) {
        String query = "SELECT d.phone FROM drivers d JOIN bookings b ON d.driver_id = b.driver_id WHERE b.booking_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("phone");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if no driver phone is found
    }

    // Method to get pickup location by booking ID
    public String getPickupLocationByBookingId(int bookingId) {
        String query = "SELECT pickup_location FROM bookings WHERE booking_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("pickup_location");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if no pickup location is found
    }

    // Method to get drop location by booking ID
    public String getDropLocationByBookingId(int bookingId) {
        String query = "SELECT drop_location FROM bookings WHERE booking_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("drop_location");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if no drop location is found
    }
    

    public java.sql.Timestamp getBookingDateByBookingId(int bookingId) {
        String query = "SELECT booking_date FROM bookings WHERE booking_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getTimestamp("booking_date");
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in getBookingDateByBookingId: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Return null if no booking date is found
    }

    
    public Booking getBookingById(int bookingId) {
        String query = "SELECT * FROM bookings WHERE booking_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setCustomerId(rs.getInt("customer_id"));
                booking.setDriverId(rs.getInt("driver_id"));
                booking.setCarId(rs.getInt("car_id"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setBookingDate(rs.getTimestamp("booking_date"));
                booking.setStatus(rs.getString("status"));
                booking.setDistance(rs.getDouble("distance"));
                booking.setFare(rs.getDouble("fare"));
                booking.setNumPassengers(rs.getInt("num_passengers"));
                booking.setPaymentMethod(rs.getString("payment_method")); // Fetch payment method
                booking.setSpecialRequests(rs.getString("special_requests"));
                booking.setCancellationReason(rs.getString("cancellation_reason"));
                return booking;
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in getBookingById: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Return null if no booking is found
    }

}