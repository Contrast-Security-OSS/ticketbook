<%
	String uri = request.getRequestURI();
	if ( !uri.endsWith( "check.jsp" ) && !uri.endsWith( "headers.jsp" ) ) {
		response.setHeader("Cache-Control","no-store, no-cache, must-revalidate"); //HTTP 1.1 controls 
		response.setHeader("Pragma","no-cache"); //HTTP 1.0 controls
		response.setDateHeader ("Expires", 0); //Prevents caching on proxy servers
	}
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	

<nav class="navbar navbar-default" role="navigation">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="/ticketbook/index.jsp">
		<img height="25" alt="Contrast Security" src="img/Bug_RGB_512px.png">
      </a>
	</div>
    <div class="collapse navbar-collapse">
	  <h3>TicketBook</h3>
	</div>
  </div>
</nav>

<div class="container-fluid">
	<div class="row">
	
		<!-- Left Side Content -->		
		<div class="col-sm-2">
			<div class="well">	
				<ul class="nav nav-pills nav-stacked">
					<li><a href="/ticketbook/profile">Register</a></li>
					<li><a href="/ticketbook/list.jsp">List</a></li>
					<li><a href="/ticketbook/check.jsp">Check</a></li>
			 		<li><a href="/ticketbook/request.jsp">Request</a></li>
					<li><a href="/ticketbook/response.jsp">Response</a></li>
					<li><a href="/ticketbook/path.jsp">Path</a></li>
					<li><a href="/ticketbook/hpp.jsp">HPP</a></li>
					<li><a href="/ticketbook/el.jsp">EL</a></li>
					<li><a href="/ticketbook/includes.jsp?name=jeff">Includes</a></li>
					<li><a href="/ticketbook/flow.jsp">Flow</a></li>
					<li><a href="/ticketbook/headers.jsp">Headers</a></li>
					<li><a href="/ticketbook/xxe.jsp">XXE</a></li>
					<li><a href="/ticketbook/xss.jsp">XSS</a></li>
					<li><a href="/ticketbook/cmd.jsp">Command</a></li>
					<li><a href="/ticketbook/hash.jsp">Hash</a></li>
					<li><a href="/ticketbook/forward.jsp">Forward</a></li>
					<li><a href="/ticketbook/redirect.jsp">Redirect</a></li>
					<li><a href="/ticketbook/architecture.jsp">Architecture</a></li>
				</ul>
			</div>
		</div>
				
		<!-- Right Side Content -->
		<div class="col-sm-10">
			<div class="well">
