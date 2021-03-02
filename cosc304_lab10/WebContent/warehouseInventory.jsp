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

<h1>Please enter the ID number of the warehouse you wish to check:</h1>

<form method="get" action="warehouseInventory.jsp">
<input type="text" name="warehouseId" size="2">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for complete inventory of warehouses)
</form>


<%
//Code is based off of listprod.jsp by Tim Mammadov
//Edits and additions by Mack Schmaltz
//whId is the ID of the requested warehouse.
//String for simplicity when creating statements, will change to int if needed.
String whId = request.getParameter("warehouseId");

try {
	getConnection();
	ResultSet rst;

	if(whId != null && !whId.trim().isEmpty()){
		String sql = "SELECT WH.warehouseId, warehouseName, PI.productId, productName, quantity"+
					" FROM warehouse WH LEFT JOIN productinventory PI" +
					" ON WH.warehouseId = PI.warehouseId JOIN product P ON PI.productId = P.productId"+
					" WHERE WH.warehouseId = '"+whId+"'";
		PreparedStatement pstmt = con.prepareStatement(sql);
		rst = pstmt.executeQuery();

		out.println("<h2>Inventory of Warehouse " + whId + "</h2>");
	}
	else {
		String sql = "SELECT WH.warehouseId, warehouseName, PI.productId, productName, quantity"
		+ " FROM warehouse WH LEFT JOIN productinventory PI"
		+ " ON WH.warehouseId = PI.warehouseId JOIN product P ON PI.productId = P.productId";
		Statement stmt = con.createStatement();
		rst = stmt.executeQuery(sql);

		out.println("<h2>All Warehouse Inventories</h2>");
	}
	
	out.println("<table class='table table-striped table-bordered'>");
	out.println("<tr> <th align=\"left\">Warehouse ID</th><th align=\"left\">Warehouse Name</th><th align=\"left\">Product ID</th>" +
		"<th align=\"left\">Product Name</th><th align=\"left\">In Stock</th> </tr>");

	while(rst.next()) {
		whId = rst.getString("warehouseId");
		String whName = rst.getString("warehouseName");
		String pid = rst.getString("productId");
		String pname = rst.getString("productName");
		String quantity = rst.getString("quantity");
		

		out.println("<tr> <td align=\"left\">" + whId + "</td>");
		out.println("<td align=\"left\">" + whName + "</td>");
		out.println("<td align=\"left\">" + pid + "</td>");
		out.println("<td align=\"left\">" + pname + "</td>");
		out.println("<td align=\"left\">" + quantity + "</td> </tr>");
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

<h2 align="center"><a href="editWHInput.jsp">Edit Inventories</a></h2>
<h2 align="center"><a href="admin.jsp">Return To Admin Page</a></h2>

</body>
</html>