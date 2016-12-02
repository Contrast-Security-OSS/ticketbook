<%@ page import="com.acme.ticketbook.*"%>
<%@ page import="org.owasp.esapi.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Displaying Request Headers</title>
<link href="/ticketbook/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<%@ include file="/menu.jsp" %>
<H1>Displaying Request Headers</H1>
<p>This is the User-agent header:</p>
<pre><%=request.getHeader("User-agent")%></pre>
<%@ include file="/footer.jsp" %>
</body>

</html>
