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
        <%
            try{
                if(session.getAttribute("user")!=null)
                                       {
            String id = request.getParameter("id");
            String status = request.getParameter("status");
            String leaveID=request.getParameter("leaveID");
            mySqlConnector conclass = new mySqlConnector();
            Connection conn = conclass.connector();
            Statement stmnt = conn.createStatement();
            if(status.equals("Approved")){
                stmnt.executeUpdate("update leaveinfo set status='OnLeave' where id='"+id+"' and leaveID='"+leaveID+"'");
            } else if(status.equals("OnLeave")){
                stmnt.executeUpdate("update leaveinfo set status='Expired' where id='"+id+"' and leaveID='"+leaveID+"'");
            }
            
            
            response.sendRedirect("GateLeaves.jsp");
            }else
                               {
                    response.sendRedirect("logout.jsp");
            }}
            catch (com.mysql.jdbc.exceptions.jdbc4.CommunicationsException me) {

                    response.sendRedirect("commerror.jsp");

                } 
        %>
        
    </body>
</html>
