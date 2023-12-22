<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.io.PrintWriter" %>


<html>
<head>
    <title>Add Train</title>
</head>
<body>

    <!-- Header -->
    <h1>Add New Train</h1>

    <!-- Form to add a new train -->
    <form action="add-train-handler.jsp" method="post">
        <label for="trainName">Train Name:</label>
        <input type="text" id="trainName" name="trainName" required><br>

        <label for="crossingStatus">Crossing Status:</label>
        <input type="radio" id="openStatus" name="crossingStatus" value="Open" checked>
        <label for="openStatus">Open</label>

        <input type="radio" id="closedStatus" name="crossingStatus" value="Closed">
        <label for="closedStatus">Closed</label><br>

        <label for="personInCharge">Person in Charge:</label>
        <input type="text" id="personInCharge" name="personInCharge" required><br>

        <label for="trainSchedule">Train Schedule:</label>
        <input type="text" id="trainSchedule" name="trainSchedule" required><br>

        <label for="landmark">Landmark:</label>
        <input type="text" id="landmark" name="landmark" required><br>

        <label for="address">Address:</label>
        <input type="text" id="address" name="address" required><br>

        <input type="submit" value="Add Train">
    </form>

    <!-- Rest of your code... -->

</body>
</html>
