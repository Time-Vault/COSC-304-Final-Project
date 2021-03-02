<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Haunted Homes Warehouse Database</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<div class='container'>
<h1>Please enter the ID number of the customer you wish to check:</h1>

<form method="get" action="listcustomer.jsp">
<input type="text" name="customerId" size="2">
<input type="submit" value="Submit"><input type="reset" value="Reset">
</form>


<%
String cId = request.getParameter("customerId");
try {
	getConnection();
	ResultSet rst;
	if(cId != null && !cId.trim().isEmpty()){
		String sql = "SELECT * FROM customer WHERE customerId = '"+cId+"'";
		PreparedStatement pstmt = con.prepareStatement(sql);
		rst = pstmt.executeQuery();
		out.println("<h2>Customer " + cId + "</h2>");
	}
	else {
		String sql = "SELECT * FROM customer";
		Statement stmt = con.createStatement();
		rst = stmt.executeQuery(sql);
		out.println("<h2>All Customers</h2>");
	}
	
	out.println("<table class='table table-striped table-bordered'>");
	out.println("<tr> <th align=\"left\">Id</th><th align=\"left\">Name</th><th align=\"left\">Email</th><th align=\"left\">Phone Number</th>" +
		"<th align=\"left\">Address</th><th align=\"left\">City</th><th align=\"left\">State</th>" +
		"<th align=\"left\">Postal Code</th><th align=\"left\">Country</th><th align=\"left\">User Id</th></tr>");
	while(rst.next()) {
		cId = rst.getString("customerId");
		String firstName = rst.getString("firstName");
		String lastName = rst.getString("lastName");
		String email = rst.getString("email");
		String phonenum = rst.getString("phonenum");
		String address = rst.getString("address");
		String city = rst.getString("city");
		String state = rst.getString("state");
		String postalCode = rst.getString("postalCode");
		String country = rst.getString("country");
		String userid = rst.getString("userid");
		
		out.println("<tr> <td align=\"left\">" + cId + "</td>");
		out.println("<td align=\"left\">" + firstName + " " + lastName + "</td>");
		out.println("<td align=\"left\">" + email + "</td>");
		out.println("<td align=\"left\">" + phonenum + "</td>");
		out.println("<td align=\"left\">" + address + "</td>");
		out.println("<td align=\"left\">" + city + "</td>");
		out.println("<td align=\"left\">" + state + "</td>");
		out.println("<td align=\"left\">" + postalCode + "</td>");
		out.println("<td align=\"left\">" + country + "</td>");
		out.println("<td align=\"left\">" + userid + "</td></tr>");
	}
	out.println("</table>");
}
catch(java.sql.SQLException e) {
	out.println(e);
}
finally{
	closeConnection();
}
%>

<h2 align="center"><a href="admin.jsp">Return To Admin Page</a></h2>

</div>
</body>
</html>