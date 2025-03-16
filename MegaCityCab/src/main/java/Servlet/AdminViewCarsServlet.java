package Servlet;

import Dao.CarDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

import Bean.Car;

@WebServlet("/AdminViewCarsServlet")
public class AdminViewCarsServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(AdminViewCarsServlet.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch all cars from the database
        CarDao carDao = new CarDao();
        List<Car> cars = carDao.getAllCars();

        logger.info("Fetched " + cars.size() + " cars from the database.");

        // Set the data in the request attribute
        request.setAttribute("cars", cars);

        // Forward to the JSP page
        request.getRequestDispatcher("adminViewCars.jsp").forward(request, response);
    }
}