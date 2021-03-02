<!DOCTYPE html>
<html>
<head>
<title>Your Haunted Homes Account</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>
<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String UserName = (String) session.getAttribute("authenticatedUser");
%>

<%

String sql = "select * from customer where userId = ?";
getConnection();
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setString(1, UserName);
ResultSet rst = pstmt.executeQuery();

if (rst.next()) {
	String id = rst.getString(1);
	String fname = rst.getString(2);
	String lname = rst.getString(3);
	String email = rst.getString(4);
	String phone = rst.getString(5);
	String address = rst.getString(6);
	String city = rst.getString(7);
	String state = rst.getString(8);
	String postal = rst.getString(9);
	String country = rst.getString(10);
	String username = rst.getString(11);
	String pass = rst.getString(12);
	out.println("<table>");
	out.println("<tr><th>Id</th><td>" + id + "</td></tr>");
	out.println("<tr><th>First Name</th><td>" + fname + "</td></tr>");
	out.println("<tr><th>Last Name</th><td>" + lname + "</td></tr>");
	out.println("<tr><th>Email</th><td>" + email + "</td></tr>");
	out.println("<tr><th>Phone</th><td>" + phone + "</td></tr>");
	out.println("<tr><th>Address</th><td>" + address + "</td></tr>");
	out.println("<tr><th>City</th><td>" + city + "</td></tr>");
	out.println("<tr><th>State</th><td>" + state + "</td></tr>");
	out.println("<tr><th>Postal Code</th><td>" + postal + "</td></tr>");
	out.println("<tr><th>Country</th><td>" + country + "</td></tr>");
	out.println("<tr><th>User Id</th><td>" + username + "</td></tr>");
	out.println("<tr><th>Password</th><td>" + pass + "</td></tr>");
	out.println("</table>");
}

// Make sure to close connection
closeConnection();
%>
<br>
<form name="MyForm" method=post action="updateuser.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">First Name:</font></div></td>
	<td><input type="text" name="firstName"  size=10 maxlength=15></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
	<td><input type="text" name="lastName" size=10 maxlength="15"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
	<td><input type="text" name="email" size=10 maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Phone Number:</font></div></td>
	<td><input type="text" name="phonenum" size=10 maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></div></td>
	<td><input type="text" name="address" size=10 maxlength="100"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">City:</font></div></td>
	<td><input type="text" name="city" size=10 maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">State:</font></div></td>
	<td><input type="text" name="state" size=10 maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Postal Code:</font></div></td>
	<td><input type="text" name="postalCode" size=10 maxlength="10"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Country:</font></div></td>
	<td><input type="text" name="country" size=10 maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">User ID:</font></div></td>
	<td><input type="text" name="userid" size=10 maxlength="15"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
	<td><input type="password" name="password" size=10 maxlength="15"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Customer Id (Required):</font></div></td>
	<td><input type="text" name="customerId" ></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Update">
</form>
</body>
</html>

