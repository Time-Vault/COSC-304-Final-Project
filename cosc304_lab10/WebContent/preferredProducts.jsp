<%@ page import="java.util.Random" %>
<%@ page import="java.util.ArrayList" %>
<!--This file takes orders of the current user,
    counts the most popular category of purchased
    items and gives back couple of items from this category-->

<% 
    ArrayList<ArrayList<Object>> prefProductList = new ArrayList<ArrayList<Object>>();
    
    //Take most popular categoryId for current user
    String sqlPref = "SELECT TOP 1 categoryId, COUNT(P.productID) AS numProducts FROM customer C"
                        + " JOIN ordersummary O ON C.customerId=O.customerId"
                        + " JOIN orderproduct OP ON O.orderId=OP.orderId"
                        + " JOIN product P ON OP.productId=P.productId"
                        + " WHERE userid = ?"
                        + " GROUP BY categoryId"
                        + " ORDER BY numProducts";

    PreparedStatement pstmtPref = con.prepareStatement(sqlPref);
    pstmtPref.setString(1, userName);
    ResultSet rstPref = pstmtPref.executeQuery();

    //List all products in given category
    if(rstPref.next()){
        int prefCtg = rstPref.getInt("categoryId");

        sqlPref = "SELECT productId, productName, productImageURL FROM product"
                + " WHERE categoryId = ?";
        PreparedStatement prefCtgStmt = con.prepareStatement(sqlPref);
        prefCtgStmt.setInt(1, prefCtg);
        rstPref = prefCtgStmt.executeQuery();
        

        while(rstPref.next()){
            ArrayList<Object> product = new ArrayList<Object>();
            product.add(rstPref.getInt(1));
            product.add(rstPref.getString(2));
            product.add(rstPref.getString(3));
            prefProductList.add(product);
        }
        
        //Choose random product to show
        Random rand = new Random();
        ArrayList<Object> prefProduct = prefProductList.get(rand.nextInt(prefProductList.size()));
        
        Integer pref_pid = (Integer) prefProduct.get(0);
        String pref_pname = (String) prefProduct.get(1);
        String pref_imgURL = (String) prefProduct.get(2);
%>
    <div class="row">
        <h2>Products You Might Like</h2>

<%
out.println("<div class='thumbnail'>");
    out.println("<a href='product.jsp?id=" + pref_pid + "'>");

    // Display product image from URL
    if(pref_imgURL != null && !pref_imgURL.trim().isEmpty()) {
        out.println("<img src=" + pref_imgURL + " alt='product image from URL' class='img-responsive' width='200px'>");
    }

    out.println("<div class='caption'><p class='text-center text-primary'>" + pref_pname + "</p></div>");
    out.println("</a></div></td>");
    }
%>

</div>