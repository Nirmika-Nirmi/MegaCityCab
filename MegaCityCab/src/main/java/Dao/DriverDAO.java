package Dao;

import Bean.Booking;
import Bean.Car;
import Bean.Driver;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DriverDAO {
    private Connection conn;

    public DriverDAO() {
        conn = DBConnection.getConnection();
    }

    public boolean registerDriver(Driver driver) {
        String query = "INSERT INTO drivers (full_name, email, phone, address, nic, password, license_number, status) "
                     + "VALUES (?, ?, ?, ?, ?, ?, ?, 'Active')";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            // Set parameters for the query
            stmt.setString(1, driver.getFullName());
            stmt.setString(2, driver.getEmail());
            stmt.setString(3, driver.getPhoneNumber());
            stmt.setString(4, driver.getAddress());
            stmt.setString(5, driver.getNicNumber());
            stmt.setString(6, driver.getPassword());
            stmt.setString(7, driver.getLicenseNumber());

            // Execute the query
            int rowsAffected = stmt.executeUpdate();

            // Return true if the driver was successfully registered
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("SQL Error in registerDriver: " + e.getMessage());
            e.printStackTrace();
        }
        return false; // Return false if registration fails
    }

    
    
    
    public boolean validateDriverLogin(String email, String password) {
        String query = "SELECT * FROM drivers WHERE email = ? AND password = ? AND status = 'Active'";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            return rs.next(); // Returns true if a valid driver is found
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Invalid login
    }

    public int getDriverIdByEmail(String email) {
        String query = "SELECT driver_id FROM drivers WHERE email = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("driver_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Return -1 if driver not found
    }

    public static Driver getDriverById(int driverId) {
        Driver driver = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM drivers WHERE driver_id = ?")) {
            pstmt.setInt(1, driverId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                driver = new Driver();
                driver.setDriverId(rs.getInt("driver_id"));
                driver.setFullName(rs.getString("full_name"));
                driver.setEmail(rs.getString("email"));
                driver.setPhoneNumber(rs.getString("phone"));
                driver.setAddress(rs.getString("address"));
                driver.setLicenseNumber(rs.getString("license_number"));
                driver.setStatus(rs.getString("status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return driver;
    }

 // Fetch all drivers from the database
    public List<Driver> getAllDrivers() {
        List<Driver> driverList = new ArrayList<>();
        String query = "SELECT * FROM drivers"; // Fetch all drivers

        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Driver driver = new Driver();
                driver.setDriverId(rs.getInt("driver_id"));
                driver.setFullName(rs.getString("full_name"));
                driver.setEmail(rs.getString("email"));
                driver.setPhoneNumber(rs.getString("phone"));
                driver.setAddress(rs.getString("address"));
                driver.setNicNumber(rs.getString("nic"));
                driver.setLicenseNumber(rs.getString("license_number"));
                driver.setStatus(rs.getString("status"));
                driver.setAvailable(rs.getBoolean("is_available"));
                driver.setAverageRating(rs.getDouble("average_rating"));
                driverList.add(driver);
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in getAllDrivers: " + e.getMessage());
            e.printStackTrace();
        }

        return driverList;
    }



    public static boolean updateDriver(Driver driver) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("UPDATE drivers SET full_name = ?, email = ?, phone = ?, address = ?, license_number = ?, status = ? WHERE driver_id = ?")) {
            pstmt.setString(1, driver.getFullName());
            pstmt.setString(2, driver.getEmail());
            pstmt.setString(3, driver.getPhoneNumber());
            pstmt.setString(4, driver.getAddress());
            pstmt.setString(5, driver.getLicenseNumber());
            pstmt.setString(6, driver.getStatus());
            pstmt.setInt(7, driver.getDriverId());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean deleteDriver(int driverId) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("DELETE FROM drivers WHERE driver_id = ?")) {
            pstmt.setInt(1, driverId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static List<Driver> searchDrivers(String query) {
        List<Driver> driverList = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM drivers WHERE full_name LIKE ? OR email LIKE ? OR phone LIKE ?")) {
            pstmt.setString(1, "%" + query + "%");
            pstmt.setString(2, "%" + query + "%");
            pstmt.setString(3, "%" + query + "%");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Driver driver = new Driver();
                driver.setDriverId(rs.getInt("driver_id"));
                driver.setFullName(rs.getString("full_name"));
                driver.setEmail(rs.getString("email"));
                driver.setPhoneNumber(rs.getString("phone"));
                driver.setStatus(rs.getString("status"));
                driverList.add(driver);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return driverList;
    }
    
    
    public Driver authenticateDriver(String email, String password) {
        String query = "SELECT * FROM drivers WHERE email = ? AND password = ? AND status = 'Active'";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Driver driver = new Driver();
                driver.setDriverId(rs.getInt("driver_id"));
                driver.setFullName(rs.getString("full_name"));
                driver.setEmail(rs.getString("email"));
                driver.setPhoneNumber(rs.getString("phone"));
                driver.setAddress(rs.getString("address"));
                driver.setNicNumber(rs.getString("nic"));
                driver.setLicenseNumber(rs.getString("license_number"));
                driver.setStatus(rs.getString("status"));
                return driver;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if no driver is found
    }
    
    
    
    public List<Booking> getAssignedRides(int driverId) {
        List<Booking> rides = new ArrayList<>();
        String query = "SELECT * FROM bookings WHERE driver_id = ? AND status IN ('Pending', 'Confirmed')";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, driverId);
            System.out.println("Executing query: " + stmt.toString()); // Debug log

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
            System.out.println("Number of assigned rides: " + rides.size()); // Debug log
        } catch (SQLException e) {
            System.out.println("SQL Error in getAssignedRides: " + e.getMessage()); // Debug log
            e.printStackTrace();
        }
        return rides;
    }
    
    
    public boolean updateDriverAvailability(int driverId, boolean isAvailable) {
        String query = "UPDATE drivers SET is_available = ? WHERE driver_id = ?";
        
        // Use try-with-resources for both Connection and PreparedStatement
        try (Connection connection = DBConnection.getConnection(); // Initialize the connection
             PreparedStatement stmt = connection.prepareStatement(query)) {
            
            stmt.setBoolean(1, isAvailable); // Set the is_available parameter
            stmt.setInt(2, driverId); // Set the driver_id parameter
            
            return stmt.executeUpdate() > 0; // Returns true if the update is successful
        } catch (SQLException e) {
            System.err.println("SQL Error in updateDriverAvailability: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false; // Return false if the update fails
    }
    

    public List<Driver> getAvailableDrivers() {
        List<Driver> drivers = new ArrayList<>();
        String query = "SELECT d.*, c.* FROM drivers d LEFT JOIN cars c ON d.driver_id = c.driver_id WHERE d.is_available = TRUE AND d.status = 'Active'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Driver driver = new Driver();
                driver.setDriverId(rs.getInt("driver_id"));
                driver.setFullName(rs.getString("full_name"));
                driver.setEmail(rs.getString("email"));
                driver.setPhoneNumber(rs.getString("phone"));
                driver.setAddress(rs.getString("address"));
                driver.setNicNumber(rs.getString("nic"));
                driver.setLicenseNumber(rs.getString("license_number"));
                driver.setStatus(rs.getString("status"));
                driver.setAverageRating(rs.getDouble("average_rating"));

                // Fetch car details
                Car car = new Car();
                car.setCarId(rs.getInt("car_id"));
                car.setModel(rs.getString("model"));
                car.setPlateNumber(rs.getString("plate_number"));
                car.setCapacity(rs.getInt("capacity"));
                car.setFuelType(rs.getString("fuel_type"));
                car.setAc(rs.getBoolean("ac"));
                car.setGps(rs.getBoolean("gps"));
                driver.setCar(car);

                drivers.add(driver);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return drivers;
    }
    

    
    public String getDriverEmailById(int driverId) {
        String query = "SELECT email FROM drivers WHERE driver_id = ?";
        
        // Use try-with-resources for both Connection and PreparedStatement
        try (Connection conn = DBConnection.getConnection(); // Initialize the connection
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, driverId); // Set the driver ID parameter
            ResultSet rs = stmt.executeQuery(); // Execute the query
            
            if (rs.next()) {
                return rs.getString("email"); // Return the driver's email
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in getDriverEmailById: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null; // Return null if no email is found
    }
}