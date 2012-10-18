<%-- 
    Document   : leavedetails
    Created on : Mar 25, 2012, 4:50:47 PM
    Author     : paritosh
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="LeaveApp.mySqlConnector" %> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>

    <link href="Resources/css/bootstrap.css" rel="stylesheet">
    <style>
        body {
            padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
            padding-left: 20px;
            padding-right: 20px;
            background-color: #F2F2F2;
        }
    </style>
    <link href="Resources/css/bootstrap-responsive.css" rel="stylesheet">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
            function validateForm()
            {
                
                if(!document.getElementById('Approved').checked && !document.getElementById('Denied').checked) {
                    alert("Please select an option");
                    return false;
                }

                
            }
        </script>
        <title>Wardens - Online Leave Application</title>
    </head>
    <%
        String id = request.getParameter("id");
        String leaveID=request.getParameter("leaveID");
        String wardenname = session.getAttribute("wardenname").toString();
        mySqlConnector conclass = new mySqlConnector();
        Connection conn = conclass.connector();
        Statement stmnt = conn.createStatement();

        ResultSet result = stmnt.executeQuery("select * from student,leaveinfo where student.id=leaveinfo.id and student.id='" + id + "' and leaveID='"+leaveID+"'");
        result.next();
        String name = result.getString("name");
        String hostel = result.getString("hostel");
        String room = result.getString("room");
        String contactno = result.getString("contactno");
        String reason = result.getString("reason");
        //String leaveID = result.getString("leaveID");
        String fromdate = result.getString("startDate");
        String todate = result.getString("endDate");
    
    %>
    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <a class="brand" href="/">Online Leave Application</a>
                <div class="nav-collapse">
                    <ul class="nav">
                        <li class="active"><a href="PendingLeaves.jsp">Home</a></li>
                        </ul>
                    <ul class="nav pull-right">
                        <li  style="margin-top: 10px;margin-right: 20px;color: white"><%=wardenname%></li>
                        <li  ><a href="logout.jsp">Logout</a></li>
                    </ul>
                </div><!--/.nav-collapse -->

            </div>
        </div>
    </div>

    <body>
        
        <div align="center"  >
        <h1 >Leave Details</h1><br><br>
        
        <table style="empty-cells: show">
            <tr>
                <td><b>Name: </b></td>
                <td> <%=name%></td>
            </tr>
            <tr>
                <td><b>ID: </b></td>
                <td> <%=id%></td>
            </tr>
            <tr>
                <td><b>Hostel: </b></td>
                <td> <%=hostel%> <%=room%></td>
            </tr>
            <tr>
                <td><b>Contact: </b></td>
                <td> <%=contactno%></td>
            </tr>
            <tr>
                <td><b>Leave ID: </b></td>
                <td> <%=leaveID%></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td><b>Leaving From: </b></td>
                <td> <%=fromdate%></td>
            </tr>
            <tr>
                <td><b>Returning On: </b></td>
                <td> <%=todate%></td>
            </tr>
            <tr>
                <td><b>Leave Reason: </b></td>
                <td> <%=reason%></td>
            </tr>
        </table>
        <br>
        <hr style="border:1px solid #666; width:20%;" />
        <span style="display: inline-block">
        <form name="authinput" action="AuthSubmit.jsp"  method="get" >
            <label class="radio" >  
                <input type="radio" name="auth" id="Approved" value="Approved">Approve Leave
            </label> 
            <label class="radio" > 
                <input type="radio" name="auth" id="Denied" value="Denied"> Deny Leave
            </label> 
            <input type="hidden" value="<%=id%>" name="id"> 
            <input type="hidden" value="<%=leaveID%>" name="leaveID"> 
            <br>
            <button class="btn"  name="authsubmit" value="Submit"  onclick="return validateForm()">Submit</button>
            <button class="btn"  name="authsubmit" value="Cancel"  >Go back</button>
        </form>
        </span>
    </div>
        <div id="footer" style="position:absolute;bottom:10px;left:15px;">
            <a href="http://bits-goa.ac.in"><img src="Resources/img/foot.png" height="180px" width="180px" border="0" alt="BITS Goa" title="BITS Goa" /></a>
        </div>
    </body>

</html>