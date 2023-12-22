
<%@ page import="java.util.List" %>
<%@ page import="com.railway.Train" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>All Trains</title>
</head>
<body>
    <h1>All Trains</h1>

    <% 
    List<Train> allTrains = new ArrayList<>();
    try {
        String jdbcUrl = "jdbc:mysql://localhost:3306/railwayproject";
        String dbUsername = "root";
        String dbPassword = "Mohdumar@1011302";

        Class.forName("com.mysql.cj.jdbc.Driver");
        
        try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword)) {
            String sql = "SELECT * FROM trains";
            try (PreparedStatement statement = connection.prepareStatement(sql);
                 ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    String trainName = resultSet.getString("train_name");
                    String crossingStatus = resultSet.getString("crossing_status");
                    String personInCharge = resultSet.getString("person_in_charge");
                    String trainSchedule = resultSet.getString("train_schedule");
                    String landmark = resultSet.getString("landmark");
                    String address = resultSet.getString("address");

                    Train train = new Train(trainName, crossingStatus, personInCharge, trainSchedule, landmark, address);
                    allTrains.add(train);
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>

    <table border="1">
        <tr>
            <th>Train Name</th>
            <th>Crossing Status</th>
            <th>Person in Charge</th>
            <th>Train Schedule</th>
            <th>Landmark</th>
            <th>Address</th>
        </tr>
        <% for (Train train : allTrains) { %>
            <tr>
                <td><%= train.getTrainName() %></td>
                <td><%= train.getCrossingStatus() %></td>
                <td><%= train.getPersonInCharge() %></td>
                <td><%= train.getTrainSchedule() %></td>
                <td><%= train.getLandmark() %></td>
                <td><%= train.getAddress() %></td>
            </tr>
        <% } %>
    </table>
</body>
</html>

