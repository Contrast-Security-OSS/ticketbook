<%@ page import="com.acme.ticketbook.*"%>
<%@ page import="org.owasp.esapi.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Testing Includes</title>
<link href="/ticketbook/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<%@ include file="/menu.jsp" %>
<H1>Include File Processing</H1>

<p>Include files can be difficult to analyze, as they are only resolved at runtime. With Contrast, these files are assembled into JSPs and compiled into Java class files normally. When a vulnerability is discovered, Contrast calculates the correct include file and the correct line of code.</p> 

<%
	String name=request.getParameter( "name" );
	String name2=request.getParameter( "name" );
%>
<%@ include file="/include1.jsp" %>
<%@ include file="/include2.jsp" %>
<%@ include file="/include3.jsp" %>

<%@ include file="/footer.jsp" %>
</body>

</html>