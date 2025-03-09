package Servlet;

import Dao.DriverDAO;
import Bean.Driver;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

public class DriverServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch the list of drivers
        DriverDAO driverDAO = new DriverDAO();
        List<Driver> driverList = driverDAO.getAllDrivers();

        if (driverList.isEmpty()) {
            System.out.println("No drivers found in the database!");  // Debugging
        }

        // Set the driver list as a request attribute
        request.setAttribute("driverList", driverList);

        // Forward to the JSP page
        RequestDispatcher rd = request.getRequestDispatcher("admin/viewDrivers.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
            RequestDispatcher dispatcher = request.getRequestDispatcher("EditDriver.jsp");
            dispatcher.forward(request, response);
        }
    }
}