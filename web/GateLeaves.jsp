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
        #custom:link {color: white}
        #custom:visited {color:white}
    </style>
    <link href="Resources/css/bootstrap-responsive.css" rel="stylesheet">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Main Gate - Online Leave Application</title>
    </head>
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
                        <li class="active"><a href="">Home</a></li>
                        </ul>
                    <ul class="nav pull-right">
                        <li  style="margin-top: 10px;margin-right: 20px;color: white">Security</li>
                        <li  ><a href="logout.jsp">Logout</a></li>
                    </ul>
                </div><!--/.nav-collapse -->

            </div>
        </div>
    </div>
    <%try{
        if(session.getAttribute("user")!=null)
                       {
            //out.println(session.getAttribute("user"));
        mySqlConnector conclass = new mySqlConnector();
        Connection conn = conclass.connector();
        Statement stmnt1 = conn.createStatement();
        Statement stmnt2 = conn.createStatement();
        Statement stmnt3 = conn.createStatement();

        ResultSet allLeaves = stmnt1.executeQuery("select * from student,leaveinfo where student.id=leaveinfo.id and status='OnLeave'");
        ResultSet leavingToday = stmnt2.executeQuery("select * from student, leaveinfo where student.id=leaveinfo.id and (status='Approved' and startDate=curDate())");
        ResultSet returningToday = stmnt3.executeQuery("select * from student, leaveinfo where student.id=leaveinfo.id and (status='OnLeave' and endDate=curdate());");


    %>
    <body>
        <div align="center">

            <h1>Main Gate Leave Verification</h1><br>
            <div><b>This table displays details of students with Approved Leaves or OnLeave. Once a student leaves, change their status to 'OnLeave' or 'Expired' by clicking on the status on the table entry. </b></div><br><br>


            <ul class="nav nav-tabs" data-tabs="tabs" style="width: 70%">
                <li class="active"><a href="#all">All Leaves</a></li>
                <li><a href="#leave">Leaving Today</a></li>
                <li><a href="#arrive">Arriving Today</a></li>

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
                                    String clicker = null;
                                    String label = null;
                                    String leaveID=allLeaves.getString("leaveID");
                                    if (status.equals("Approved")) {
                                        clicker = "GateChangeLeave.jsp?id=" + id + "&status=" + status +"&leaveID=" +leaveID;
                                        label = "label label-success";
                                    } else if (status.equals("OnLeave")) {
                                        clicker = "GateChangeLeave.jsp?id=" + id + "&status=" + status +"&leaveID=" +leaveID;
                                        label = "label";
                                    }
                            %>
                            <tr>
                                <td><%out.println(allLeaves.getString("id"));%></td>
                                <td><%out.println(allLeaves.getString("name"));%></td>
                                <td><%out.println(allLeaves.getString("leaveID"));%></td>
                                <td><%out.println(allLeaves.getString("startDate"));%></td>
                                <td><%out.println(allLeaves.getString("endDate"));%></td>
                                <td><span class="<%= label%>" ><a id="custom" href=<%=clicker%> ><%out.println(allLeaves.getString("status"));%></a></span></td>
                            </tr>
                            <%
                                }
                            %>

                        </tbody>
                    </table>
                </div>
                <div class="tab-pane" id="leave">
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
                                while (leavingToday.next()) {
                                    String id = leavingToday.getString("id");
                                    String status = leavingToday.getString("status");
                                    String clicker = null;
                                    String label = null;
                                    String leaveID=leavingToday.getString("leaveID");;
                                    if (status.equals("Approved")) {
                                        clicker = "GateChangeLeave.jsp?id=" + id + "&status=" + status +"&leaveID=" +leaveID;
                                        label = "label label-success";
                                    } else if (status.equals("OnLeave")) {
                                        clicker = "GateChangeLeave.jsp?id=" + id + "&status=" + status +"&leaveID=" +leaveID;
                                        label = "label";
                                    }
                            %>
                            <tr>
                                <td><%out.println(leavingToday.getString("id"));%></td>
                                <td><%out.println(leavingToday.getString("name"));%></td>
                                <td><%out.println(leavingToday.getString("leaveID"));%></td>
                                <td><%out.println(leavingToday.getString("startDate"));%></td>
                                <td><%out.println(leavingToday.getString("endDate"));%></td>
                                <td><span class="<%= label%>" ><a id="custom" href=<%=clicker%> ><%out.println(leavingToday.getString("status"));%></a></span></td>
                            </tr>
                            <%
                                }
                            %>

                        </tbody>
                    </table>
                </div>
                <div class="tab-pane" id="arrive">
                    <h2>Arriving Today</h2>
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
                                while (returningToday.next()) {
                                    String id = returningToday.getString("id");
                                    String status = returningToday.getString("status");
                                    String clicker = null;
                                    String label = null;
                                    String leaveID= returningToday.getString("leaveID");;
                                    if (status.equals("Approved")) {
                                        clicker = "GateChangeLeave.jsp?id=" + id + "&status=" + status +"&leaveID=" +leaveID;
                                        label = "label label-success";
                                    } else if (status.equals("OnLeave")) {
                                        clicker = "GateChangeLeave.jsp?id=" + id + "&status=" + status +"&leaveID=" +leaveID;
                                        label = "label";
                                    }
                            %>
                            <tr>
                                <td><%out.println(returningToday.getString("id"));%></td>
                                <td><%out.println(returningToday.getString("name"));%></td>
                                <td><%out.println(returningToday.getString("leaveID"));%></td>
                                <td><%out.println(returningToday.getString("startDate"));%></td>
                                <td><%out.println(returningToday.getString("endDate"));%></td>
                                <td><span class="<%= label%>" ><a id="custom" href=<%=clicker%> ><%out.println(returningToday.getString("status"));%></a></span></td>
                            </tr>
                            <%
                                                       }
                                }
                                else
                                {
                                    response.sendRedirect("logout.jsp");
                                }
    }
    catch (com.mysql.jdbc.exceptions.jdbc4.CommunicationsException me) {

                    response.sendRedirect("commerror.jsp");

                } 
                            %>

                        </tbody>
                    </table>
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
