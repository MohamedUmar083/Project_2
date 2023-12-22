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

       
        if (isValidUser(username, password)) {
           
            String userId = getUserIdFromDatabase(username);
            HttpSession session = request.getSession(true);
            session.setAttribute("userId", userId);

            
            response.sendRedirect("user-dashboard.jsp");
        } else {
           
            request.setAttribute("errorMessage", "Invalid credentials. Please try again.");
            request.getRequestDispatcher("user-login.jsp").forward(request, response);
        }
    }

    
    private boolean isValidUser(String username, String password) {
        try {
        	 String jdbcUrl = "jdbc:mysql://localhost:3306/railwayproject";
             String dbUsername = "root";
             String dbPassword = "password";


            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

            
            String sql = "SELECT * FROM user WHERE username = ? AND password = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, username);
                statement.setString(2, password);

                ResultSet resultSet = statement.executeQuery();
                return resultSet.next(); 
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); 
            return false;
        }
    }

   
    private String getUserIdFromDatabase(String username) {
        try {
        	 String jdbcUrl = "jdbc:mysql://localhost:3306/railwayproject";
             String dbUsername = "root";
             String dbPassword = "password";


            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

            
            String sql = "SELECT user_id FROM user WHERE username = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, username);

                ResultSet resultSet = statement.executeQuery();
                if (resultSet.next()) {
                    return resultSet.getString("user_id");
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); 
        }
        return null;
    }
}
