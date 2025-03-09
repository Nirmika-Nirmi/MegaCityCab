package Servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Bean.Admin;
import Dao.AdminDAO;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AdminDAO dao = new AdminDAO();
        Admin admin = dao.validateAdmin(email, password);

        if (admin != null) {
            // Creating session for logged-in admin
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            response.sendRedirect("admin-dashboard.jsp"); // Redirect to admin dashboard
        } else {
            // If login fails, show error message
            request.setAttribute("errorMessage", "Invalid email or password!");
            request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
        }
    }
}
