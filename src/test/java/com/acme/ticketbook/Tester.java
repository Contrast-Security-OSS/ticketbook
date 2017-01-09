package com.acme.ticketbook;

import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.List;

import org.apache.http.Consts;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.CookieStore;
import org.apache.http.client.config.CookieSpecs;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;


public class Tester {

    private static CloseableHttpClient httpclient = null;
    private static CookieStore cookieStore = null;

    private static String baseUrl = "http://localhost:9080/ticketbook/";
    private static String[] ADDRESSES = {"64.234.2.34", "64.234.2.198", "64.234.100.1", "64.234.100.26"};

    public static void main(String[] args){
        try {
       
            cookieStore = new BasicCookieStore();
            
            RequestConfig globalConfig = RequestConfig.custom()
                    .setCookieSpec(CookieSpecs.DEFAULT)
                    .build();
            
            httpclient = HttpClients.custom()
                    .setDefaultCookieStore(cookieStore)
                    .setDefaultRequestConfig(globalConfig)
                    .build();
            
//            List<NameValuePair> credentials = new ArrayList<NameValuePair>();
//            credentials.add(new BasicNameValuePair("username", "guest"));
//            credentials.add(new BasicNameValuePair("password", "guest"));

            for ( int i = 0; i < 1000; i++ ) {
            	sendAttacks();
            	Thread.sleep(3000);
            }
            
        } catch (Exception e ) {
            e.printStackTrace();
        }
    }
    
    public static String sendGet(String url, boolean xhr ) throws Exception {
        HttpGet httpGet = new HttpGet(baseUrl + url);
        String address = getAddress();
        System.out.println( "GET from " + address + " to " + httpGet.getURI() );
        httpGet.addHeader("X-Forwarded-For", address );
        if ( xhr ) {
            httpGet.addHeader("X-Requested-With","XMLHttpRequest");
        }
        CloseableHttpResponse response = httpclient.execute(httpGet);
        HttpEntity entity = response.getEntity();
        String content = EntityUtils.toString(entity);
        response.close();
        // System.out.println( ">> " + content );
        return content;
    }

	public static void sendAttacks() throws Exception {
        sendGet( "index.jsp", false );
        sendGet( "architecture.jsp", false );
        sendGet( "check.jsp?ticket=10001", false );
        sendGet( "cmd.jsp?cmd=" + getAttack(), false );
        sendGet( "cookiexss.jsp", false );
        sendGet( "el.jsp", false );
        sendGet( "error.jsp", false );
        sendGet( "flow.jsp?name="+getAttack(), false );
        sendGet( "forward.jsp?page=" + getAttack(), false );
        sendGet( "hash.jsp?data=" + getAttack(), false );
        sendGet( "headername.jsp", false );
        sendGet( "headers.jsp", false );
        sendGet( "hpp.jsp?pass1="+ getAttack()+"&pass2=" + getAttack(), false );
        sendGet( "includes.jsp", false );
        sendGet( "list.jsp", false );
        sendGet( "path.jsp?file=" + getAttack(), false );
        sendGet( "profile?name="+getAttack()+"&city="+getAttack()+"&cc="+ getAttack(), false );
        sendGet( "redirect.jsp", false );
        sendGet( "request.jsp?url="+getAttack(), false );
        sendGet( "response.jsp", false );
        sendGet( "security.jsp", false );
        sendGet( "xom.jsp?xml="+getAttack(), false );
        sendGet( "xss.jsp?name=jeff", false );
        sendGet( "xxe.jsp?xml="+getAttack(), false);
    }	    
    public static String sendPost(String url, List<NameValuePair> fields ) throws Exception {
        UrlEncodedFormEntity entity = new UrlEncodedFormEntity(fields, Consts.UTF_8);
        HttpPost httpPost = new HttpPost(baseUrl + url);
        String address = getAddress();
        System.out.println( "POST from " + address + " to " + httpPost.getURI() );
        System.out.println( "   " + fields );
        httpPost.addHeader("X-Forwarded-For", address );
        httpPost.setEntity(entity);
        CloseableHttpResponse response = httpclient.execute(httpPost);
        String content = EntityUtils.toString(response.getEntity());
        response.close();
        System.out.println( "   " + response.getStatusLine() );
        // System.out.println( "   " + content.replaceAll("[\r\n]", "" ) );
        System.out.println();
        return content;
    }
    
    
    
    private static String getAttack() {
        String attack = FRAGS[ RANDOM.nextInt(FRAGS.length) ];
        return URLEncoder.encode( attack );
    }


    private static String getAddress() {
    	return ADDRESSES[ RANDOM.nextInt( ADDRESSES.length ) ];
	}

    private static String getToken() {
        StringBuilder sb = new StringBuilder();
        for ( int i = 0; i < 5; i++ ) {
            sb.append( (char)(RANDOM.nextInt(26) +'a' ) ); 
        }
        for ( int i = 0; i< 3; i++ ) {
            sb.append( (char)(RANDOM.nextInt(10) + '0' ) );
        }
        return sb.toString();
    }
    
    private static SecureRandom RANDOM = new SecureRandom();
    private static String[] FRAGS = {
        "' onmouseover='alert(" + getToken() + ")",
        "\" onmouseover=\"alert(" + getToken() + ")",
        "' or 112=112--",
        "' or 1+2=3 --",
        "' or '1'+'2'='12",
        "><script>alert(1)</script>",
        "../../../../../foo.bar%00",
        "..\\..\\..\\..\\..\\etc\\passwd"
    };
    
}