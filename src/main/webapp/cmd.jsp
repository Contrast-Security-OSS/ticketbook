<%@page import="com.acme.ticketbook.*"%>
<%@page import="org.owasp.esapi.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
	String param = request.getParameter("name");
	if (param == null) param = "";
	if(System.getProperty("os.name").contains("Windows")) {
		Runtime.getRuntime().exec( "dir /s " + param );	
	} else {
		Runtime.getRuntime().exec( "ls " + param );
	}
	
%>

<head>
<title>Command Injection</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
	<%@ include file="menu.jsp"%>
	<H1>Command Injection</H1>

	<p>Command Injection happens when untrusted data is added is sent to an API designed to launch an operating system executable.
	Untrusted data often comes from the HTTP request parameters, headers, or cookies. But it can also come from your session, database, or other server-side sources.</p> 

	<div class="row">
		<div class="col-md-6">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Enter some data to add to the 'ls' command (try ;netstat -a)</h3>
				</div>
				<div class="panel-body">
					<form role="form" method="POST" action="cmd.jsp">
						<div class="form-group">
							<input name="protocol" id="protocol" value="netstat -an" class="form-control" placeholder="data">
						</div>
						<button name="submit" type="submit" class="btn btn-warning">Submit</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="footer.jsp"%>
</body>

</html>