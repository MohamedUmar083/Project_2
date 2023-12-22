<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%! String driverName = "com.mysql.jdbc.Driver";%>
<%!String url = "jdbc:mysql://localhost:3306/railwayproject";%>
<%!String user = "root";%>
<%!String psw = "password";%>
<%
String id = request.getParameter("id");
String trainName = request.getParameter("trainName");
String crossingStatus = request.getParameter("crossingStatus");
String personInCharge = request.getParameter("personInCharge");
String trainSchedule = request.getParameter("trainSchedule");
String landmark = request.getParameter("landmark");
String address = request.getParameter("address");
if(id != null)
{
Connection con = null;
PreparedStatement ps = null;
int personID = Integer.parseInt(id);
try
{
Class.forName(driverName);
con = DriverManager.getConnection(url,user,psw);
String sql="Update trains set train_name=?,crossing_status=?,person_in_charge=?,train_schedule=?,landmark=?,address=? where id="+id;
ps = con.prepareStatement(sql);
ps.setString(1, trainName);
ps.setString(2, crossingStatus);
ps.setString(3, personInCharge);
ps.setString(4, trainSchedule);
ps.setString(5, landmark);
ps.setString(6, address);

int i = ps.executeUpdate();
if(i > 0)
{
out.print("Record Updated Successfully");
response.sendRedirect("admin-dashboard.jsp");
}
else
{
out.print("There is a problem in updating Record.");
response.sendRedirect("admin-dashboard.jsp");
} 
}
catch(SQLException sql)
{
request.setAttribute("error", sql);
out.println(sql);
}
}
%>