<%-- 
    Document   : studentleavepage
    Created on : Mar 25, 2012, 2:28:14 PM
    Author     : Pavan
--%>

<%@page import="javax.swing.JOptionPane"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.util.Date" %> 
<%@ page import="javax.servlet.*,java.text.*" %>
<%@ page import="LeaveApp.mySqlConnector" %>
<!DOCTYPE html>
<!get the user id from login page here for further query processing >
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Online Leave Application</title>
        <script language="javascript" type="text/javascript" src="Resources/datetimepicker.js">

            //Date Time Picker script- by TengYong Ng of http://www.rainforestnet.com
            //Script featured on JavaScript Kit (http://www.javascriptkit.com)
            //For this script, visit http://www.javascriptkit.com 

        </script>
        <script type="text/javascript">
            function call_alert()
            {
                alert ( "Something went wrong! We are working on it and hope to get back online soon." );
            }
            function validateForm()
            {
          
                var todate = document.getElementById("to").value;
                var fromdate = document.getElementById("from").value;
                
                var todatetoken = todate.split("/");
                var fromdatetoken = fromdate.split("/");
                
                
                var todateday = todatetoken[0];
                var todatemonth = todatetoken[1];
                var todateyear = todatetoken[2];
                
                var fromdateday = fromdatetoken[0];
                var fromdatemonth = fromdatetoken[1];
                var fromdateyear = fromdatetoken[2];
                var today = new Date();
                
                
                if (document.getElementById("to").value==null || document.getElementById("to").value=="")
                {
                    alert("Please enter end date");
                    return false;
                }
                else if(document.getElementById("from").value == null || document.getElementById("from").value == "")
                {
                    alert("Please enter start date");
                    return false;
                }
                else if(document.getElementById("reason").value==null || document.getElementById("reason").value=="")
                {
                    alert("Please enter reason");
                    return false;
                }
                else if(document.getElementById("consent").value==null || document.getElementById("consent").value=="")
                {
                    alert("Please enter consent");
                    return false;
                }

                else if(fromdateyear==todateyear && fromdateday == todateday && fromdatemonth == todatemonth)
                    {
                        alert("From date and To date cannot be the same!");
                        return false;
                    }

                else if(fromdateyear>todateyear )
                {
                    alert("To date must be greater than From date.");
                    return false;
                }
                else if(fromdatemonth>todatemonth)
                {
                    alert("To date must be greater than From date."); 
                    return false;
                }
                else if(fromdateday>todateday){
                    alert("To date must be greater than From date.");
                    return false;
                }
                else if(todateyear<today.getFullYear())
                {
                    alert("Date entered must be greater than Current date.");
                    return false;  
                }
                else if(todatemonth<(today.getMonth()+1))
                {
                    alert("Date entered must be greater than Current date.");
                    return false;
                }
                else if(todateday<today.getDate())
                {
                    alert("Date entered must be greater than Current date.");
                    return false;
                }
                else if(fromdateyear<today.getFullYear())
                {
                    alert("Date entered must be greater than Current date.");
                    return false;
                }
                else if(fromdatemonth<(today.getMonth()+1))
                {
                    alert("Date entered must be greater than Current date.");
                    return false;
                }
                else if(fromdateday<today.getDate())
                {
                    alert("Date entered must be greater than Current date.");
                    return false;
                }
                                                
                                            
                //                            else if(document.getElementById("to").value<document.getElementById("from").value)
                //                                {
                //                                    alert("To date must be greater than From date.");
                //                                    return false;
                //                                }
                //                                else
                //                                    {
                //                                        var today = new Date();
                //                                        var dd = today.getDate();
                //                                        var mm = today.getMonth()+1; //January is 0!
                //                                        var yyyy = today.getFullYear();
                //                                        if(dd<10){dd='0'+dd} if(mm<10){mm='0'+mm} 
                //                                        var today1 = dd+'-'+mm+'-'+yyyy;
                //                                        
                //                                        if(document.getElementById("to").value<today1 || document.getElementById("from").value<today1)
                //                                            {
                //                                                alert("Date entered must be greater than Current date.");
                //                                                return false;
                //                                            }
                //                                            else
                //                                                {
                //                                                    return true;
                //                                                }
                                            

                                        

                                        
                //                                    }
            }
            
        
        </script>

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
        <%
            String name = null, id = null, hostel = null, room = null, contactno = null;
            String warden[] = new String[2];
            try {
                mySqlConnector conclass = new mySqlConnector();
                Connection conn = conclass.connector();
                Statement stmnt = conn.createStatement();
                //String username="f2009386";
                ResultSet result = stmnt.executeQuery("select * from student where username='" + session.getAttribute("user") + "'");
                int i = 0;
                if (session.getAttribute("user") != null) {
                    while (result.next()) {
                        name = result.getString("name");
                        id = result.getString("id");
                        //session.setAttribute("id", id);
                        hostel = result.getString("hostel");
                        //out.println("hostel is " + hostel);
                        room = result.getString("room");
                        contactno = result.getString("contactno");
                        Statement stmnt1 = conn.createStatement();
                        ResultSet result1 = stmnt1.executeQuery("select name from employee where id=some(select id from warden where hostel='" + hostel + "')");
                        while (result1.next()) {
                            warden[i] = result1.getString("name");
                            i++;
                            //warden = result1.getString("name");
                        }
                    }
                    session.setAttribute("name", name);
                } else {
                    out.println("Sorry! You are not authorized to view this page!");
                    response.sendRedirect("error.jsp");
        %><br /><br /><br /><a href=".">Go Back</a><%
                    }

                } catch (com.mysql.jdbc.exceptions.jdbc4.CommunicationsException me) {

                    response.sendRedirect("commerror.jsp");

                } catch (IllegalStateException e) {
                    session.setAttribute("auth", "error");
                    response.sendRedirect(".");
                    out.println("Error! Please Login again to continue.");
    %><br /><br /><br /><a href=".">Go Back</a><%
                }
    %>
    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <a class="brand" href="/">Online Leave Application</a>
                <div class="nav-collapse">
                    <ul class="nav">
                        <li class="active"><a href="">Apply For Leave</a></li>
                        <li ><a href="studentleavehistory.jsp">Check Status</a></li>
                    </ul>
                    <ul class="nav pull-right">
                        <li  style="margin-top: 10px;margin-right: 20px;color: white"><%=name%></li>
                        <li  ><a href="logout.jsp">Logout</a></li>
                    </ul>    

                </div><!--/.nav-collapse -->

            </div>
        </div>
    </div>

