<%@page import="com.acme.ticketbook.*"%>
<%@page import="org.owasp.esapi.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="cache-control" content="no-cache,foo" />
<title>Setting Response Headers</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<%@ include file="menu.jsp" %>
<H1>Setting Response Headers</H1>
<p>My cache headers are set to:</p>
<pre>cache-control: no-cache,foo</pre>
<BR>
<p>Try using:</p>
<pre>
response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");</li>
response.setHeader("Pragma","no-cache");</li>
response.setHeader("Expires","-1");</li>
</pre>
<%@ include file="footer.jsp" %>
</body>

</html>
