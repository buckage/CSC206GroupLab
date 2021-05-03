<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Employee Login Page</title>
		<style>
			table {
				position: absolute;
  				left: 50%;
  				top: 50%;
  				transform: translate(-50%, -50%);
			}
			body, a {
  				background-color: dodgerblue;
  				color: white;
  				font-family: consolas;
  				text-align: center;
  				font-size: 20px;
			}
		</style>
</head>
<body>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.regex.Pattern" %>
<%
String EMAIL_PATTERN =
        "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@"
        + "[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";
Pattern pattern = Pattern.compile(EMAIL_PATTERN);
String email = request.getParameter("employeeEmail");
String passwd = request.getParameter("employeePassword");
Matcher matcher = pattern.matcher(email);

if(matcher.matches()){
	
	// Get session creation time.
	Date createTime = new Date(session.getCreationTime());
	session.setAttribute("employeeEmail", email);
	session.setMaxInactiveInterval(3600);  //1 hour session
	Class.forName("com.mysql.cj.jdbc.Driver");  
	
	// Connect to local mySQL db and use prepared statement to avoid SQL injections
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeaccess", "root", "password");
	PreparedStatement prepStmt = conn.prepareStatement("select * from folders where employeeEmail=? and employeePassword=?");
	prepStmt.setString(1, email);
	prepStmt.setString(2, passwd);
	ResultSet rs = prepStmt.executeQuery();
	
	if(rs.next()){  // Make sure the user was found
		
		if(rs.getString(2).equals(passwd)){  // The user password is the 2nd column
			
			// Grant access to the folders based on employee privileges
			prepStmt = conn.prepareStatement("select stockFolderAccess, bondFolderAccess, moneyFolderAccess from folders where employeeEmail=? and employeePassword=?");
			prepStmt.setString(1, email);
			prepStmt.setString(2, passwd);
			rs = prepStmt.executeQuery();
			
			// Set all permissions to false as default values
			boolean stockRead = false;
			boolean stockWrite = false;
			boolean bondRead = false;
			boolean bondWrite = false;
			boolean moneyRead = false;
			boolean moneyWrite = false;
			
			while(rs.next()){
				
				// Set strings with permissions from query to employeeaccess db
				String stockAccess = rs.getString("stockFolderAccess");
				String bondAccess = rs.getString("bondFolderAccess");
				String moneyAccess = rs.getString("moneyFolderAccess");
				
				
				// Update stock permission boolean values
				if(stockAccess.equals("1")){
					stockRead = true;
					stockWrite = false;
				} else if (stockAccess.equals("2")){
					stockRead = true;
					stockWrite = true;
				} else {
					stockRead = false;
					stockWrite = false;
				}
				
				// Update bond permission boolean values
				if(bondAccess.equals("1")) {
					bondRead = true;
					bondWrite = false;
				} else if (bondAccess.equals("2")){
					bondRead = true;
					bondWrite = true;
				} else {
					bondRead = false;
					bondWrite = false;
				}
				
				// Update money permission boolean values
				if(moneyAccess.equals("1")) {
					moneyRead = true;
					moneyWrite = false;
				} else if (moneyAccess.equals("2")){
					moneyRead = true;
					moneyWrite = true;
				} else {
					moneyRead = false;
					moneyWrite = false;
				}
	
				request.setAttribute("stockRead", stockRead);
				request.setAttribute("stockWrite", stockWrite);
				
				request.setAttribute("bondRead", bondRead);
				request.setAttribute("bondWrite", bondWrite);
				
				request.setAttribute("moneyRead", moneyRead);
				request.setAttribute("moneyWrite", moneyWrite);
				
				RequestDispatcher rd = request.getRequestDispatcher("FileAccessPage.jsp");
				rd.forward(request, response);
			}
		}
	}
	
	else{
		rs.close();
		prepStmt.close();
		conn.close();
		out.println("Invalid password or email not found, try again!");
	}
}
else{
	out.println("Bad email format, try again!");
}
%>
	<table>
		<tr><th><a href = "index.html">Return to Employee Login</a></th></tr>
	</table>
</body>
</html>