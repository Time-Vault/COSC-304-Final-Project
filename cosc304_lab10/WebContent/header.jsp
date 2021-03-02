<nav class="navbar navbar-inverse">
    <div class="container">
    
        <div class="navbar-header">
            <a class="navbar-brand" href="#">Haunted Homes</a>
        </div>
            
        <form class="navbar-form navbar-right" action="index.jsp">
            <div class="form-group">
                <input type="text" class="form-control" placeholder="Enter product name..." name="productName" size="30">
            </div>
            <button type="submit" class="btn btn-default">
                <img src="img/magnifier.png" width="18px"> Search</button>
            <button type="reset" class="btn btn-default">Reset</button>
        </form>
        <div class="navbar-text navbar-right">
            <%
                String userName = (String) session.getAttribute("authenticatedUser");
                if(userName != null){
                        out.println("Welcome, "+userName+"!");
                }
            %>
        </div>

        <div class="navbar-header navabar-left">
            <!--svg provided by https://www.flaticon.com/authors/smashicons-->
            <img src="img/haunted-house.svg" width="35px" style="margin-top: 0.5em">
        </div>
        <ul class="nav navbar-nav">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="customer.jsp">Customer Info</a></li>
            <li><a href="admin.jsp">Administrators</a></li>
            <li><a href="listorder.jsp">List All Orders</a></li>
            <li><a href="login.jsp">Login</a></li>
            <li><a href="logout.jsp">Log out</a></li>
        </ul>
    </div>
</nav>