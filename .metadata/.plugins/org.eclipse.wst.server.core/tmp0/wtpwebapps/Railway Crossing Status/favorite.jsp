<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Retrieve the user ID from the session
    String userId = (String) session.getAttribute("userId");

    if (userId != null && !userId.isEmpty()) {
        try {
            // Database connection details
             String jdbcUrl = "jdbc:mysql://localhost:3306/railwayproject";
                String dbUsername = "root";
                String dbPassword = "Mohdumar@1011302";


            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

            // Query to retrieve favorite trains for the logged-in user
            String sql = "SELECT t.* FROM user_favorite uf INNER JOIN trains t ON uf.train_id = t.id WHERE uf.user_id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, userId);

                try (ResultSet resultSet = statement.executeQuery()) {
%>
                    <!DOCTYPE html>
                    <html>
                    <head>
                        <title>Favorite Train Details</title>
                    </head>
                    <body>
                    <form action="user-dashboard.jsp" method="get" style="position: absolute; top: 10px; right: 150px;">
                        <input type="submit" value="User Dashboard">
                    </form>
                        <h1>Favorite Train Details</h1>
                        <table border="1">
                            <thead>
                                <tr>
                                    <th>Train Name</th>
                                    <th>Status</th>
                                    <th>Person in Charge</th>
                                    <th>Schedule</th>
                                    <th>Landmark</th>
                                    <th>Address</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
<%
                            while (resultSet.next()) {
                            	String trainId = resultSet.getString("id");
                                String trainName = resultSet.getString("train_name");
                                String status = resultSet.getString("crossing_status");
                                String personInCharge = resultSet.getString("person_in_charge");
                                String schedule = resultSet.getString("train_schedule");
                                String landmark = resultSet.getString("landmark");
                                String address = resultSet.getString("address");
%>
                                <tr>
                                    <td><%= trainName %></td>
                                    <td><%= status %></td>
                                    <td><%= personInCharge %></td>
                                    <td><%= schedule %></td>
                                    <td><%= landmark %></td>
                                    <td><%= address %></td>
                                    <td>
        <form action="remove-favorite.jsp" method="post">
            <input type="hidden" name="trainId" value="<%=trainId%>">
            <input type="submit" value="Remove">
        </form>
    </td>
                                </tr>
<%
                            }
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace(); // Handle the exception appropriately in your application
                }
            }
         else {
            // Handle the case where the user is not logged in
            response.sendRedirect("user-login.jsp");
        }
%>
                        </tbody>
                    </table>
                </body>
            </html>
