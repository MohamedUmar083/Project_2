<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.io.PrintWriter" %>



<%

String trainName = request.getParameter("trainName");
String crossingStatus = request.getParameter("crossingStatus");
String personInCharge = request.getParameter("personInCharge");
String trainSchedule = request.getParameter("trainSchedule");
String landmark = request.getParameter("landmark");
String address = request.getParameter("address");


String url = "jdbc:mysql://localhost:3306/railwayproject";
String user = "root";
String password = "password";

try {
   
    Class.forName("com.mysql.cj.jdbc.Driver");

    
    Connection connection = DriverManager.getConnection(url, user, password);

    
    String insertQuery = "INSERT INTO trains (train_name, crossing_status, person_in_charge, train_schedule, landmark, address) VALUES (?, ?, ?, ?, ?, ?)";
    try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
        preparedStatement.setString(1, trainName);
        preparedStatement.setString(2, crossingStatus);
        preparedStatement.setString(3, personInCharge);
        preparedStatement.setString(4, trainSchedule);
        preparedStatement.setString(5, landmark);
        preparedStatement.setString(6, address);

        
        preparedStatement.executeUpdate();
    }

    
    connection.close();

    
    response.sendRedirect("admin-dashboard.jsp");

} catch (ClassNotFoundException | SQLException | IOException e) {
   
    e.printStackTrace();
    
    response.sendRedirect("admin-dashboard.jsp");
}
%>
