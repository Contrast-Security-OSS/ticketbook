<%@page import="com.acme.ticketbook.*"%>
<%@page import="org.owasp.esapi.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>TBD</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
	<%@ include file="menu.jsp"%>
	<H1>TBD</H1>

	<p>Describe this page.</p> 

	<div class="row">
		<div class="col-md-6">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Enter some data</h3>
				</div>
				<div class="panel-body">
					<form role="form" method="POST" action="test.jsp">
						<div class="form-group">
							<input name="name" id="name" value="${param.name}"
								class="form-control" placeholder='data'>
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
					Content goes here
				</div>
			</div>
		</div>
	</div>

	<%@ include file="footer.jsp"%>
</body>

</html>