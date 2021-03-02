<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%

@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	
	productList = new HashMap<String, ArrayList<Object>>();
}

String id = request.getParameter("id");

ArrayList<Object> product = new ArrayList<Object>();
productList.remove(id);

session.setAttribute("productList", productList);
%>
<jsp:forward page="showcart.jsp" />