<%@page import="com.acme.ticketbook.*"%>
<%@page import="org.owasp.esapi.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
	String param = request.getParameter("name");
	if (param == null) param = "";
	String validated = new String(param);
	try {
		Security.validate(validated);
	} catch(Throwable t) { }
%>

<head>
<title>Cross Site Scripting (XSS)</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
	<%@ include file="menu.jsp"%>
	<H1>Cross Site Scripting (XSS)</H1>

	<p>Cross-Site Scripting (or XSS) happens <span class="text-danger">every</span> time untrusted data is added to HTML, unless that data is properly escaped.
	Untrusted data often comes from the HTTP request parameters, headers, or cookies. But it can also come from your session, database, or other server-side sources.</p> 

	<div class="row">
		<div class="col-md-6">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Enter some data to reflect into HTML</h3>
				</div>
				<div class="panel-body">
					<form role="form" method="POST" action="xss.jsp">
						<div class="form-group">
							<input name="name" id="name" value="<c:out value="${param.name}"/>" class="form-control" placeholder='data'>
						</div>
						<button name="submit" type="submit" class="btn btn-warning">Submit</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-md-6">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Output</h3>
				</div>
				<div class="panel-body">
					<table class="table">
						<tr>
							<td>XSS 1</td>
							<td>JSTL</td>
							<td>${param.name}</td>
							<td><span class="text-danger">Vulnerable</span></td>
						</tr>
						<tr>
							<td>XSS 2</td>
							<td>Scriptlet</td>
							<td><%=request.getParameter("name")%></td>
							<td><span class="text-danger">Vulnerable</span></td>
						</tr>
						<tr>
							<td>XSS 3</td>
							<td>Scriplet</td>
							<td><%=ESAPI.encoder().encodeForHTML(request.getParameter("name"))%></td>
							<td><span class="text-success">Safe (ESAPI)</span></td>
						</tr>
						<tr>
							<td>XSS 4</td>
							<td>Scriplet</td>
							<td><%=Security.html(request.getParameter("name"))%></td>
							<td><span class="text-success">Safe (custom sanitizer)</span></td>
						</tr>
						<tr>
							<td>XSS 5</td>
							<td>JSTL</td>
							<td><%=validated%></td>
							<td><span class="text-success">Safe (custom validator)</span></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>


	<%@ include file="footer.jsp"%>
</body>

</html>