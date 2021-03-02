<%@ page import="java.util.Date" %>
<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>

<%
    //Get all info about a review
    String rating = (String) request.getParameter("rating");
    String comment = (String) request.getParameter("comment");
    String userId = (String) session.getAttribute("authenticatedUser");
    Integer productId = Integer.parseInt((String) session.getAttribute("reviewedId"));
    Integer customerId = null;

    long timenow = System.currentTimeMillis();
	Timestamp date = new java.sql.Timestamp(timenow);

    try {
        getConnection();

        //Get customerId based on logged in user
        String sql = "SELECT customerId FROM customer WHERE userid = ?";
        PreparedStatement userpstmt = con.prepareStatement(sql);
        userpstmt.setString(1, userId);

        ResultSet userrst = userpstmt.executeQuery();
        if(userrst.next()) {
            customerId = userrst.getInt("customerId");
        }

        //Add review to the database
        sql = "INSERT INTO review (reviewRating, reviewDate, reviewComment, customerId, productId) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, rating);
        pstmt.setTimestamp(2, date);

        if(comment!=null && !comment.trim().isEmpty()) { pstmt.setString(3, comment); }
        else { pstmt.setNull(3, Types.NULL); }

        pstmt.setInt(4, customerId);
        pstmt.setInt(5, productId);

        //If successful, print the message and 
        if(pstmt.executeUpdate() > 0){
            session.setAttribute("reviewProcessed", true);
            session.setAttribute("reviewedId", null);
        }

        response.sendRedirect("review.jsp?id=" + productId);
    }
    catch(SQLException e){
        out.println(e);
    }
    finally {
        closeConnection();
    }
%>