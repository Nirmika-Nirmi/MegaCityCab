
package Servlet;

import Dao.DriverDAO;
import Bean.Driver;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.util.List;

@WebServlet("/DriverServlet") // Ensure this annotation is present
public class DriverServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("DriverServlet doGet called"); // Debug log
        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            // Fetch driver details for editing
            int driverId = Integer.parseInt(request.getParameter("driverId"));
            Driver driver = DriverDAO.getDriverById(driverId);
            request.setAttribute("driver", driver);
            request.getRequestDispatcher("EditDriver.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            // Handle delete action
            int driverId = Integer.parseInt(request.getParameter("driverId"));
            boolean isDeleted = DriverDAO.deleteDriver(driverId);
            if (isDeleted) {
                response.sendRedirect("DriverServlet");
            } else {
                request.setAttribute("errorMessage", "Failed to delete driver.");
                request.getRequestDispatcher("viewDrivers.jsp").forward(request, response);
            }
        } else {
            // Default action: fetch and display all drivers
            List<Driver> driverList = new DriverDAO().getAllDrivers();
            request.setAttribute("driverList", driverList);
            request.getRequestDispatcher("viewDrivers.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("DriverServlet doPost called"); // Debug log
        int driverId = Integer.parseInt(request.getParameter("driverId"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String licenseNumber = request.getParameter("licenseNumber");
        String status = request.getParameter("status");

        Driver driver = new Driver();
        driver.setDriverId(driverId);
        driver.setFullName(fullName);
        driver.setEmail(email);
        driver.setPhoneNumber(phoneNumber);
        driver.setAddress(address);
        driver.setLicenseNumber(licenseNumber);
        driver.setStatus(status);

        boolean isUpdated = DriverDAO.updateDriver(driver);

        if (isUpdated) {
            response.sendRedirect("DriverServlet");
        } else {
            request.setAttribute("errorMessage", "Failed to update driver details.");
            request.getRequestDispatcher("EditDriver.jsp").forward(request, response);
        }
    }
    
    
}
