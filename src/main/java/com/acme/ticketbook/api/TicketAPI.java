package com.acme.ticketbook.api;

import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig.Feature;

import com.acme.ticketbook.Person;
import com.acme.ticketbook.TicketService;

import ognl.Ognl;
import ognl.OgnlException;

@SuppressWarnings("serial")
public class TicketAPI extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getPathInfo();
		
		if("/search".equals(action)) {
			handleSearch(request, response);
		} else if("/eval".equals(action)) {
			handleEval(request, response);
		} else {
			throw new IOException("Unknown API: " + action);
		}
	}

	private void handleEval(HttpServletRequest request, HttpServletResponse response) {
		String qs = request.getQueryString();
		if(StringUtils.isEmpty(qs)) {
			throw new IllegalArgumentException("Received empty QS");
		}
		try {
			Object value = Ognl.getValue(qs, null);
			response.getWriter().write(String.valueOf(value));
		} catch (OgnlException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	private void handleSearch(HttpServletRequest request, HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
		if(!"POST".equals(request.getMethod())) {
			throw new IllegalArgumentException("Disallowed HTTP method: " + request.getMethod());
		}
		InputStream is = request.getInputStream();
		ObjectMapper mapper = new ObjectMapper();
		SearchForm form = mapper.readValue(is, SearchForm.class);
		String query = form.getQuery();
		System.out.println("Looking for users with matching name: " + query);
		Map<String, Person> users = TicketService.instance().getUsers();
		List<Person> matches = new LinkedList<Person>();
		for(Person person : users.values()) {
			if(person.getName().contains(query)) {
				matches.add(person);
			}
		}
		
		ServletOutputStream os = response.getOutputStream();
		mapper.enable(Feature.INDENT_OUTPUT);
		mapper.writeValue(os, matches);
	}
}
