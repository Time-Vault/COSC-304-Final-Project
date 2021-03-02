<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Your Shopping Cart</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%@ include file="header.jsp"%>

<div class='container'>
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en", "CA"));

	out.println("<h2>Your Shopping Cart</h2>");
	out.print("<table class='table table-bordered'><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
	out.println("<th>Price</th><th>Subtotal</th></tr>");

	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		
		out.println("<tr><td>"+product.get(0)+"</td>");
        out.println("<td>"+product.get(1)+" <small><a href= deleteitem.jsp?id=" + product.get(0) + ">Delete from Cart</a></small></td>");
        out.println("<td>"+product.get(3)+"</td>");
		
		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		

		
		out.print("<td>"+currFormat.format(pr)+"</td>");
		out.print("<td>"+currFormat.format(pr*qty)+"</td></tr>");
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"4\" class='text-right bg-info'>Order Total</th>"
			+"<td text='text-right'>"+currFormat.format(total)+"</th></tr>");
	out.println("</table>");

	out.println("<h3><a href=\"payment.jsp\">Check Out</a></h3>");
}
%>
<h3><a href="index.jsp">Continue Shopping</a></h3>
</div>
</body>
</html> 

