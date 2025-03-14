package Dao;

import Bean.Car;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CarDao {
    private Connection conn;

    public CarDao() {
        conn = DBConnection.getConnection();
    }

    public boolean registerCar(Car car) {
        String query = "INSERT INTO cars (model, plate_number, capacity, fuel_type, ac, gps, driver_id) "
                     + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, car.getModel());
            stmt.setString(2, car.getPlateNumber());
            stmt.setInt(3, car.getCapacity());
            stmt.setString(4, car.getFuelType());
            stmt.setBoolean(5, car.isAc());
            stmt.setBoolean(6, car.isGps());
            stmt.setInt(7, car.getDriverId());

            System.out.println("Executing query: " + stmt.toString()); // Debug log

            int rowsAffected = stmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected); // Debug log
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage()); // Debug log
            e.printStackTrace();
        }
        return false;
    }

    public Car getCarByDriverId(int driverId) {
        String query = "SELECT * FROM cars WHERE driver_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, driverId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Car car = new Car();
                car.setCarId(rs.getInt("car_id"));
                car.setModel(rs.getString("model"));
                car.setPlateNumber(rs.getString("plate_number"));
                car.setCapacity(rs.getInt("capacity"));
                car.setFuelType(rs.getString("fuel_type"));
                car.setAc(rs.getBoolean("ac"));
                car.setGps(rs.getBoolean("gps"));
                car.setDriverId(rs.getInt("driver_id"));
                return car;
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in getCarByDriverId: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Return null if no car is found
    }

    public boolean updateCar(Car car) {
        String query = "UPDATE cars SET model = ?, plate_number = ?, capacity = ?, fuel_type = ?, ac = ?, gps = ? WHERE car_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, car.getModel());
            stmt.setString(2, car.getPlateNumber());
            stmt.setInt(3, car.getCapacity());
            stmt.setString(4, car.getFuelType());
            stmt.setBoolean(5, car.isAc());
            stmt.setBoolean(6, car.isGps());
            stmt.setInt(7, car.getCarId());

            int rowsAffected = stmt.executeUpdate();
            System.out.println("Rows affected during update: " + rowsAffected); // Debug log
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("SQL Error in updateCar: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    // Method to fetch all cars
    public List<Car> getAllCars() {
        List<Car> cars = new ArrayList<>();
        String query = "SELECT * FROM cars";
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Car car = new Car();
                car.setCarId(rs.getInt("car_id"));
                car.setModel(rs.getString("model"));
                car.setPlateNumber(rs.getString("plate_number"));
                car.setCapacity(rs.getInt("capacity"));
                car.setFuelType(rs.getString("fuel_type"));
                car.setAc(rs.getBoolean("ac"));
                car.setGps(rs.getBoolean("gps"));
                car.setDriverId(rs.getInt("driver_id"));
                cars.add(car);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cars;
    }
}