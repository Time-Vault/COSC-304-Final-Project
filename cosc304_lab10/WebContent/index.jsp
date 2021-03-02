<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>

<head>
    <title>Haunted Homes</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

    <!-- Navigation Bar -->
    <%@ include file="header.jsp" %>

    <!-- Main Content -->
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="row">
                    <h2>About Us</h2>
                    <p>Welcome to Haunted Homes, user! We are the world's largest supplier and shipper of replica properties, and real ghosts!</p>
                </div>

<% // Get product name to search for
String name = request.getParameter("productName");
String ctg = request.getParameter("category");
                
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
        out.println("ClassNotFoundException: " +e);
}

try {
        getConnection();
        
        NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en", "CA"));
        ResultSet rst;

        //If user is logged in, display products they might like
        if(userName != null && !userName.trim().isEmpty()){
    %>
            <%@ include file="preferredProducts.jsp" %>
    <%
        }
%>      

        <!--Categories column-->
        <div class="row">
            <h2>Categories</h2>
            <ul class="nav nav-pills nav-stacked well">
 <%      
        //Get categories list
        String sqlctg = "SELECT * FROM category ORDER BY categoryName ASC";
        Statement stmtctg = con.createStatement();
        ResultSet ctgRst = stmtctg.executeQuery(sqlctg);

        while(ctgRst.next()){
            String ctgName = ctgRst.getString("categoryName");
            out.println("<li><a href='index.jsp?category="+ URLEncoder.encode(ctgName) +"'>" + ctgName + "</a></li>");
        }
%>
            </ul>
        </div>
    </div>

        <!--Product List-->
        <div class="col-md-8">
<%
    //Get product list corresponding to input
    if(name != null && !name.trim().isEmpty()){
        String sql = "SELECT * FROM product" +
                    " WHERE productName LIKE ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, "%" + name + "%");
        rst = pstmt.executeQuery();

        out.println("<h2>Products containing '" + name + "'</h2>");
    }
    else if(ctg != null && !ctg.trim().isEmpty()){
        String sql = "SELECT * FROM category C JOIN product P ON C.categoryId = P.categoryId WHERE categoryName = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, ctg);
        rst = pstmt.executeQuery();

        out.println("<h2>Products in category '"+ ctg +"'</h2>");
    }
    else {
        String sql = "SELECT * FROM product";
        Statement stmt = con.createStatement();
        rst = stmt.executeQuery(sql);

        out.println("<h2>All Products</h2>");
    }
    
    //Print table header
    out.println("<table class='table table-striped table-bordered'>");
    out.println("<thead class='thead-dark'><tr> <th scope='col'>Product</th>");
    out.println("<th scope='col' class='text-center'>Price</th>");
    out.println("<th scope='col' class='text-center'>Add to Cart</th> </tr></thead>");

    //Print table values
    while(rst.next()) {
        String pname = rst.getString("productName");
        double price = rst.getDouble("productPrice");
        int pid = rst.getInt("productId");

        out.println("<tr> <td>");
        out.println("<div class='thumbnail'>");
        out.println("<a href='product.jsp?id=" + pid + "'>");

        // Display product image from URL
        String imgURL = rst.getString("productImageURL");
        if(imgURL != null && !imgURL.trim().isEmpty()) {
            out.println("<img src=" + imgURL + " alt='product image from URL' class='img-responsive' width='200px'>");
        }
                
        // Otherwise, display image from database
        else { 
            String pImg = rst.getString("productImage");
            if(pImg != null && !pImg.trim().isEmpty()) {
                out.println("<img src='displayImage.jsp?id=" + pid + "' alt='product image file' class='img-responsive'>");    
            }
        }

        out.println("<div class='caption'><p class='text-center text-primary'>" + pname + "</p></div>");
        out.println("</a></div></td>");


        out.println("<td class='text-center'>" + currFormat.format(price) + "</td>");
        out.println("<td class='text-center'><a href=addcart.jsp?id="
            + pid  + "&name=" + URLEncoder.encode(pname) + "&price=" + price + ">");
        out.println("Add to Cart <img src='img//shopping_cart.png' width=20px></a></td> </tr>");
    }
    out.println("</table>");
}
catch(java.sql.SQLException e) {
    out.println(e);
}
finally {
    closeConnection();
}
%>
</div>

</body>
</head>