<%@page import="com.acme.ticketbook.*"%>
<%@page import="org.owasp.esapi.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Check Ticket Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<%@ include file="menu.jsp" %>
<H1>Check Ticket Information</H1>

	<div class="row">
		<div class="col-md-6">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Enter Ticket Number</h3>
				</div>
				<div class="panel-body">
					<form class="form-inline" role="form" method="POST" action="check.jsp">
						<div class="form-group">
							<input name="ticket" id="ticket" class="form-control" placeholder='Enter Confirmation'>
						</div>
						<button name="submit" type="submit" class="btn btn-warning">Submit</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<%
		Person p = TicketService.instance().get( request.getParameter( "ticket") );
		if ( p != null ) {
	%>
	<div class="row">
		<div class="col-md-6">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Ticket Information for ${param.ticket}</h3>
				</div>
				<div class="panel-body">
					<pre><%=p %></pre>
					<iframe id="weather" style="overflow: hidden; border: none""
							allowtransparency="true" width="475" height="140"
							src="http://www.weather-forecast.com/locations/<%=p.getCity() %>/forecasts/latest/threedayfree"
							scrolling="no" frameborder="0" marginwidth="0" marginheight="0"></iframe>
					
				</div>
			</div>
		</div>
	</div>
<% } %>

<%@ include file="footer.jsp" %>
</body>

</html>