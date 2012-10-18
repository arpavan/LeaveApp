<%-- 
    Document   : logout
    Created on : Apr 14, 2012, 6:47:40 PM
    Author     : Pavan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Logging out...</h1>
        <% session.invalidate();
            response.sendRedirect("."); %>
    </body>
</html>
