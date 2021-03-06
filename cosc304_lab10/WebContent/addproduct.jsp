<!DOCTYPE html>
<html>
<head>
<title>Add Product</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<div class='container'>

<h3>Add Product</h3>

<%
// Print prior error login message if present
if (session.getAttribute("addproductmessage") != null)
	out.println("<p>"+session.getAttribute("addproductmessage").toString()+"</p>");
%>

<br>
<form name="MyForm" method=post action="validateaddproduct.jsp">
<table class='table table-bordered'>
<tr>
	<td class='text-center'>Product Name:</td>
	<td><input class="form-control" type="text" name="productName"></td>
</tr>
<tr>
	<td class='text-center'>Product Price:</td>
	<td><input class="form-control" type="text" name="productPrice"></td>
</tr>
<tr>
	<td class='text-center'>Image URL:</td>
	<td><input class="form-control" type="text" name="productImageURL"></td>
</tr>
<tr>
	<td class='text-center'>Product Description:</td>
	<td><textarea class="form-control" rows="5" name="productDesc"></textarea></td>
</tr>
<tr>
	<td class='text-center'>Category ID:</td>
	<td><input class="form-control" type="text" name="categoryId"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Add Product">
</form>

<h2 align="center"><a href="admin.jsp">Return To Admin Page</a></h2>

</div>
</body>
</html>