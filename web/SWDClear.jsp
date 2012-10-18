<%-- 
    Document   : AuthSubmit
    Created on : Apr 12, 2012, 10:40:50 PM
    Author     : Alok
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="LeaveApp.mySqlConnector" %>
<!DOCTYPE html>
<html>


    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Online Leave Application</title>
    </head>
    <body>
        <%try{
            if (session.getAttribute("user")!=null)
                               {
            String status = request.getParameter("status");
            mySqlConnector conclass = new mySqlConnector();
            Connection conn = conclass.connector();
            Statement stmnt = conn.createStatement();
            if (status.equals("All")) {
                stmnt.execute("delete from leaveinfo where status='Expired' or status='Denied' or status='Defaulter'");
            } else if (status.equals("Defaulter")) {
                stmnt.execute("delete from leaveinfo where status='Defaulter'");
            }
            response.sendRedirect("SWD.jsp");
                       }else{
                response.sendRedirect("logout.jsp");
                       }}
            catch (com.mysql.jdbc.exceptions.jdbc4.CommunicationsException me) {

                    response.sendRedirect("commerror.jsp");

                } 

        %>

    </body>
</html>
