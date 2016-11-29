<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ include file="jdbc.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Mikey.ca login</title>
</head>
<body>

<%@ include file="header.jsp"%>

<%
@SuppressWarnings({"unchecked"})
login loginInfo = (login) session.getAttribute("loginInfo");
String SQL = "";

try 
{
	PreparedStatement pstmt = null;
	if (loginInfo == null) {
		loginInfo = new login();
	}
	
	int userID = loginInfo.getUserID();
	
	String newID = request.getParameter("userId");
	String password = request.getParameter("password");
	
	if (newID != null && newID != "")
	{
		int num = -1;
		try 
		{
			num = Integer.parseInt(newID);
		}
		catch (Exception e)
		{
			out.println("<h1>Invalid user id.   Go back to the previous page and try again.");
			return;
		}
		getConnection();
		SQL = "SELECT UserID FROM Users WHERE UserID = ? AND password = ?";
		pstmt = con.prepareStatement(SQL);
		pstmt.setInt(1, num);
		pstmt.setString(2, password);
		ResultSet rst = pstmt.executeQuery();
		if (rst.next()) {
			loginInfo.setUserID(num);
			userID = num;
		}
		session.setAttribute("loginInfo", loginInfo);	
					
	}
	
	if (userID == -1) // check to see if the user is logged in
	{
		out.println("<h1>You are not currently logged in.</h1>");
		if (password != null)
			out.println("<h2>Your user id or password is incorrect");
		out.println("<h2>Enter your user id and password:</h2>");

		out.println("<form method=\"post\" action=\"login.jsp\">");
		out.println("<table>");
		out.println("	<tr>");
		out.println("		<td>Customer ID:</td>");
		out.println("		<td><input type=\"text\" name=\"userId\" size=\"20\"></td>");
		out.println("	</tr>");
		out.println("	<tr>");
		out.println("		<td>Password:</td>");
		out.println("		<td><input type=\"password\" name=\"password\" size=\"20\"></td>");
		out.println("	</tr>");
		out.println("	<tr>");
		out.println("		<td><input type=\"submit\" value=\"Submit\"></td>");
		out.println("		<td><input type=\"reset\" value=\"Reset\"></td>");
		out.println("	</tr>");
		out.println("</table>");
		out.println("</form>");
	}
	
	else // User is logged in
	{
		getConnection();
		SQL = "SELECT fname, lname FROM Users WHERE UserID = ?;";
		pstmt = con.prepareStatement(SQL);
		pstmt.setInt(1, userID);
		ResultSet rst = pstmt.executeQuery();
		rst.next();
		out.println("You are logged in as " + rst.getString("fname") + " " + rst.getString("lname"));
		
	}
	
}
catch (SQLException ex)
{ 	out.println(ex);
}
finally
{
	try
	{
		if (con != null)
			con.close();
	}
	catch (SQLException ex)
	{       out.println(ex);
	}
}  

%>
</body>
</html>