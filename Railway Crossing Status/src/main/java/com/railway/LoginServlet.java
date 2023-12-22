package com.railway;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    static {
        // Load the JDBC driver during class initialization
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace(); // Handle the exception appropriately in your application
        }
    }

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (checkAdminCredentials(username, password)) {
            response.sendRedirect("admin-dashboard.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid credentials. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private boolean checkAdminCredentials(String username, String password) {
        // Provide your actual database connection details
        String jdbcUrl = "jdbc:mysql://localhost:3306/railwayproject";
        String dbUsername = "root";
        String dbPassword = "Mohdumar@1011302";

        // SQL query to check admin credentials
        String query = "SELECT * FROM admin WHERE username = ? AND password = ?";

        try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            statement.setString(2, password);

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next(); // Returns true if a matching admin is found
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle the exception appropriately in your application
            return false;
        }
    }
}
