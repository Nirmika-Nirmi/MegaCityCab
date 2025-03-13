package Servlet;

import Bean.Feedback;
import Dao.FeedbackDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        int driverId = Integer.parseInt(request.getParameter("driverId"));
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        double rating = Double.parseDouble(request.getParameter("rating"));
        String comments = request.getParameter("comments");

        Feedback feedback = new Feedback();
        feedback.setBookingId(bookingId);
        feedback.setDriverId(driverId);
        feedback.setCustomerId(customerId);
        feedback.setRating(rating);
        feedback.setComments(comments);

        FeedbackDAO feedbackDAO = new FeedbackDAO();
        boolean isSubmitted = feedbackDAO.submitFeedback(feedback);

        if (isSubmitted) {
            response.sendRedirect("customer-dashboard.jsp?message=Feedback+Submitted+Successfully");
        } else {
            response.sendRedirect("submitFeedback.jsp?error=Failed+to+Submit+Feedback");
        }
    }
}