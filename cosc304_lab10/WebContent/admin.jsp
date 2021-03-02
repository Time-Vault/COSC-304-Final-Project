<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<%@ include file="header.jsp" %>

	<h2 align="center"><a href="addproduct.jsp">Add Product</a></h2>
	<h2 align="center"><a href="updateProdInput.jsp">Update Product</a></h2>
	<h2 align="center"><a href="listcustomer.jsp">List of Customers</a></h2>
	<h2 align="center"><a href="listtotalorder.jsp">List of Total Orders</a></h2>
	<h2 align="center"><a href="warehouseInventory.jsp">View Warehouse Inventories</a></h2>
	<h2 align="center"><a href="editWHInput.jsp">Update Warehouse Inventories</a></h2>
	<h2 align="center"><a href="index.jsp">Return to Main Menu</a></h2>

    <%@ include file="auth.jsp"%>
    <%@ include file="jdbc.jsp" %>

</body>
</html>

