<%@ page import="com.acme.ticketbook.*"%>
<%@ page import="nu.xom.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="org.owasp.esapi.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>XML External Entity (XXE)</title>
<link href="/ticketbook/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<%@ include file="/menu.jsp" %>

<%
	Class.forName("org.hsqldb.jdbcDriver");
	Connection conn = DriverManager.getConnection("jdbc:hsqldb:mem:ticketdb", "sa", "");
	String sql = "SELECT * FROM tickets where name='" + request.getParameter("foo") + "'";
	Statement st = conn.createStatement();
	ResultSet rs = st.executeQuery(sql);
%>
<%@ include file="/footer.jsp" %>
</body>

</html>