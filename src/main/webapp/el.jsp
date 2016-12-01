<%@ page import="com.acme.ticketbook.*"%>
<%@ page import="org.owasp.esapi.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>HTTP Parameter Pollution</title>
<link href="/ticketbook/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
	<%@ include file="/menu.jsp"%>
	<H1>Expression Language Injection</H1>

	<P>Expression language injection happens when untrusted data is sent to an expression engine. If the attacker sends
	just the right expression, they can invoke their own code and take over your server.</P>
	<% 
		String input = request.getParameter( "input" );
		if ( input == null ) input = "${8 * 8}";
		javax.servlet.jsp.el.ExpressionEvaluator ee = new ExpressionEvaluator();
		Object result = ee.evaluate(
				input,
				int.class,
				null,
				null );
	%>

	<BR>

	<div class="row">
		<div class="col-md-12">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Enter an expression:</h3>
				</div>
				<div class="panel-body">
					<form role="form" method="POST" autocomplete="off">
						<div class="form-group">
							<input id="input" name="input" value="<%=ESAPI.encoder().encodeForHTML(input) %>" class="form-control" placeholder='Enter username'>
						</div>
						<button name="submit" type="submit" class="btn btn-warning">Submit</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Expression Result</h3>
				</div>
				<div class="panel-body">
					<div><%=result %></div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/footer.jsp"%>
</body>

</html>
