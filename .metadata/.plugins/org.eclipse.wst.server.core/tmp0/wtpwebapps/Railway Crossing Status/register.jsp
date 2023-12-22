<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import=" jakarta.servlet.*" %>
<%@ page import=" jakarta.servlet.http.*" %>
<%@ page import=" jakarta.servlet.annotation.*" %>
<%@ page import="java.io.*" %>
<%
    // Load the JDBC driver
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        e.printStackTrace(); // Handle the exception appropriately in your application
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
</head>
<body>
    <h2>Register</h2>

    
    <form action="register.jsp" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>

        <input type="submit" value="Register">
    </form>

    <p>Already have an account? <a href="user-login.jsp">Login here</a></p>
    

    <% String errorMessage = (String)request.getAttribute("errorMessage");
       if(errorMessage != null) { %>
           <p style="color: red;"><%= errorMessage %></p>
    <% } else if ("POST".equals(request.getMethod())) {
           // Process the form submission (register the user)
           String username = request.getParameter("username");
           String password = request.getParameter("password");

           // Provide your actual database connection details
          String jdbcUrl = "jdbc:mysql://localhost:3306/railwayproject";
        String dbUsername = "root";
        String dbPassword = "Mohdumar@1011302";

           // SQL query to insert user details
        String insertQuery = "INSERT INTO user (username, password) VALUES (?, ?)";

        try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);
             PreparedStatement statement = connection.prepareStatement(insertQuery)) {
            statement.setString(1, username);
            statement.setString(2, password);

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("user-login.jsp");
                return; // Redirect immediately after successful registration
            } else {
                out.println("<p style='color: red;'>Registration failed. Please try again.</p>");
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle the exception appropriately in your application
            out.println("<p style='color: red;'>Registration failed. Please try again.</p>");
        }
    } %>
</body>
</html>
