<%-- 
    Document   : submitsuccess
    Created on : Apr 15, 2012, 2:47:22 AM
    Author     : Pavan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="Resources/css/bootstrap.css" rel="stylesheet">
        <style>
            body {
                padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
                padding-left: 20px;
                padding-right: 20px;
                background-color: #F2F2F2;
            }
            a:link {color: white}
            a:visited {color: white}
        </style>
        <link href="Resources/css/bootstrap-responsive.css" rel="stylesheet">
    
    
    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <a class="brand" href="/">Online Leave Application</a>
                <div class="nav-collapse">
                    <ul class="nav">
                        <li><a href="">Home</a></li>
                        <li><a href="">Apply For Leave</a></li>
                        <li ><a href="studentleavehistory.jsp">Check Status</a></li>
                    </ul>
                    <ul class="nav pull-right">
                        <li  style="margin-top: 10px;margin-right: 20px;color: white"><%=session.getAttribute("name")%></li>
                        <li  ><a href="logout.jsp">Logout</a></li>
                    </ul>    

                </div><!--/.nav-collapse -->

            </div>
        </div>
    </div>

        <title>Online Leave Application Success</title>
    </head>
    <body>
    <center>
        <h1>Leave Application Submitted Successfully!</h1>
        <br /><br /><br />
        <b>Successfully submitted leave application with Leave ID: <u><%= session.getAttribute("leaveID")%></u><br />
            Please note down the Leave ID for further reference.<b>
                <a href="studentleavepage.jsp"><br /><br />
                    <button class="btn" onclick="location.href='studentleavepage.jsp'">Go Back</button>
       
    </center>
    </body>
</html>
