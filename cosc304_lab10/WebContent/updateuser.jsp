<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);

	try
	{
        authenticatedUser = updateuser(out,request,session);
        out.println("test");
	}
	catch(IOException e)
	{	System.err.println(e); }

	//if(authenticatedUser != null)
	//	response.sendRedirect("index.jsp");		
	//else
	//	response.sendRedirect("customer.jsp");		
%>


<%!
	String updateuser(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
        String customerId = request.getParameter("customerId");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String phonenum = request.getParameter("phonenum");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String postalCode = request.getParameter("postalCode");
        String country = request.getParameter("country");
        String userid = request.getParameter("userid");
        String password = request.getParameter("password");

        String retStr = firstName;
        int rst = 0;
        
		try 
		{
			getConnection();
			
            String sql = "UPDATE customer SET firstName=?, lastName=?, email=?, phonenum=?, address=?, city=?, state=?, postalCode=?, "
            + "country=?, userid=?, password=? WHERE customerId = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, firstName);
            pstmt.setString(2, lastName);
            pstmt.setString(3, email);
            pstmt.setString(4, phonenum);
            pstmt.setString(5, address);
            pstmt.setString(6, city);
            pstmt.setString(7, state);
            pstmt.setString(8, postalCode);
            pstmt.setString(9, country);
            pstmt.setString(10, userid);
            pstmt.setString(11, password);
            pstmt.setString(12, customerId);
            rst = pstmt.executeUpdate();
            out.println(rst);
            out.println("test2");			
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		finally
		{
			closeConnection();
		}	
		
		if(retStr == null)
		{	session.removeAttribute("Createusermessage");
		}
		else
			session.setAttribute("Createusermessage","Failed to Create User");

		return retStr;
	}
%>