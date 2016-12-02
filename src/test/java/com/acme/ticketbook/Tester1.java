package com.acme.ticketbook;

import net.sf.jsptest.HtmlTestCase;

// FIXME: had to comment out in POM as it was clobbering real JSP compiler.
public class Tester1 extends HtmlTestCase {

    protected String getWebRoot() {
        return "src/main/webapp";
    }

    public void testRenderingTrivialJsp() throws Exception {
        get("/index.jsp");
        output().shouldContain("Welcome to TicketBook");
    }
}