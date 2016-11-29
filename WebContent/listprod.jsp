<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Mikey.ca</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<h2>Browse Products By Category and Search by Product Name:</h2>

<form method="get" action="listprod.jsp">
  <p align="left">
  <select size="1" name="categoryName">
  <option>All</option>

<%
/*
// Could create category list dynamically - more adaptable, but a little more costly
try               
{
	getConnection();
 	ResultSet rst = executeQuery("SELECT DISTINCT categoryName FROM Product");
        while (rst.next()) 
		out.println("<option>"+rst.getString(1)+"</option>");
}
catch (SQLException ex)
{       out.println(ex);
}
*/
%>

  <option>Soccer</option>
  <option>Rugby</option>
  <option>Basketball</option>
  <option>Curling</option>
  <option>Baseball</option>
  <option>Hockey</option>

  <input type="text" name="productName" size="50">    
  </select><input type="submit" value="Submit"><input type="reset" value="Reset"></p>
</form>

<%
// Colors for different item categories
HashMap colors = new HashMap();		// This may be done dynamically as well, a little tricky...
colors.put("Soccer", "#0000FF");
colors.put("Rugby", "#FF0000");
colors.put("Basketball", "#000000");
colors.put("Curling", "#6600CC");
colors.put("Baseball", "#55A5B3");
colors.put("Hockey", "#FF9900");
%>

<%
	// Get product name to search for
String name = request.getParameter("productName");
String category = request.getParameter("categoryName");

boolean hasNameParam = name != null && !name.equals("");
boolean hasCategoryParam = category != null && !category.equals("") && !category.equals("All");
String filter = "", sql = "";

if (hasNameParam && hasCategoryParam)
{
	filter = "<h3>Products containing '"+name+"' in category: '"+category+"'</h3>";
	name = '%'+name+'%';
	sql = "SELECT P.pid, P.pname, P.price, PC.catName FROM Product P, ProductCategory PC WHERE P.catID = PC.catID AND P.pname LIKE ? AND PC.catName = ?";
}
else if (hasNameParam)
{
	filter = "<h3>Products containing '"+name+"'</h3>";
	name = '%'+name+'%';
	sql = "SELECT P.pid, P.pname, P.price, PC.catName FROM Product P, ProductCategory PC WHERE P.catID = PC.catID AND P.pname LIKE ?";
}
else if (hasCategoryParam)
{
	filter = "<h3>Products in category: '"+category+"'</h3>";
	sql = "SELECT P.pid, P.pname, P.price, PC.catName FROM Product P, ProductCategory PC WHERE P.catID = PC.catID AND PC.catName = ?";
}
else
{
	filter = "<h3>All Products</h3>";
	sql = "SELECT P.pid, P.pname, P.price, PC.catName FROM Product P, ProductCategory PC WHERE P.catID = PC.catID";
}

out.println(filter);

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{
	getConnection();
	PreparedStatement pstmt = con.prepareStatement(sql);
	if (hasNameParam)
	{
		pstmt.setString(1, name);	
		if (hasCategoryParam)
		{
			pstmt.setString(2, category);
		}
	}
	else if (hasCategoryParam)
	{
		pstmt.setString(1, category);
	}
	
	ResultSet rst = pstmt.executeQuery();
	
	out.print("<font face=\"Century Gothic\" size=\"2\"><table class=\"table\" border=\"1\"><tr><th class=\"col-md-1\"></th><th>Product Name</th>");
	out.println("<th>Category</th><th>Price</th></tr>");
	while (rst.next()) 
	{
		out.print("<td class=\"col-md-1\"><a href=\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2)
				+ "&price=" + rst.getDouble(3) + "\">Add to Cart</a></td>");

		String itemCategory = rst.getString(4);
		String color = (String) colors.get(itemCategory);
		if (color == null)
			color = "#FFFFFF";

		out.println("<td><font color=\"" + color + "\">" + rst.getString(2) + "</font></td>"
				+ "<td><font color=\"" + color + "\">" + itemCategory + "</font></td>"
				+ "<td><font color=\"" + color + "\">" + currFormat.format(rst.getDouble(3))
				+ "</font></td></tr>");
	}
	out.println("</table></font>");
	closeConnection();
} catch (SQLException ex) {
	out.println(ex);
}
%>

</body>
</html>

