<%@page import="com.acme.ticketbook.*"%>
<%@page import="org.owasp.esapi.*"%>
<%@page import="org.owasp.esapi.codecs.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
	String param = request.getParameter("name");
	if (param == null) param = "";
%>

<head>
<title>Cross Site Scripting (XSS)</title>
<link href="/ticketbook/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
	<%@ include file="/menu.jsp"%>
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
					<form role="form" method="POST" action="xss.jsp" autocomplete="off">
						<div class="form-group">
							<input name="name" id="name" value="" class="form-control" placeholder='data'>
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
					<div>XSS 1: no encoding: 
						<%=request.getParameter("name")%></div>
					<div>XSS 2: no encoding: 
						${param.name}</div>
					<div>XSS 3: wrong encoder: 
						<%=ESAPI.encoder().encodeForOS( new WindowsCodec(), request.getParameter("name") )%></div>
					<div>XSS 4: safe: 
						<%=ESAPI.encoder().encodeForHTML(request.getParameter("name"))%></div>
				</div>
			</div>
		</div>
	</div>


	<%@ include file="/footer.jsp"%>
</body>

</html>
