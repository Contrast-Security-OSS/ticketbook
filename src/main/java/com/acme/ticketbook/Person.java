package com.acme.ticketbook;

import java.security.Key;

import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.servlet.ServletRequest;

import org.apache.log4j.Logger;
import org.owasp.esapi.ESAPI;
import org.owasp.esapi.codecs.Base64;
import org.owasp.esapi.crypto.CipherText;
import org.owasp.esapi.crypto.PlainText;
import org.owasp.esapi.errors.EncryptionException;

public class Person {

	public String name = "Anonymous";
	public String city = "Washington-DC";
	public String creditcard = "";
	private String ticket = "";
	private static Key key = null;
	private static String algorithm = "DES";
	private static int count = 10000;
	public static Person ANONYMOUS;

	public Person(String name, String city, String cc ) {
		initialize();
		setName( name );
		setCity( city );
		setCreditCard( cc );
		setTicket( ""+count++ );
		Logger.getLogger(Person.class).debug( "Creating Person: " + getName() );
	}
	
	public Person(ServletRequest request) {
		this( request.getParameter( "name" ), request.getParameter( "city" ), request.getParameter( "cc" ) );
	}

	public String getName() {
		return name;
	}
	
	public void setName( String name ) {
		if ( name != null ) {
			this.name = name;
		}
	}

	public String getCity() {
		return city;
	}

	private void setCity(String city) {
		this.city = city;
	}

	public String getTicket() {
		return ticket;
	}

	public void setTicket(String ticket) {
		this.ticket = ticket;
	}
	
	public String getCreditCard() {
		return creditcard;
	}

	public void setCreditCard(String cc) {
		if ( cc != null ) {
			this.creditcard = encrypt(cc);
		}
	}
	
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append( "{\n" );
		sb.append( "  \"person\" : {\n");
		sb.append( "    \"name\" : \"" + getName().toUpperCase() + "\",\n" );
		sb.append( "    \"city\" : \"" + getCity() + "\",\n" );
		sb.append( "    \"cred\" : \"" + getCreditCard() + "\"\n" );
		sb.append( "  }\n");
		sb.append( "}\n");
		return sb.toString();
	}

	public static void initialize() {
		try {
			algorithm = System.getProperty( "algorithm" );
			DESKeySpec keyspec = new DESKeySpec("supersecretpassword".getBytes());
			SecretKeyFactory keyFactory = SecretKeyFactory.getInstance( algorithm );
			key = keyFactory.generateSecret(keyspec);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static String encrypt(String str) {
		try {
//			CipherText ct = ESAPI.encryptor().encrypt(new PlainText( str ) );
//			return ct.getBase64EncodedRawCipherText();
			Cipher cipher = Cipher.getInstance( algorithm );
			cipher.init(Cipher.ENCRYPT_MODE, key);
			byte[] encrypted = cipher.doFinal(str.getBytes());
			return Base64.encodeBytes(encrypted);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
