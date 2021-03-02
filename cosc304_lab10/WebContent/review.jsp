<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<html>
<head>
<title> Leave a review </title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<div class='container'>
<%
// Get product id, userName is from header
String productId = request.getParameter("id");

//Check if review previously submitted
if(session.getAttribute("reviewProcessed") != null) {
    out.println("<h2>Thanks for your contribution!</h2>");
    out.println("<h3><a href='product.jsp?id=" + productId + "'>Back to Product Page</a></h3>");
    out.println("<h3><a href='index.jsp'>Continue Shopping</a></h3>");
    session.setAttribute("reviewProcessed", null);
}

//Check if user authorized
else if(userName == null || userName.trim().isEmpty()){
    out.println("<h2>You need to be logged in to leave a review.</h2>");
    out.println("<h3><a href='login.jsp'>Log In</a></h3>");
    out.println("<h3><a href='product.jsp?id=" + productId + "'>Back to Product Page</a></h3>");
    out.println("<h3><a href='index.jsp'>Continue Shopping</a></h3>");
}
 
else{
    try {
        getConnection();

        String sql = "SELECT productName, productImageURL FROM product WHERE productId = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, productId);

        ResultSet rst = pstmt.executeQuery();
        if(rst.next()) {
            String imgURL = rst.getString("productImageURL");
            out.println("<h2>Let us know what you think of '" + rst.getString("productName") + "'.</h2>");
            if(imgURL!=null && !imgURL.trim().isEmpty())
                out.println("<img class='img-thumbnail center-block' src='" + rst.getString("productImageURL") + "'>");
        }
%>

<!--Review form-->
<div class="container well">
    <form method="post" action="processReview.jsp">
        <div class="form-group">
            <label for="rating">Rating:</label>
            <select class="form-control" id="rating" name="rating">
            <option>1</option>
            <option>2</option>
            <option>3</option>
            <option>4</option>
            <option>5</option>
            </select>
        </div>
        <div class="form-group">
            <label for="comment">Comment:</label>
            <textarea class="form-control" rows="5" id="comment" name="comment"></textarea>
        </div>
        <button type="submit" class="btn btn-default">Submit</button>
    </form>
</div>

<%
        session.setAttribute("reviewedId", productId);
    }
    catch(SQLException e){
        out.println(e);
    }
    finally {
        closeConnection();
    }
}
%>

</div>

</body>
</html>