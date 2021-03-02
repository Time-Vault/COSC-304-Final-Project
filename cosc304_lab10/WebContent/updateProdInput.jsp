<html>
<head>
<title>Haunted Homes - Product Update</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
        
<%@ include file="header.jsp" %>

<div class='container'>
    <h3>Update Product</h3>
    <form name="MyForm" method=post action="updateproduct.jsp">
        <table class='table table-bordered'>
            <tr>
                <td class='text-center'>Product ID:</td>
                <td><input class="form-control" type="text" name="productId"></td>
            </tr>
            <tr>
                <td class='text-center'>Product Name:</td>
                <td><input class="form-control" type="text" name="productName"></td>
            </tr>
            <tr>
                <td class='text-center'>Product Price:</td>
                <td><input class="form-control" type="text" name="productPrice"></td>
            </tr>
            <tr>
                <td class='text-center'>Image URL:</td>
                <td><input class="form-control" type="text" name="productImageURL"></td>
            </tr>
            <tr>
                <td class='text-center'>Product Description:</td>
                <td><textarea class="form-control" rows="5" name="productDesc"></textarea></td>
            </tr>
            <tr>
                <td class='text-center'>Category ID:</td>
                <td><input class="form-control" type="text" name="categoryId"></td>
            </tr>
        </table>
        <br/>
        <input class="submit" type="submit" name="Submit2" value="Update">
    </form>

    <h3>Delete Product</h3>
    <form name="MyForm" method=post action="deleteproduct.jsp">
        <table class='table table-bordered'>
            <tr>
                <td class='text-center'>Product ID:</td>
                <td><input class="form-control" type="text" name="productId"></td>
            </tr>
        </table>
        <br/>
        <input class="submit" type="submit" name="Submit2" value="Delete">
    </form>
</div>
</body>
</html>
