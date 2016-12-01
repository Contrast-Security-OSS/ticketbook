<!doctype html>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%@ page import="javax.sql.*" %>
<%@ page import="java.sql.*" %>

<%!
	public Connection getConnection() throws SQLException {
//		return DriverManager.getConnection( "jdbc:mysql://localhost:3306/YOUR_SCHEMA?user=YOUR_USERNAME&password=YOUR_PASSWORD" );
	 	return DriverManager.getConnection("jdbc:hsqldb:mem:ticketdb", "sa", "");
	}
%>


<html>
	<head>
		<title>SQL Injection example</title>
	</head>
	<body>
	<p>
	<%
		// Logger logger = LoggerFactory.getLogger( "sqli-example.jsp" );
		try {
			try( Connection c = getConnection() ) {
				try( Statement t = c.createStatement() ) {
					t.execute( "SELECT * FROM Tickets WHERE id='" + request.getParameter("id") + "'" );
					// logger.info( "Query executed!" );
					out.write( "Query executed!<br />" );
				}
			}
		} catch( SQLException e ) {
			e.printStackTrace();
			out.write( "Error running query<br />" );
		}
	%>
	</p>
	<p>
		Bug description: When this JSP is loaded, the Contrast Java Agent successfully reports a few vulnerabilities to the Eclipse plugin,
		but the SQL injection on line 28.
		
		This JSP has the JAR dependencies:
		<ul>
			<li>SLF4J API - see standard output for SQLException stack traces</li>
			<li>Logback Core, or another SLF4J implementation</li>
			<li>Connector/J (bug reproduced on v5.1.30)</li>
		</ul>
		
		Bug reproduced on software versions:
		<ul>
			<li>Java 1.8.0_20</li>
			<li>Apache Tomcat/8.0.12</li>
			<li>Connector/J v5.1.30</li>
			<li>Eclipse v4.4.1</li>
			<li>Contrast for Eclipse v1.0.0</li>
		</ul>
		
		You are running the following software versions:
		<ul>
			<li>Java <%= System.getProperty("java.version") %></li>
			<li><%= request.getServletContext().getServerInfo() %></li>
		</ul>
	</p>
	<p>
		
	</p>
	</body>
</html>