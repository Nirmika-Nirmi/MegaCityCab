package Servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Bean.Car;
import Bean.Driver;
import Dao.CarDao;
import Dao.DriverDAO;

@WebServlet("/DriverRegisterServlet")
public class DriverRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DriverRegisterServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            // Driver Details
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String nic = request.getParameter("nic");
            String licenseNumber = request.getParameter("licenseNumber");
            String password = request.getParameter("password");

            // Car Details
            String carModel = request.getParameter("carModel");
            String plateNumber = request.getParameter("plateNumber");
            int capacity = Integer.parseInt(request.getParameter("capacity"));
            String fuelType = request.getParameter("fuelType");
            boolean hasAC = request.getParameter("hasAC") != null;
            boolean hasGPS = request.getParameter("hasGPS") != null;

            // Debug logs
            System.out.println("Driver Details:");
            System.out.println("Full Name: " + fullName);
            System.out.println("Email: " + email);
            System.out.println("Phone: " + phone);
            System.out.println("Address: " + address);
            System.out.println("NIC: " + nic);
            System.out.println("License Number: " + licenseNumber);
            System.out.println("Password: " + password);

            System.out.println("Car Details:");
            System.out.println("Car Model: " + carModel);
            System.out.println("Plate Number: " + plateNumber);
            System.out.println("Capacity: " + capacity);
            System.out.println("Fuel Type: " + fuelType);
            System.out.println("Has AC: " + hasAC);
            System.out.println("Has GPS: " + hasGPS);

            // Create Driver object
            Driver driver = new Driver();
            driver.setFullName(fullName);
            driver.setEmail(email);
            driver.setPhoneNumber(phone);
            driver.setAddress(address);
            driver.setNicNumber(nic);
            driver.setLicenseNumber(licenseNumber);
            driver.setPassword(password);

            // Register Driver
            DriverDAO driverDAO = new DriverDAO();
            boolean driverRegistered = driverDAO.registerDriver(driver);

            if (driverRegistered) {
                // Get the driver_id of the newly registered driver
                int driverId = driverDAO.getDriverIdByEmail(email);

                // Create Car object
                Car car = new Car();
                car.setModel(carModel);
                car.setPlateNumber(plateNumber);
                car.setCapacity(capacity);
                car.setFuelType(fuelType);
                car.setAc(hasAC);
                car.setGps(hasGPS);
                car.setDriverId(driverId);

                // Register Car
                CarDao carDAO = new CarDao();
                boolean carRegistered = carDAO.registerCar(car);

                if (carRegistered) {
                    request.setAttribute("message", "Registration Successful! You can now log in.");
                    request.getRequestDispatcher("driverLogin.jsp").forward(request, response);
                } else {
                    request.setAttribute("message", "Car registration failed. Please try again.");
                    request.getRequestDispatcher("driverRegister.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("message", "Driver registration failed. Please try again.");
                request.getRequestDispatcher("driverRegister.jsp").forward(request, response);
            }
        }
    }
}
