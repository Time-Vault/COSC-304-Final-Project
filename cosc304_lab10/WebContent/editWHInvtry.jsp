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
      

<%
    // Get needed values
    int pid=-1, quantity=-1, whId=-1;
    String requestFunc="";


    try{
        pid = Integer.parseInt(request.getParameter("pid"));
        quantity = Integer.parseInt(request.getParameter("quantity"));
        whId = Integer.parseInt(request.getParameter("whId"));
        requestFunc = request.getParameter("requestFunc");}
    catch(Exception E){
        out.println("<b>ERROR READING DATA. EXCEPTION INFO:<br>"+E+"</b>");
    }

    //Make sure data exists
	if(pid < 1){
    out.println("<h2 align=\"center\">ERROR IN PRODUCT ID, PLEASE TRY AGAIN</h2>");
    } else if(quantity < 0){
        out.println("<h2 align=\"center\">ERROR IN QAUNTITY, PLEASE TRY AGAIN</h2>");
    } else if(quantity == 0){
        out.println("<h2 align=\"center\">Quantity is 0. Nothing to add or remove.</h2>");
    } else if(whId < 1){
        out.println("<h2 align=\"center\">ERROR IN WAREHOUSE ID, PLEASE TRY AGAIN</h2>");
    }

    else{
	getConnection();

    // Check if valid IDs
    int checkWHID = 0;
	Statement stmt = con.createStatement();
	ResultSet rst = stmt.executeQuery("Select warehouseId FROM warehouse WHERE warehouseId = " + whId);

	while (rst.next())
		checkWHID = rst.getInt("warehouseId");


	if (!(checkWHID == whId)){
        out.println("<h2><b>Requested warehouse does not exist. Please try again.</b></h2>");
        closeConnection();
        out.println("<h2 align='center'><a href='editWHInput.jsp'>Modify More Inventory</a></h2>");
        out.println("<h2 align='center'><a href='admin.jsp'>Return To Admin Page</a></h2>");
        return;}


    int checkpid = 0;
    String sql = "Select productId FROM productinventory WHERE warehouseId = ? AND productId =?";
    PreparedStatement pstmt = con.prepareStatement(sql);

    pstmt.setInt(1,whId);
    pstmt.setInt(2,pid);
    rst = pstmt.executeQuery();

	while (rst.next())
        checkpid = rst.getInt("productId");


	if (!(checkpid==pid) && requestFunc.toUpperCase().equals("REMOVE")){
        out.println("<h2><b>Product does not exist in warehouse. None could be removed.</b></h2>");
        closeConnection();
    }
    else if (!(checkpid==pid)){
        sql = "INSERT INTO productinventory(productId, warehouseId, quantity, price)"+
        " VALUES (?,?,?, (SELECT productPrice FROM product WHERE productId = ?))";
        pstmt = con.prepareStatement(sql);
    
        pstmt.setInt(1,pid);
        pstmt.setInt(2,whId);
        pstmt.setInt(3,quantity);
        pstmt.setInt(4,pid);

        pstmt.executeUpdate();

        out.println("<h2><b>Product was added to warehouse. Total inventory is "+quantity+".</b></h2>");
        closeConnection();
    }


///////////////////////////////////////////////////////////////////////////ADDING OR REMOVING
    else{
    int inStock = 0;
    
    rst = stmt.executeQuery("SELECT quantity FROM productinventory WHERE warehouseId = "
    + whId + " AND productId = "+pid+";");
    while (rst.next())
        inStock = rst.getInt("quantity");

    if(requestFunc.toUpperCase().equals("REMOVE") && inStock < quantity){
        out.println("Not enough of specified product in warehouse. None could be removed.");
        closeConnection();
    } else if(requestFunc.toUpperCase().equals("REMOVE")){
        sql = "UPDATE productinventory SET quantity = quantity - ? WHERE warehouseId = ? AND productId = ?";
        pstmt = con.prepareStatement(sql);
    
        pstmt.setInt(1,quantity);
        pstmt.setInt(2,whId);
        pstmt.setInt(3,pid);

        pstmt.executeUpdate();
        closeConnection();

        out.println("<h2><b>"+quantity+" of product "+pid+" was removed from warehouse "+whId+". Total inventory is "+(inStock-quantity)+".</b></h2>");
    } else{
        sql = "UPDATE productinventory SET quantity = quantity + ? WHERE warehouseId = ? AND productId = ?";
        pstmt = con.prepareStatement(sql);
    
        pstmt.setInt(1,quantity);
        pstmt.setInt(2,whId);
        pstmt.setInt(3,pid);

        pstmt.executeUpdate();
        closeConnection();

        out.println("<h2><b>Product was added to warehouse. Total inventory is "+(quantity+inStock)+".</b></h2>");
    }}}
%> 

<h2 align="center"><a href="editWHInput.jsp">Modify More Inventory</a></h2>
<h2 align="center"><a href="admin.jsp">Return To Admin Page</a></h2>
</body>
</html>