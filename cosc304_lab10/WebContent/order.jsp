<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>

<head>
	<title>COMPANY - Shopping Cart Data</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
	<%@ include file="header.jsp" %>

	<% 
// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");;

getConnection();

boolean validID = false;

// Determine if valid customer id was entered
// If the customer ID exists and is valid, the server will return it for checking.
// If not, nothing is returned and the ID can be assumed incorrect.
int cid = 0;
try {
	cid = Integer.parseInt(custId);
} catch(RuntimeException e){
	out.println("Entered ID was of the wrong type. Please Try again.");
	return;
}
Statement stmt = con.createStatement();
ResultSet rst = stmt.executeQuery("Select customerId FROM customer WHERE customerId = '" + custId + "'");
//checkID is created in this way to ensure a non-null string is stored
String checkID = "";
while (rst.next())
	checkID = rst.getString("customerId");

if (checkID.equals(custId)){
	validID = true;
}

//If the ID doesn't exist, print an error message.
if(!validID){
	out.println("Customer ID did not exist. No changes have been made to your profile.");
	return;
}

// If cart is empty, display an error message
if (productList.isEmpty()){
	out.println("Cart is empty.");
}
else{

	try {
// Save order information to database

	String sql = "INSERT into ordersummary (customerId,orderDate) values (?,?)";
		
	// Use retrieval of auto-generated keys.
	PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);	
	pstmt.setInt(1,cid);
	long timenow = System.currentTimeMillis();
	Date date = new java.sql.Date(timenow);
	Timestamp orderdate = new java.sql.Timestamp(date.getTime());
	pstmt.setTimestamp(2,orderdate); 
	pstmt.executeUpdate();
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);


	


// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

	double totamt = 0;
	
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = (Integer) product.get(3);
        
		// Insert each item into OrderProduct table using OrderId from previous INSERT
		String sql1 = "INSERT into OrderProduct (orderId, productId, quantity, price) values(?,?,?,?)";
		PreparedStatement pst = con.prepareStatement(sql1);
		pst.setInt(1, orderId);
		pst.setInt(2, Integer.parseInt(productId));
		pst.setInt(3,qty);
		pst.setDouble(4,pr);
		
		// Update total amount for order record
		totamt += qty*pr;
		// Print out order summary
		out.println("<b>Product ID:</b> " + productId + ",<b> Product Name: </b>" + product.get(1) + ", <b>Quantity: </b>"
			+ qty + ", <b>Individual Price: </b>" + pr + ", <b>Total Price: </b>" + pr*qty + "<br>");

		//out.println("<tr><tr><th>" + productId + "</th><td align=\"left\">" + product.get(1) + "</th><td> align=\"center\">" 
		//	+ qty + "</th><td align=\"right\">" + pr + "</th><td align=\"right\">" + pr*qty + "</th></tr><br>");
		pst.executeUpdate();
	}
	}

	catch(SQLException e)
	{
		out.println(e);
	}

	session.setAttribute("productList", null);
}

closeConnection();

%>
</BODY>

</HTML>

