<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h2>Admin Login</h2>

    <form action="login" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>

        <input type="submit" value="Login">
    </form>

    <p>Not Admin? <a href="user-login.jsp">User Login</a></p>

    <% String errorMessage = (String)request.getAttribute("errorMessage");
       if(errorMessage != null) { %>
           <p style="color: red;"><%= errorMessage %></p>
    <% } %>
</body>
</html>
