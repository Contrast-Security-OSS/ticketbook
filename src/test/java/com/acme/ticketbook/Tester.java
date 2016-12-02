package com.acme.ticketbook;

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
    private static String address = "192.168.100.100";

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

            sendGet( "index.jsp", false );
            sendGet( "architecture.jsp", false );
            sendGet( "check.jsp?ticket=10001", false );
            sendGet( "cmd.jsp?cmd=/tmp", false );
            sendGet( "cookiexss.jsp", false );
            sendGet( "el.jsp", false );
            sendGet( "error.jsp", false );
            sendGet( "flow.jsp?name=Contrast%20Assess%20and%20Protect", false );
            sendGet( "forward.jsp?page=admin.jsp", false );
            sendGet( "hash.jsp?data=thequickbrownfoxjumpedoverthelazydog", false );
            sendGet( "headername.jsp", false );
            sendGet( "headers.jsp", false );
            sendGet( "hpp.jsp?pass1=blah&pass2=blah", false );
            sendGet( "includes.jsp", false );
            sendGet( "list.jsp", false );
            sendGet( "path.jsp?file=constitution.txt", false );
            sendGet( "profile?name=Test&city=Chicago&cc=1234-1234-1234-1234", false );
            sendGet( "redirect.jsp", false );
            sendGet( "request.jsp?url=index.jsp", false );
            sendGet( "response.jsp", false );
            sendGet( "security.jsp", false );
            sendGet( "xom.jsp?xml=%3Ctest%3E%3Cfoo/%3E%3C/test%3E", false );
            sendGet( "xss.jsp?name=jeff", false );
            sendGet( "xxe.jsp?xml=%3Ctest%3E%3Cfoo/%3E%3C/test%3E", false);
        } catch (Exception e ) {
            e.printStackTrace();
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

    
    
}