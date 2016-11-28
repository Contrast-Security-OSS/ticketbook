<%@page import="com.acme.ticketbook.*"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="nu.xom.Builder" %>
<%@ page import="nu.xom.Document" %>
<%@page import="org.owasp.esapi.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>XML External Entity (XXE)</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<%@ include file="menu.jsp" %>
<H1>XML External Entity (XXE)</H1>

<% String xmldoc=
	"<?xml version=\"1.0\" ?>\n" +
	"<!DOCTYPE biz [<!ENTITY xxetest1 SYSTEM \"/etc/passwd\">]>\n"+
	"<test>\n   &xxetest1;\n</test>\n";
%>

<div>Enter XML Input:</div><BR>
	<form method="POST">
	<textarea rows='8' cols='80' name='xml'><%=xmldoc %></textarea>
	<input type='submit' name='submit' value='Go!'>
	</form>

<%
   String xml = "Enter XML above and hit Go!";
   String param = request.getParameter("xml");
   if ( param != null ) {
	   try {
		   Builder builder = new Builder();
		   Document doc = builder.build(param, null);	
		   xml = doc.toXML();
	   } catch( Exception e ) {
		   xml = "Error processing document: " + e.getMessage();
	   }
   }
%>

<BR>
<BR>

<div>XML Document After Parsing:</div><BR>
	<textarea cols='80' rows='25'>
	<%=xml%>
	</textarea>

<%@ include file="footer.jsp" %>
</body>

</html>