<%-- 
    Document   : userpage
    Created on : Apr 12, 2012, 1:25:07 PM
    Author     : Pavan
--%>

<%@page import="LeaveApp.mySqlConnector"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel=stylesheet href="Resources/css/bootstrap.min.css" type="text/css">
        <link rel=stylesheet href="Resources/css/bootstrap-responsive.css" type="text/css">
        <link rel=stylesheet href="Resources/css/bootstrap-responsive.min.css" type="text/css">
       
        <script type="text/javascript" src="Resources/js/bootstrap.js" ></script>
        <script type="text/javascript" src="Resources/js/bootstrap.min.js" ></script>
        
        <title>Online Leave Management System</title>
    </head>
    <body>
        <h1>Employee Page</h1><br /><br /><br />
        <%
            try {
                String query = null;
                ResultSet result = null;
                mySqlConnector conclass = new mySqlConnector();
                Connection conn = conclass.connector();
                Statement stmnt = conn.createStatement();
                String username = null;
                query = "select name from employee,staff where employee.id=staff.id and staff.username='" + session.getAttribute("user") + "';";
                result = stmnt.executeQuery(query);
                while (result.next()) {
                        username = result.getString(1);
                }
                
                
                if (session.getAttribute("user") != null) {
                    out.println("Hello, " + username);
                    out.println("You have successfully logged in as SWD/Gate/Mess!");
                    %><br /><br /><br /><a href="." onclick="<% session.invalidate();%>">Logout</a><%
            } else {
                    out.println("Sorry! You are not authorized to view this page!");
                    %><br /><br /><br /><a href=".">Go Back</a><%
            }
        } catch (IllegalStateException e) {
            session.setAttribute("auth", "error");
            response.sendRedirect(".");
            out.println("Error! Please Login again to continue.");
        %><br /><br /><br /><a href=".">Go Back</a><%
            }

        %>
    </body>
</html>
