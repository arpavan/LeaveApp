<%--
    Document   : index
    Created on : Mar 25, 2012, 3:37:27 PM
    Author     : Alok
--%>

<%@page import="javax.swing.JOptionPane"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="LeaveApp.mySqlConnector" %><%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

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
        <title>Online Leave Application</title>
    </head>
    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <a class="brand" href="/">Online Leave Application</a>
                <div class="nav-collapse">
                    <ul class="nav">
                        <li ><a href="studentleavepage.jsp">Apply For Leave</a></li>
                        <li class="active"><a href="studentleavehistory.jsp">Check Status</a></li>
                    </ul>
                    <ul class="nav pull-right">
                        <li  style="margin-top: 10px;margin-right: 20px;color: white"><%=session.getAttribute("name")%></li>
                        <li  ><a href="logout.jsp">Logout</a></li>
                    </ul>    

                </div><!--/.nav-collapse -->

            </div>
        </div>
    </div>
    <body>
        <center>
            <br /><br /><h1>Pending Leaves</h1><br><br>
            <br />

            <table class="table table-striped" style="width: 50%;">
                <thead >
                    <tr onclick="">
                        <th>Leave ID</th>
                        <th>Leave Date</th>
                        <th>Return Date</th>
                        <th>Consent</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody style="border:2px groove">


                    <%try
                    {
                        //String username = "2009C6PS386G";
                        mySqlConnector conclass = new mySqlConnector();
                        Connection conn = conclass.connector();
                        Statement stmnt = conn.createStatement();
                       // int leaveid = 0;
                        String startDate = null, endDate = null, status = null, reason = null, consent = null;
                        // JOptionPane.showMessageDialog(null, session.getAttribute("id").toString(), "test",JOptionPane.INFORMATION_MESSAGE);
                        ResultSet result = stmnt.executeQuery("select * from leaveinfo where id=(select id from student where username='" + session.getAttribute("user") + "')");
                        //out.println(session.getAttribute("user"));
                        while (result.next()) {
                         status = result.getString("status");
                        String id = result.getString("id");
                         String leaveID = result.getString("leaveID");

                        String label = null;
                        String clicker = null;
                        if (status.equals("Approved")) {
                            label = "label label-success";
                          //  clicker = "";
                        } else if (status.equals("Denied")) {
                            label = "label label-important";
                         //   clicker = "";
                        } else if (status.equals("Pending")) {
                            label = "label label-warning";
                           // clicker = "location.href='leavedetails.jsp?id=" + id + "&leaveID="+leaveID+"'";
                        } else if (status.equals("OnLeave")) {
                            label = "label";
                          //  clicker = "";
                        } else if (status.equals("Defaulter")) {
                            label = "label label-info";
                            clicker = "";
                        } else if (status.equals("Expired")){
                            label= "label label-inverse";
                           // clicker= "";
                        }
            %>
            <tr >
                        <td><%=result.getInt("leaveID")%></td>
                        <td><%=result.getString("startDate")%></td>
                        <td><%=result.getString("endDate")%></td>
                        <td><%=result.getString("consent")%></td>
                        <td><span class="<%=label%>"><%=result.getString("status")%></span></td>
                    </tr>        <%  }
                                               }
                    catch (com.mysql.jdbc.exceptions.jdbc4.CommunicationsException me) {

                    response.sendRedirect("commerror.jsp");

                } 
                    %>





                </tbody>
            </table>

            <button class="btn" onclick="location.href='studentleavepage.jsp'">Go Back</button>
        </center>

    </body>

</html>
