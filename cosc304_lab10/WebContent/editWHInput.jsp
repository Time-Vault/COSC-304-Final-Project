<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Edit Inventory</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%@ include file="header.jsp" %>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Edit Warehouse Inventory</h3>

<br>
<form name="MyForm" method="get" action="editWHInvtry.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Product ID:</font></div></td>
	<td><input type="text" name="pid"  size=5 maxlength=2></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Quantity:</font></div></td>
	<td><input type="text" name="quantity" size=5 maxlength="2"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Warehouse ID:</font></div></td>
	<td><input type="text" name="whId" size=5 maxlength="2"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Function ("ADD" or "REMOVE"):</font></div></td>
	<td><input type="text" name="requestFunc" size=5 maxlength="6"></td>
</tr>
</table>
<br/>
<input type="submit" value="Submit"><input type="reset" value="Reset">
</form>

</div>

<h2 align="center"><a href="admin.jsp">Return To Admin Page</a></h2>

</body>
</html>