<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Haunted Homes - Shipment Processing</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>      

<h1>Please enter your order ID:</h1>

<form method="get" action="ship.jsp">
<input type="text" name="orderId" size="5">
<input type="submit" value="Submit"><input type="reset" value="Reset">
</form>

<%
	// TODO: Get order id
	String ordId = request.getParameter("orderId");

	if(ordId == null || ordId.equals("")){
	out.println("<h2 align=\"center\">Invalid Order ID</h2>");
	} else {
		getConnection();

	// TODO: Check if valid order id
	Statement stmt = con.createStatement();
	ResultSet rst = stmt.executeQuery("Select orderId FROM orderproduct WHERE orderId = '" + ordId + "'");

	String checkID = "";
	while (rst.next())
		checkID = rst.getString("orderId");


	if (!checkID.equals(ordId) || checkID.equals(""))
	out.println("Order ID did not exist. Please try again.");
	else{

	//Set variables to avoid weird glitch from before
	int wanted;
	int inStock;
	String prodId;
	int whId = 1;

	//Checking if the order goes through
	boolean shipmentStatus = true;

	String prevProd = "";
	String shipmentDesc = "";
	String shipmentDesc2 = "";
	//Get data
	ResultSet rst2 = stmt.executeQuery("Select warehouseId, OP.quantity AS wanted, PI.quantity AS inStock, OP.productId AS prodId "
	+"FROM orderproduct OP LEFT JOIN productinventory PI ON OP.productId = PI.productId WHERE orderId = " + ordId +";");

	while(rst2.next()){

		

		String sql = "UPDATE productinventory SET quantity = ? WHERE productId = ? AND warehouseId = ?;";
		PreparedStatement pstmt2 = con.prepareStatement(sql);

		int currentWHId = rst2.getInt("warehouseId");
		wanted = rst2.getInt("wanted");
		inStock = rst2.getInt("inStock");
		prodId = rst2.getString("prodId");

		pstmt2.setInt(1,inStock-wanted);
		pstmt2.setString(2,prodId);


		Statement stmt2 = con.createStatement();
		ResultSet rst3 = stmt2.executeQuery("Select productId "
			+"FROM productinventory WHERE productId = "+prodId+" AND warehouseId = 1;");
		boolean inWarehouse = false;

		while(rst3.next()){
			inWarehouse = true;
		}
		
		if(wanted<=inStock && inWarehouse && 1 == currentWHId){
			out.println("<h3><b>Product ID:</b> " + prodId + ", <b>warehouse ID:</b> 1, <b>quantity:</b> " + wanted + "<b>, Previous Inventory: </b>"
			+ inStock +", <b>New Inventory:</b> "+ (inStock-wanted) +"<b>. Placing order for product</b></h3><br>");
			prevProd = prodId;

			pstmt2.setInt(3,1);

			pstmt2.executeUpdate();

			shipmentDesc+="Product ID: " + prodId + ", Quantity: "+wanted+", Warehouse: 1\n";	
		}
		else{
			stmt2 = con.createStatement();

			rst3 = stmt2.executeQuery("Select productId "
			+"FROM productinventory WHERE productId = "+prodId+" AND warehouseId = 2;");
			inWarehouse = false;

			while(rst3.next()){
				inWarehouse = true;
			}


			rst3 = stmt2.executeQuery("Select PI.quantity AS inStock "
			+"FROM orderproduct OP LEFT JOIN productinventory PI ON OP.productId = PI.productId WHERE orderId = "
			+ ordId + " AND OP.productId = "+prodId+" AND warehouseId = 2;");

			inStock = 0;

			while(rst3.next()){
				inStock = rst3.getInt("inStock");
				pstmt2.setInt(1,inStock-wanted);
				pstmt2.setInt(3,2);
			}

			pstmt2.setInt(1,inStock-wanted);


			if(!(inStock < wanted) && inWarehouse && 2 == currentWHId){
				if (prevProd.equals(prodId))
					continue;

				out.println("<h3><b>Product ID:</b> " + prodId + ", <b>warehouse ID:</b> 2, <b>quantity:</b> " + wanted + "<b>, Previous Inventory: </b>"
				+ inStock +", <b>New Inventory:</b> "+ (inStock-wanted) +"<b>. Placing order for product</b></h3><br>");
				
				pstmt2.setInt(3,2);
	
				pstmt2.executeUpdate();
	
				shipmentDesc2+="Product ID: " + prodId + ", Quantity: "+wanted+", Warehouse: 2\n";
			}

			else{
				if (prevProd.equals(prodId))
					continue;
				out.println("<h3><b>Insufficient stock in warehouse "+currentWHId+". Product ID: " + prodId + "<br></b></h3>");
			}
		}
		
	}

	long currenttime = System.currentTimeMillis();
	Date date = new java.sql.Date(currenttime);
	Timestamp shipmentDate = new java.sql.Timestamp(date.getTime());

	if(!shipmentDesc.equals("")){
		String sql = "INSERT INTO shipment(shipmentDate, shipmentDesc, warehouseId) VALUES (?,?,1);";
		PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		pstmt.setTimestamp(1,shipmentDate);
		pstmt.setString(2,shipmentDesc);	
		pstmt.executeUpdate();
		ResultSet keys = pstmt.getGeneratedKeys();
		keys.next();
		int shipmentId = keys.getInt(1);

		out.println("<h2><b>Warehouse 1 Shipment Successful! Shipment ID: " + shipmentId + "</b></h2><br>");
	}
	else{
		out.println("<h2><b>Nothing could be ordered from warehouse 1.</b></h2><br>");
	}
	if(!shipmentDesc2.equals("")){
		String sql2 = "INSERT INTO shipment(shipmentDate, shipmentDesc, warehouseId) VALUES (?,?,2);";
		PreparedStatement pstmt3 = con.prepareStatement(sql2, Statement.RETURN_GENERATED_KEYS);
		pstmt3.setTimestamp(1,shipmentDate);
		pstmt3.setString(2,shipmentDesc2);
		pstmt3.executeUpdate();

		ResultSet keys = pstmt3.getGeneratedKeys();
		keys.next();
		int shipmentId2 = keys.getInt(1);
		out.println("<h2><b>Warehouse 2 Shipment Successful! Shipment ID: " + shipmentId2 + "</b></h2><br>");
	}
	else{
		out.println("<h2><b>Nothing could be ordered from warehouse 2.</b></h2><br>");
	}
	}
	closeConnection();}
%>                       				

<h2 align="center"><a href="admin.jsp">Return To Admin Page</a></h2>
<h2><a href="index.jsp">Back to Main Page</a></h2>

</body>
</html>
