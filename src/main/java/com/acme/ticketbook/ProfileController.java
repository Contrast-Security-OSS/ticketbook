package com.acme.ticketbook;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class ProfileController extends HttpServlet {

	public static String PERSON = "person";
	public static String VALIDATED = "validated";
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String loc = request.getParameter("redir");
		String fwd = request.getParameter("fwd");
		if(loc != null) {
			response.sendRedirect(loc);
			return;
		}
		if(fwd != null) {
			request.getRequestDispatcher(fwd).forward(request, response);
		}
		
		Security.checkCSRFToken(request);
		if ( request.getParameter( "name" ) != null ) {
			Person p = new Person( request );
			TicketService.instance().create( p );
			request.setAttribute( PERSON, p );
		}
		
		// forward to view
		getServletContext().getRequestDispatcher("/profile.jsp").forward(request, response);
	}
	
}
