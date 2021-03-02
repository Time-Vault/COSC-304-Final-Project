<%@ page import="java.util.HashMap" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Haunted Homes - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<div class='container'>
<%
// Get product id from previous page
String productId = request.getParameter("id");

try {
    getConnection();
    NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en", "CA"));

    //Find data for given product id
    String sql = "SELECT * FROM product WHERE productId = ?";
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, productId);

    ResultSet rst = pstmt.executeQuery();
    rst.next();

    String pname = rst.getString("productName");
    out.println("<h2>" + pname + "</h2>");

    // Display product image from URL
    String imgURL = rst.getString("productImageURL");
    if(imgURL != null && !imgURL.trim().isEmpty()) {
        out.println("<img src=" + imgURL + " alt='product image from URL'>");
    }
            
    // Display image from database
    String pImg = rst.getString("productImage");
    if(pImg != null && !pImg.trim().isEmpty()) {
        out.println("<img src='displayImage.jsp?id=" + productId + "' alt='product image file'>");    
    }

    //Other information
    String desc = rst.getString("productDesc");
    Double price = rst.getDouble("productPrice");

    out.println("<table class='table table-sm'><tbody>");
    out.println("<tr> <th>Product ID:</th>      <td>" + productId + "</td></tr>");
    if(desc != null && !desc.trim().isEmpty())
        out.println("<tr> <th>Description:</th> <td>" + desc + "</td></tr>");
    if(price != null)
        out.println("<tr> <th>Price:</th>       <td>" + currFormat.format(price) +"</td></tr>");
    

    //Reviews section
    out.println("<tr> <th>Reviews: </th> <td>");
    out.println("<div class='panel-group'>");
    sql = "SELECT * FROM review R JOIN customer C ON R.customerId=C.customerId WHERE productId = ?";
    PreparedStatement reviewPstmt = con.prepareStatement(sql);
    reviewPstmt.setString(1, productId);

    ResultSet reviewRst = reviewPstmt.executeQuery();
    while(reviewRst.next()) {
        int rating = reviewRst.getInt("reviewRating");
        String comment = reviewRst.getString("reviewComment");
        String userid = reviewRst.getString("userid");
        String reviewDate = reviewRst.getDate("reviewDate").toString();

        out.println("<div class='panel panel-primary'>");
        
            out.println("<div class='panel-heading'>" + userid + " left rating: ");
            for(int i=0; i<rating; i++)
                out.println("<img src='img/star.png' width=20px alt='star'>");
            out.println(" <small>on " + reviewDate +"</small></div>");

            if(comment!=null)
                out.println("<div class='panel-body'>Comment: " + comment + "</div>");
            else
                out.println("<div class='panel-body'><small>No comment available.</small></div>");

        out.println("</div>");
    }
    out.println("</div></td></tr>");
    out.println("</tbody></table>");

    // Links to Add to Cart and Continue Shopping
    out.println("<h3><a href='addcart.jsp?id=" + productId  + "&name=" + URLEncoder.encode(pname) + "&price=" + price + "'>Add to Cart</a></h3>");
    out.println("<h3><a href='review.jsp?id=" + productId + "'>Leave Review</a></h3>");
    out.println("<h3><a href='index.jsp'>Continue Shopping</a></h3>");
}
catch(SQLException e){
    out.println(e);
}
finally {
    closeConnection();
}
%>

</div>

</body>
</html>