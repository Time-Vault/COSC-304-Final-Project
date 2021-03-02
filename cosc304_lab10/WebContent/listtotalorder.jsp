<!DOCTYPE html>
<html>
<head>
<title>Total Orders</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<%@ include file="header.jsp" %>

    <%@ include file="auth.jsp"%>
    <%@ include file="jdbc.jsp" %>
<%
// TODO: Write SQL query that prints out total order amount by day
try ( Connection con = DriverManager.getConnection(url, uid, pw);
	  Statement stmt = con.createStatement();) {
    String sql = "SELECT year(orderDate), month(orderDate), day(orderDate), SUM(totalAmount)"
    + " FROM ordersummary GROUP BY year(orderDate), month(orderDate), day(orderDate)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	ResultSet rst = pstmt.executeQuery();	
    out.println("<table border=1><tr><th>Order Date</th><th>Total Order Amount</th></tr>");
	while(rst.next()){
		String orderId = rst.getString(1);
		out.println("<tr><td>"+rst.getString(1)+"-"+rst.getString(2)+"-"+rst.getString(3)+"</td>"+"<td>"+"$"+rst.getString(4)+"</td></tr>");
	}
	 out.println("</table>"); 
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
%>

<h2 align="center"><a href="admin.jsp">Return To Admin Page</a></h2>

</body>
</html>
