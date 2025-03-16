package Servlet;

import Dao.DriverDAO;
import Bean.Driver;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;

@WebServlet("/ModifyDriverServlet")
public class ModifyDriverServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int driverId = Integer.parseInt(request.getParameter("driverId"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String licenseNumber = request.getParameter("licenseNumber");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        // Create a Driver object
        Driver driver = new Driver();
        driver.setDriverId(driverId);
        driver.setFullName(fullName);
        driver.setEmail(email);
        driver.setPhoneNumber(phoneNumber);
        driver.setAddress(address);
        driver.setLicenseNumber(licenseNumber);

        // Check if the current password is correct
        DriverDAO driverDAO = new DriverDAO();
        Driver existingDriver = driverDAO.getDriverById(driverId);

        if (existingDriver != null && existingDriver.getPassword().equals(currentPassword)) {
            // Update the password if a new password is provided
            if (newPassword != null && !newPassword.isEmpty()) {
                driver.setPassword(newPassword); // Set new password
            } else {
                driver.setPassword(existingDriver.getPassword()); // Keep the old password
            }

            // Modify driver details
            boolean isModified = driverDAO.modifyDriverDetails(driver);

            if (isModified) {
                response.sendRedirect("driverDashboard.jsp?message=Profile+Modified+Successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to modify driver details.");
                request.getRequestDispatcher("driverEditProfile.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Current password is incorrect.");
            request.getRequestDispatcher("driverEditProfile.jsp").forward(request, response);
        }
    }
}