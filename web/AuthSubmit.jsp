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
            String auth = request.getParameter("auth");
            String id = request.getParameter("id");
            String leaveid = request.getParameter("leaveID");
            mySqlConnector conclass = new mySqlConnector();
            Connection conn = conclass.connector();
            Statement stmnt = conn.createStatement();

            
            
            
            if (request.getParameter("authsubmit").equals("Submit")) {
                stmnt.executeUpdate("update leaveinfo set status='"+auth+"' where id='"+id+"' and leaveID='"+leaveid+"'");
            } else if (request.getParameter("authsubmit").equals("Cancel")) {
                //Going back
            } else {
                //Error
            }
            response.sendRedirect("PendingLeaves.jsp");
        }
        catch (com.mysql.jdbc.exceptions.jdbc4.CommunicationsException me) {

                    response.sendRedirect("commerror.jsp");

                } 
        %>
    </body>
</html>
