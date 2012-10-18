<%-- 
    Document   : index
    Created on : Mar 25, 2012, 3:37:27 PM
    Author     : Alok
--%>

<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
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

        #customswd:link {color: white}
        #customswd:visited {color:white}

    </style>
    <link href="Resources/css/bootstrap-responsive.css" rel="stylesheet">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Online Leave Application</title>
    </head>
    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <a class="brand" href="/">Online Leave Application</a>
                <div class="nav-collapse">
                    <ul class="nav pull-right">
                        <li  style="margin-top: 10px;margin-right: 20px;color: white">SWD</li>
                        <li  ><a href="logout.jsp">Logout</a></li>
                    </ul>    

                </div><!--/.nav-collapse -->

            </div>
        </div>
    </div>
 <%
 try{
        if(session.getAttribute("user")!=null)
                       {
        mySqlConnector conclass = new mySqlConnector();
        Connection conn = conclass.connector();
        Statement stmnt1 = conn.createStatement();
        Statement stmnt2 = conn.createStatement();
        Statement stmnt3 = conn.createStatement();

        ResultSet defaultLeaves = stmnt1.executeQuery("select * from student,leaveinfo where student.id=leaveinfo.id and status='Defaulter'");
        ResultSet allLeaves = stmnt2.executeQuery("select * from student, leaveinfo where student.id=leaveinfo.id ");

    %>
    
    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <a class="brand" href="/">Online Leave Application</a>
                <div class="nav-collapse">
                    <ul class="nav pull-right">
                        <li  style="margin-top: 10px;margin-right: 20px;color: white"><%=session.getAttribute("user")%></li>
                        <li  ><a href="logout.jsp">Logout</a></li>
                    </ul>    

                </div><!--/.nav-collapse -->

            </div>
        </div>
    </div>
    
    <body>
        <div align="center">

            <h1>SWD - Leave Details</h1><br>
            <div><b>These tables display <i>all</i> applied leaves. </b></div><br>


            <ul class="nav nav-tabs" data-tabs="tabs" style="width: 70%">
                <li class="active"><a href="#all" >All Leaves</a></li>
                <li><a href="#defaulter" >Defaulters</a></li>
            </ul>

            <div id="my-tab-content" class="tab-content">
                <div class="tab-pane active" id="all">
                    <h2>All Leaves</h2>
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
                                while (allLeaves.next()) {
                                    String id = allLeaves.getString("id");
                                    String status = allLeaves.getString("status");
                                    String leaveID = allLeaves.getString("leaveID");
                                    String clicker = null;
                                    String label = null;
                                    if (status.equals("Approved")) {
                                        label = "label label-success";
                                    } else if (status.equals("Denied")) {
                                        label = "label label-important";
                                    } else if (status.equals("Pending")) {
                                        label = "label label-warning";
                                    } else if (status.equals("OnLeave")) {
                                        label = "label";
                                    } else if (status.equals("Defaulter")) {
                                        label = "label label-info";
                                    } else if (status.equals("Expired")) {
                                        label = "label label-inverse";
                                    }
                            %>
                            <tr>
                                <td><%out.println(allLeaves.getString("id"));%></td>
                                <td><%out.println(allLeaves.getString("name"));%></td>
                                <td><%out.println(allLeaves.getString("leaveID"));%></td>
                                <td><%out.println(allLeaves.getString("startDate"));%></td>
                                <td><%out.println(allLeaves.getString("endDate"));%></td>
                                <td><span class="<%= label%>" > <%out.println(allLeaves.getString("status"));%></span></td>
                            </tr>
                            <%
                                }
                            %>

                        </tbody>
                    </table>
                    <a href="SWDClear.jsp?status=All"><button class="btn">Clear All Denied, Expired and Defaulters</button></a>
                </div>
                <div class="tab-pane" id="defaulter">
                    <h2>Leaving Today</h2>
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
                                while (defaultLeaves.next()) {
                                    String id = defaultLeaves.getString("id");
                                    String status = defaultLeaves.getString("status");
                                    String leaveID = defaultLeaves.getString("leaveID");

                            %>
                            <tr>
                                <td><%out.println(defaultLeaves.getString("id"));%></td>
                                <td><%out.println(defaultLeaves.getString("name"));%></td>
                                <td><%out.println(defaultLeaves.getString("leaveID"));%></td>
                                <td><%out.println(defaultLeaves.getString("startDate"));%></td>
                                <td><%out.println(defaultLeaves.getString("endDate"));%></td>
                                <td><span class="label label-info" ><%out.println(defaultLeaves.getString("status"));%></span></td>
                            </tr>
                            <%
                                }}
 else{
 response.sendRedirect("error.jsp");
 }}
 
                                catch (com.mysql.jdbc.exceptions.jdbc4.CommunicationsException me) {

                    response.sendRedirect("commerror.jsp");

                } 
                            %>

                        </tbody>
                    </table>
                    <a href="SWDClear.jsp?status=All"><button class="btn" onclick="SWDClear.jsp?status=Defaulter">Clear All Defaulters</button></a>
                </div>
            </div>
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

        <script type="text/javascript" src="Resources/js/jquery.min.js"></script>
        <script type="text/javascript" src="Resources/js/bootstrap-tabs.js"></script>
        <script type="text/javascript">
            jQuery(document).ready(function ($) {
                $(".tabs").tabs();
            });
        </script>
    </body>
</html>
