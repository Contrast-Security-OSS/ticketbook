<%@page import="com.acme.ticketbook.*"%>
<%@page import="org.owasp.esapi.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>HTTP Parameter Pollution</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
	<%@ include file="menu.jsp"%>
	<H1>HTTP Parameter Pollution (HPP)</H1>

	<P>HTTP Parameter Pollution (also known as HPP) happens anytime you have a form with no 'action'. For example, the form below has no 'action' and the parameter names are 'user' and 'pass'.</P>
	<P>Now click this link <a href="hpp.jsp?pass1=blah&amp;pass2=blah">hpp.jsp?pass1=blah&pass2=blah</a> and retry the form. See how URL parameters win?</P>
	<% 
		String user = request.getParameter( "user" );
		String pass1 = request.getParameter( "pass1" );
		String pass2 = request.getParameter( "pass2" );
		if ( user == null ) user = "";
		if ( pass1 == null ) pass1 = "";
		if ( pass2 == null ) pass2 = "";
		if ( user.length() > 0 && ( pass1.equals(pass2) ) ) {
			out.println( "<p><i>The password was changed to <span class=\"text-danger\">"+pass1+"</span>.</i></p>");
			user = ""; pass1=""; pass2="";
	    }
	%>

	<BR>

	<div class="row">
		<div class="col-md-6">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Change Password</h3>
				</div>
				<div class="panel-body">
					<form role="form" method="POST">
						<div class="form-group">
							<input id="user" name="user" value="<%=user %>"
								class="form-control" placeholder='Enter username'> <input
								type="password" id="pass1" name="pass1" value="<%=pass1 %>"
								class="form-control" placeholder='Enter password'> <input
								type="password" id="pass2" name="pass2" value="<%=pass2 %>"
								class="form-control" placeholder='Enter password'>
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
