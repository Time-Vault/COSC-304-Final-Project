<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp"%>
<%
	String validCard = null;
	session = request.getSession(true);

	try {
		validCard = validatePayment(out, request, session);
	} catch (IOException e) {
		System.err.println(e);
	}

	if (validCard != null)
		response.sendRedirect("checkout.jsp"); // Valid payment method
	else
		response.sendRedirect("payment.jsp"); // Invalid payment method -> Remain in Payment page, user inserts new method
%>


<%-- <%!String validatePayment(JspWriter out, HttpServletRequest request, HttpSession session) throws IOException { --%>
// 		Integer cardNum = Integer.parseInt(request.getParameter("number"));
// 		String expDate = request.getParameter("expdate");
// 		Integer code = Integer.parseInt(request.getParameter("code"));
// 		String retStr = null;

// 		if (expDate == null)
// 			return null;
// 		else if ((cardNum.toString().length() != 10) || (cardNum.toString().length() != 3))
// 			return null;
		
// 		return "Hi";
// 		}
<%-- 	%> --%>

