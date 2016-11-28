package com.acme.ticketbook;

import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;

public class Security {
	private static final String PASSWORD = "advsdv";
	private static byte[] IV = new byte[]{0x00};
	
	public static String html(String s) {
		if(s == null) return null;
		s = s.replaceAll("<", "&lt;");
		s = s.replaceAll(">", "&gt;");
		s = s.replaceAll("&", "&amp;");
		return s;
	}
	
	public static void validate(String s) {
		for(char c : s.toCharArray()) {
			if(c == '<') {
				throw new IllegalArgumentException();
			}
		}
	}
	
	public static boolean checkCSRFToken(HttpServletRequest request) {
		String token = request.getParameter("token");
		String expectedToken = (String) request.getSession().getAttribute("CSRFToken");
		return expectedToken != null && expectedToken.equals(token);
	}
	
	public void encrypt() throws NoSuchAlgorithmException {
		KeyFactory spec = KeyFactory.getInstance("DESede");
	}
}
