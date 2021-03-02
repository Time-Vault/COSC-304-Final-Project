<!DOCTYPE html>
<html>
<head>
<title>Checkout</title>
</head>
<body>
	<%@ include file="auth.jsp"%>
	<%@ include file="jdbc.jsp"%>

	<h1>Enter your information to complete the transaction:</h1>

	<br>
	<form method="get" action="validatePayment.jsp">
		<table style="display: inline">

			<%
				String userName = (String) session.getAttribute("authenticatedUser");

				out.println("Select your payment type"); 
			%>
			<br>

			<input type="radio" name="details" value="visa"> Visa<br>
			<input type="radio" name="details" value="mastercard"> MasterCard<br>
			<input type="radio" name="details" value="paypal"> Pay Pal<br>
			<br> Card Number:
			<input type="number" name="number" required minlength="10"><br>
			<br> Expiry Date:
			<input type="date" name="expdate">
			<br>
			<br> Security Code:
			<input type = "number" name = "code" required minlength="3">
			<br>
			<tr>
				<td><div align="right">
						<input type="submit" value="Submit"><input type="reset"
							value="Reset">
					</div></td>
			</tr>
		</table>
	</form>
	<br />

</body>
</html>

