<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<%@page import = "jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Retrieve the train ID from the request parameter
    String trainId = request.getParameter("trainId");

    // Check if the train ID is not null or empty
    if (trainId != null && !trainId.isEmpty()) {
        try {
            // Retrieve user ID from the session
            HttpSession userSession = request.getSession(false);
            if (userSession == null || userSession.getAttribute("userId") == null) {
                // Handle the case where the user is not logged in
                response.getWriter().write("User not logged in.");
                return;
            }
            String userId = userSession.getAttribute("userId").toString();

            // Database connection details
            String jdbcUrl = "jdbc:mysql://localhost:3306/railwayproject";
            String dbUsername = "root";
            String dbPassword = "Mohdumar@1011302";

            // Establish the database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

            // Insert the favorite train details into the user_favorite table
            String insertSql = "INSERT INTO user_favorite (user_id, train_id) VALUES (?, ?)";
            try (PreparedStatement insertStatement = connection.prepareStatement(insertSql)) {
                insertStatement.setString(1, userId);
                insertStatement.setString(2, trainId);
                insertStatement.executeUpdate();
            }

            // Redirect back to user-dashboard.jsp after adding to favorite
            response.sendRedirect("user-dashboard.jsp");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Handle the exception appropriately in your application
        }
    } else {
        // Handle the case where the train ID is not provided
        response.getWriter().write("Train ID is missing or invalid.");
    }
%>
