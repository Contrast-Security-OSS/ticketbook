<%@page import="org.owasp.esapi.*"%>
<%@page import="com.acme.ticketbook.*"%>
<%@page import="java.net.*"%>
<%@page import="java.nio.charset.*"%>
<%@page import="org.apache.commons.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Server Side Request Forgery (SSRF)</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
	<%@ include file="menu.jsp"%>
	<H1>Server Side Request Forgery (SSRF)</H1>

	<P>Any time an application uses untrusted data to open a URL, an attacker can make it issue forged requests that originate from the targeted server. This can be used to steal data, invoke functions, or as an intranet portscanner.</P>
	<% 
		String url = request.getParameter( "url" );
		if ( url == null ) url = "file:///etc/passwd";
		String pageContent = IOUtils.toString(new URL(url), StandardCharsets.UTF_8);
	%>

	<BR>

	<div class="row">
		<div class="col-md-6">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Enter URL</h3>
				</div>
				<div class="panel-body">
					<form role="form" method="POST">
						<div class="form-group">
							<input id="url" name="url" value="<%=url %>"
								class="form-control" placeholder='Enter URL'>
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
                                        <h3 class="panel-title">URL Content</h3>
                                </div>
                                <div class="panel-body">
					<%=pageContent %>
                                </div>
                        </div>
                </div>
        </div>


	<%@ include file="footer.jsp"%>
</body>

</html>
