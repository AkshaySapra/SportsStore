<!--
A JSP file that encapsulates all database access.

Public methods:
- public void getConnection() throws SQLException
- public ResultSet executeQuery(String query) throws SQLException
- public void executeUpdate(String query) throws SQLException
- public void closeConnection() throws SQLException  

-->

<%@ page import="java.sql.*"%>

<%!
	// User id, password, and server information
	private String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kneubaue;";
	private String uid = "kneubaue";
	private String pw = "34742149";

	// Connection
	private Connection con = null;
%>

<%!
	public void getConnection() throws SQLException, ClassNotFoundException
	{
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			con = DriverManager.getConnection(url, uid, pw);
	}
   
	public void closeConnection() throws SQLException 
	{
		if (con != null)
			con.close();
		con = null;
	}
%>
