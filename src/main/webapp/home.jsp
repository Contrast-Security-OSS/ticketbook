<%@page import="com.acme.ticketbook.*"%>
<%@page import="org.owasp.esapi.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Contrast TicketBook</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<%@ include file="menu.jsp" %>
<H1>Using Contrast in Development</H1>
<p class="lead">TicketBook is a simple JavaEE web application to demonstrate the use of Contrast from within your IDE while you are writing and testing code.</p>
	<ul>
		<li>First, log into your Contrast account and download "contrast.jar".</li>
		<li>Open your server "launch configuration" and add <span class="text-danger">-javaagent:PATH/contrast.jar</span> to the JVM configuration.</li>
		<li>Start your server and start coding and testing.</li>
		<li>Set up a Contrast email alert for "everything".</li>
		<li>Check your email or your Contrast dashboard for security vulnerabilities and more!</li>
		<li>Don't check in code until it's <span class="text-danger">Contrast Clean</span>!</li>
	</ul>

	<center><img class="img-rounded" src="img/config.png" /></center>
	
<%@ include file="footer.jsp" %>
</body>

</html>