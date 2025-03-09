package Servlet;

import Dao.DriverDAO;
import Bean.Driver;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/loginDriver")
public class DriverLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("LoginDriverServlet invoked"); // Debugging log

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        DriverDAO driverDAO = new DriverDAO();
        boolean isValidLogin = driverDAO.validateDriverLogin(email, password);

        if (isValidLogin) {
            // Fetch the driver details using the email
            int driverId = driverDAO.getDriverIdByEmail(email);
            Driver driver = DriverDAO.getDriverById(driverId);

            if (driver != null) {
                // Store driver ID in session
                HttpSession session = request.getSession();
                session.setAttribute("driverId", driver.getDriverId());
                session.setAttribute("fullName", driver.getFullName());

                System.out.println("Driver logged in: " + driver.getDriverId()); // Debugging log

                // Redirect to driver dashboard
                response.sendRedirect("driver-dashboard.jsp");
            } else {
                // Handle case where driver details are not found
                request.setAttribute("errorMessage", "Driver details not found");
                request.getRequestDispatcher("driverLogin.jsp").forward(request, response);
            }
        } else {
            // Handle login failure
            request.setAttribute("errorMessage", "Invalid email or password");
            request.getRequestDispatcher("driverLogin.jsp").forward(request, response);
        }
    }
}