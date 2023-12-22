<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, jakarta.servlet.*, jakarta.servlet.http.*, jakarta.servlet.annotation.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Login</title>
</head>
<body>
 <h2>User Login</h2>
    <form action="user-login" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>

        <input type="submit" value="Login">
    </form>

    <p>Don't Have an Account ? <a href="register.jsp">Register Here</a></p>

    <% String errorMessage = (String)request.getAttribute("errorMessage");
       if(errorMessage != null) { %>
           <p style="color: red;"><%= errorMessage %></p>
    <% } %>
</body>
</html>
