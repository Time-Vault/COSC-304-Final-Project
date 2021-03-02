<!DOCTYPE html>
<html>
<head>
<title>Add Product</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<%@ include file="header.jsp" %>

<div style="margin:0 auto;text-align:center;display:inline">

<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);

	try
	{
		authenticatedUser = validateaddproduct(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	//if(authenticatedUser != null)
	//	response.sendRedirect("index.jsp");		
	//else
	//	response.sendRedirect("addproduct.jsp");		
%>


<%!
	String validateaddproduct(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{

		String productName = request.getParameter("productName");
        String productPrice = request.getParameter("productPrice");
        String productImageURL = request.getParameter("productImageURL");
        String productDesc = request.getParameter("productDesc");
        String categoryId = request.getParameter("categoryId");

		if(productName == null || productPrice == null || productDesc == null || categoryId == null)
				return null;
		if((productName.length() == 0) || (productPrice.length() == 0) || (productDesc.length() == 0) || (categoryId.length() == 0))
				return null;	
		try 
		{
			getConnection();
			
			if(!(productImageURL == null)){
				String sql = "INSERT INTO product (productName, productPrice, productImageURL, productDesc, categoryId) "
				+ "VALUES (?, ?, ?, ?, ?)";
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setString(1, productName);
				pstmt.setString(2, productPrice);
				pstmt.setString(3, productImageURL);
				pstmt.setString(4, productDesc);
				pstmt.setString(5, categoryId);
				out.println(pstmt.executeUpdate());
			} else{
				String sql = "INSERT INTO product (productName, productPrice, productImageURL, productDesc, categoryId) "
				+ "VALUES (?, ?, 'img/?.jpg', ?, ?)";
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setString(1, productName);
				pstmt.setString(2, productPrice);
				pstmt.setString(3, categoryId);
				pstmt.setString(4, productDesc);
				pstmt.setString(5, categoryId);
				out.println(pstmt.executeUpdate());		
			}	
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		finally
		{
			closeConnection();
		}	
		
		return "Product added.";
	}
%>


<h2 align="center"><a href="admin.jsp">Return To Admin Page</a></h2>
</div>
</body>
</html>