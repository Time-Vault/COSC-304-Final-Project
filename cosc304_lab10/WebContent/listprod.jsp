<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%@ include file="header.jsp" %>

<div class='container'>
<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

try {
	getConnection();
	
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en", "CA"));
	ResultSet rst;

	if(name != null && !name.trim().isEmpty()){
		String sql = "SELECT * FROM product" +
					" WHERE productName LIKE ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, "%" + name + "%");
		rst = pstmt.executeQuery();

		out.println("<h2 >Products containing '" + name + "'</h2>");
	}
	else {
		String sql = "SELECT * FROM product";
		Statement stmt = con.createStatement();
		rst = stmt.executeQuery(sql);

		out.println("<h2>All Products</h2>");
	}
	
	//Print table header
	out.println("<table class='table table-striped table-bordered'>");
	out.println("<thead class='thead-dark'><tr> <th scope='col'></th>");
	out.println("<th scope='col' class='text-center'>Product Name</th>");
	out.println("<th scope='col' class='text-center'>Price</th> </tr></thead>");

	//Print table values
	while(rst.next()) {
		String pname = rst.getString("productName");
		double price = rst.getDouble("productPrice");
		int pid = rst.getInt("productId");

		out.println("<tr> <td class='text-center'><a href=addcart.jsp?id=" + pid  + "&name=" + URLEncoder.encode(pname) + "&price=" + price + ">");
		out.println("Add to Cart <img src='img//shopping_cart.png' width=20px></a></td>");
		out.println("<td><a href='product.jsp?id=" + pid + "'>" + pname + "</a></td>");
		out.println("<td class='text-center'>" + currFormat.format(price) + "</td> </tr>");
	}
	out.println("</table>");
}
catch(java.sql.SQLException e) {
	out.println(e);
}
finally {
	closeConnection();
}
%>

</div>
</body>
</html>