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
import jakarta.servlet.http.HttpSession;

@WebServlet("/user-login")
public class UserLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Check credentials against the user table in the database
        if (isValidUser(username, password)) {
            // If credentials are valid, set the user ID in the session
            String userId = getUserIdFromDatabase(username);
            HttpSession session = request.getSession(true);
            session.setAttribute("userId", userId);

            // Redirect to the user dashboard or any other user-specific page
            response.sendRedirect("user-dashboard.jsp");
        } else {
            // If credentials are not valid, redirect to login page with an error message
            request.setAttribute("errorMessage", "Invalid credentials. Please try again.");
            request.getRequestDispatcher("user-login.jsp").forward(request, response);
        }
    }

    // Check if the user exists in the database and if the password is correct
    private boolean isValidUser(String username, String password) {
        try {
        	 String jdbcUrl = "jdbc:mysql://localhost:3306/railwayproject";
             String dbUsername = "root";
             String dbPassword = "Mohdumar@1011302";


            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

            // Adjust the table name to 'user' in the SQL query
            String sql = "SELECT * FROM user WHERE username = ? AND password = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, username);
                statement.setString(2, password);

                ResultSet resultSet = statement.executeQuery();
                return resultSet.next(); // Returns true if user exists with the provided credentials
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Handle the exception appropriately in your application
            return false;
        }
    }

    // Retrieve user ID from the database based on the username
    private String getUserIdFromDatabase(String username) {
        try {
        	 String jdbcUrl = "jdbc:mysql://localhost:3306/railwayproject";
             String dbUsername = "root";
             String dbPassword = "Mohdumar@1011302";


            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

            // Adjust the table name to 'user' in the SQL query
            String sql = "SELECT user_id FROM user WHERE username = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, username);

                ResultSet resultSet = statement.executeQuery();
                if (resultSet.next()) {
                    return resultSet.getString("user_id");
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Handle the exception appropriately in your application
        }
        return null;
    }
}
