<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.*" %>

<%
    // Invalidate the current session
    HttpSession userSession = request.getSession(false);
    if (userSession != null) {
        userSession.invalidate();
    }

    // Redirect to the login page or any other appropriate page after logout
    response.sendRedirect("user-login.jsp");
%>
