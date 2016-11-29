
<%!
public class login {
	private int UserID;
	
	public login() {
		UserID = -1;
	}
	
	public login(int id) {
		UserID = id;
	}
	
	public void setUserID(int id) {
		UserID = id;
	}
	
	public int getUserID() {
		return UserID;
	}
}
%>

<%-- <%
login loginInfo = new login();
session.setAttribute("loginInfo", loginInfo);
%> --%>
