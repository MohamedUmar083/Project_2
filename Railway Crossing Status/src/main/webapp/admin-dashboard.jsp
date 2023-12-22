<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    


<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
    <!-- Add Train button -->
    <h1>Welcome to the Admin Dashboard</h1>
    <form action="add-train.jsp" method="get" style="position: absolute; top: 10px; right: 180px;">
        <input type="submit" value="Add Train">
    </form>
    <form action="logout.jsp" method="get" style="position: absolute; top: 10px; right: 100px;">
        <input type="submit" value="Log Out">
    </form>
    

    <h2>Train Details</h2>
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
            try {
                // Database connection details
                String jdbcUrl = "jdbc:mysql://localhost:3306/railwayproject";
                String dbUsername = "root";
                String dbPassword = "password";

                // Establish the database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

                // Query to retrieve available trains
                String sql = "SELECT * FROM trains";
                int i=0;
                try (PreparedStatement statement = connection.prepareStatement(sql);
                     ResultSet resultSet = statement.executeQuery()) {

                	while (resultSet.next()) {
                        String trainName = resultSet.getString("train_name");
                        String status = resultSet.getString("crossing_status");
                        String personInCharge = resultSet.getString("person_in_charge");
                        String schedule = resultSet.getString("train_schedule");
                        String landmark = resultSet.getString("landmark");
                        String address = resultSet.getString("address");

                        // Display train details in the table
            %>
                        <tr>
                             <td><%= trainName %></td>
            <td><%= status %></td>
            <td><%= personInCharge %></td>
            <td><%= schedule %></td>
            <td><%= landmark %></td>
            <td><%= address %></td>
            <td>
            <a href="update.jsp?id=<%=resultSet.getString("id")%>">
            <button type="button"  class="update">Update</button></a>
            
            <a href="delete.jsp?id=<%=resultSet.getString("id") %>">
            <button type="button"  class="delete">Delete</button></a></td>
                        </tr>
                        <%

                        i++;
                	}
                    }
                connection.close();
                
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace(); // Handle the exception appropriately in your application
            }
            %>
        </tbody>
    </table>

    <!-- Add any other admin-specific content here -->

</body>
</html>
