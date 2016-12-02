<%@ page import="com.acme.ticketbook.*"%>
<%@ page import="org.owasp.esapi.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Contrast TicketBook</title>
<link href="/ticketbook/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<%@ include file="/menu.jsp" %>
<H1>Welcome to TicketBook</H1>
<p class="lead">TicketBook is a vulnerable JavaEE application for learning and testing purposes.</p>
	<br>
	<h3>Drag this button onto Eclipse to install Contrast for Eclipse!</h3>
	<a href="http://marketplace.eclipse.org/marketplace-client-intro?mpc_install=1876552" title="Drag and drop into a running Eclipse Indigo workspace to install Contrast for Eclipse">
	  <img width="200" src="http://marketplace.eclipse.org/sites/all/modules/custom/marketplace/images/installbutton.png"/>
	</a>
	
<%@ include file="/footer.jsp" %>
</body>

</html>