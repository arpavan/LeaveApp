<%-- 
    Document   : index
    Created on : Mar 25, 2012, 3:37:27 PM
    Author     : Alok
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
        <title>Wardens - Online Leave Application</title>
    </head>

    <%try{
        //out.println(session.getAttribute("user").toString());
        mySqlConnector conclass = new mySqlConnector();
        Connection conn = conclass.connector();
        Statement stmnt1 = conn.createStatement();
        Statement stmnt2 = conn.createStatement();
        String username = session.getAttribute("user").toString();    //Pavan needs to put the username from the session into this variable.
        String wardenhostel = null;
        String wardenname = null;
        String wardentype = null;
        //ResultSet nameresult = stmnt1.executeQuery("select name from warden,employee where warden.id=employee.id and username ='"+username+"'");
        //nameresult.next();
        ResultSet result = stmnt2.executeQuery("select * from student,leaveinfo where student.id=leaveinfo.id and hostel=some(select hostel from warden where username='" + username + "')");
        ResultSet result2 = stmnt1.executeQuery("select * from warden,employee where warden.id=employee.id and "
                + "hostel=some(select hostel from warden where username='" + username + "')");
        //This quey will return details of the wardens of the same hostel as the username
        result2.next();
        
        wardenhostel = result2.getString("hostel");
        wardenname = result2.getString("name");
        session.setAttribute("wardenname", wardenname);
    %>
    
        <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <a class="brand" href=""></a>
                <a class="brand" href="">Online Leave Application</a>
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
        <div align="center">
        <h1>Hostel <%=wardenhostel%></h1>
        <h1>Leave Details</h1><br>
        <div><b>Click on the table entries for more details of a specific Pending leave. </b></div><br><br>
        <table class="table table-striped" style="width: 50%;" >
            <thead >
                <tr>
                    <th>Student-ID</th>
                    <th>Name</th>
                    <th>Leave ID</th>
                    <th>Leave Date</th>
                    <th>Return Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody style="border: 2px groove">
                <%
                    while (result.next()) {
                        String status = result.getString("status");
                        String id = result.getString("id");
                        String leaveid = result.getString("leaveID");

                        String label = null;
                        String clicker = null;
                        if (status.equals("Approved")) {
                            label = "label label-success";
                            clicker = "";
                        } else if (status.equals("Denied")) {
                            label = "label label-important";
                            clicker = "";
                        } else if (status.equals("Pending")) {
                            label = "label label-warning";
                            clicker = "location.href='leavedetails.jsp?id=" + id + "&leaveID="+leaveid+"'";
                        } else if (status.equals("OnLeave")) {
                            label = "label";
                            clicker = "";
                        } else if (status.equals("Defaulter")) {
                            label = "label label-info";
                            clicker = "";
                        } else if (status.equals("Expired")){
                            label= "label label-inverse";
                            clicker= "";
                        }
                %>
                <tr onclick="<%=clicker%>">
                    <td><%out.println(result.getString("id"));%></td>
                    <td><%out.println(result.getString("name"));%></td>
                    <td><%out.println(result.getString("leaveID"));%></td>
                    <td><%out.println(result.getString("startDate"));%></td>
                    <td><%out.println(result.getString("endDate"));%></td>
                    <td><span class="<%= label%>"><%out.println(result.getString("status"));%></span></td>
                </tr>
                <%
                    }}
    catch (com.mysql.jdbc.exceptions.jdbc4.CommunicationsException me) {

                    response.sendRedirect("commerror.jsp");

                } 
                %>

            </tbody>
        </table>
    </div>
        <!--        <div style="float: left">
                    <label><b>View Only- </b></label>
                    <label class="checkbox">  
                        <input type="checkbox" checked="true"> Approved<br>
                    </label> 
                    <label class="checkbox"> 
                        <input type="checkbox" checked="true"> Denied<br>
                    </label> 
                    <label class="checkbox"> 
                        <input type="checkbox" checked="true"> Pending<br>
                    </label>
                    <label class="checkbox"> 
                        <input type="checkbox" checked="true"> On Leave<br>
                    </label>
                    <label class="checkbox"> 
                        <input type="checkbox" checked="true"> Defaulter<br>
                    </label><br>
                </div>
                <br><br><br>
                <div style="font-size: 120px; float: left;padding-top: 5px">}</div>
                <button class="btn" value="Go" style="margin-top: 8px">Go</button>-->

        <div id="footer" style="position:absolute;bottom:10px;left:15px;">
            <a href="http://bits-goa.ac.in"><img src="Resources/img/foot.png" height="180px" width="180px" border="0" alt="BITS Goa" title="BITS Goa" /></a>
        </div>

    </body>
</html>
