<%@page import="com.acme.ticketbook.*"%>
<%@page import="org.owasp.esapi.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Register with TicketBook</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
	<%@ include file="menu.jsp"%>
	<H1>Register with TicketBook</H1>

	<%
		Person person = (Person)request.getAttribute( ProfileController.PERSON );
		if ( person != null ) { %>
		<div class="row">
			<div class="col-md-6">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">New User Information</h3>
					</div>
					<div class="panel-body">
					<%
						String name = person.getName();
						String first = person.getName().split(" ")[0];
						String city = person.getCity();

					    out.print( "Hello "+first+"!  Thank you for registering with TicketBook! " +
						"We have your full name " + name +
					    	"and hope that you are ready to have a great time in " + city +
					    	". We have encrypted your credit card information as \""+
								person.getCreditCard()+"\" for your protection. " +
					    	"If you need any help, please send email to help@ticketbook.com. Thanks!" );

						
					    out.print( "Hello "+ESAPI.encoder().encodeForHTML(name)+"!  Thank you for registering with TicketBook! " +
						"We have your full name " + ESAPI.encoder().encodeForHTML(name) +
					    	"and hope that you are ready to have a great time in " + ESAPI.encoder().encodeForHTML(city) +
					    	". We have encrypted your credit card information as \""+
								person.getCreditCard()+"\" for your protection. " +
					    	"If you need any help, please send email to help@ticketbook.com. Thanks!" );
					%>
					
					<iframe id="weather" style="overflow: hidden; border: none""
							allowtransparency="true" width="475" height="140"
							src="http://www.weather-forecast.com/locations/"+city+"/forecasts/latest/threedayfree"
							scrolling="no" frameborder="0" marginwidth="0" marginheight="0"></iframe>
					</div>
				</div>
			</div>
		</div>
	<% } %>

	<div class="row">
		<div class="col-md-6">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">New User Information</h3>
				</div>
				<div class="panel-body">
					<form role="form" method="POST" action="profile">
						<div class="form-group">
							<label for="name">Full Name:</label>
							<input name="name" id="name" class="form-control" placeholder="Enter Name" />
							<label for="city">City Name:</label>
							<input name="city" id="city" class="form-control" placeholder="Enter City" />
							<label for="cc">Credit Card:</label>
							<input name="cc" id="cc" class="form-control" placeholder="Enter Credit Card" />
						</div>
						<button name="submit" type="submit" class="btn btn-warning">Submit</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="footer.jsp"%>
</body>

</html>