</head>

<body>
<center>
    <div class="row">  
        <div class="span3">  
            <table align="center">
                <tbody>
                <thead>
                    <tr>
                        <th style="padding-bottom:20px"><b>Student Profile</b></th>
                        <th></th>
                    </tr>
                </thead>

                <tr>
                    <td>ID:</td>
                    <td><% out.println(id);%></td>
                </tr>
                <tr>
                    <td>Name:</td>
                    <td><%out.println(name);%></td>
                </tr>
                <tr>
                    <td>Hostel-Room:</td>
                    <td><%out.println(hostel + " " + room);%></td>
                </tr>
                <tr>
                    <td>Contact No:</td>
                    <td><%out.println(contactno);%></td>
                </tr>
                <tr>
                    <td>Wardens Incharge:</td>
                    <td><%out.println(" " + warden[0] + "/" + warden[1]);%></td>
                </tr>
                </tbody>
            </table>
            <br /><br />
        </div>
        <div class="span24" >       


            <h1 style="padding-top:100px;padding-left:80px">Leave Application Form</h1>
            <br />
            <br />
            <! This form below takes the data and submits it into the database.>
            <! Check the "action" tag below>

            <form name="Leave Application Form" action="leaveapplicationpage.jsp" style="padding-left:80px">
                <table>
                    <tbody>
                        <tr>
                            <td>From:</td>
                            <td><input type="text" name="txtFromDate" value="" id="from"/>
                                <a href="javascript:NewCal('from','ddmmyyyy')">
                                    <img src="Resources/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                                <span class="descriptions"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>To:</td>
                            <td><input type="text" name="txtToDate" value="" id="to"/>
                                <a href="javascript:NewCal('to','ddmmyyyy')">
                                    <img src="Resources/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
                                <span class="descriptions"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>Reason:</td>
                            <td><input type="text" name="txtReason" value="" id="reason"/>
                            </td>
                        </tr>
                        <tr>
                            <td>Consent:</td>
                            <td><select name="leaveConsent" id="consent">
                                    <option>e-mail</option>
                                    <option>Letter</option>
                                    <option>Fax</option>
                                    <option>Self-Undertaking</option>
                                </select>
                            </td>
                        </tr>
                        <tr><td></td><td><input type="submit" value="Submit" name="btnSubmit" style="margin-left:30% " onclick="return validateForm()"  /></td></tr>
                    </tbody>
                </table>



            </form>
        </div></div>

</center>
</body>
</html>
