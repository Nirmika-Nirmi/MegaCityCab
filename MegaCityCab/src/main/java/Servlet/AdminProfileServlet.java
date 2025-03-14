package Servlet;

import Bean.Admin;
import Dao.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AdminProfileServlet")
public class AdminProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        int adminId = Integer.parseInt(request.getParameter("adminId"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password"); // New password

        // Create an Admin object
        Admin admin = new Admin();
        admin.setAdminId(adminId);
        admin.setFullName(fullName);
        admin.setEmail(email);
        admin.setPassword(password); // Set the new password

        // Update the admin's profile in the database
        AdminDAO adminDAO = new AdminDAO();
        boolean isUpdated = adminDAO.updateAdmin(admin);

        if (isUpdated) {
            // Redirect to the admin dashboard with a success message
            response.sendRedirect("admin-dashboard.jsp?message=Profile+Updated+Successfully");
        } else {
            // Redirect back to the edit profile page with an error message
            response.sendRedirect("adminEditProfile.jsp?error=Failed+to+Update+Profile");
        }
    }
}