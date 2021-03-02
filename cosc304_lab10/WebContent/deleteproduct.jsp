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
        authenticatedUser = updateproduct(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }
	//if(authenticatedUser != null)
	//	response.sendRedirect("index.jsp");		
	//else
	//	response.sendRedirect("product.jsp");		
%>


<%!
	String updateproduct(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
        String productId = request.getParameter("productId");
        String productName = request.getParameter("productName");
        String productPrice = request.getParameter("productPrice");
        String productImageURL = request.getParameter("productImageURL");
        String productDesc = request.getParameter("productDesc");
        String categoryId = request.getParameter("categoryId");
        String retStr = productId;
        
		try 
		{
			getConnection();
			
            String sql = "DELETE FROM product WHERE productId = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, productId);
            int rst = pstmt.executeUpdate();
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		finally
		{
			closeConnection();
		}	
		
		if(retStr == null)
		{	session.removeAttribute("Deleteproductmessage");
		}
		else
			session.setAttribute("Deleteproductmessage","Failed to Delete Product");
		return retStr;
	}
%>


<h2 align="center"><a href="admin.jsp">Return To Admin Page</a></h2>
</div>
</body>
</html>