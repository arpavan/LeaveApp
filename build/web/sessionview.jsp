<%-- 
    Document   : sessionview
    Created on : Apr 10, 2012, 10:20:01 PM
    Author     : Pavan
--%>


<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.sun.org.apache.bcel.internal.generic.BREAKPOINT"%>
<%@page import="java.sql.*"%>
<%@page import="LeaveApp.mySqlConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel=stylesheet href="Resources/css/bootstrap.css" type="text/css">
        <link rel=stylesheet href="Resources/css/bootstrap.min.css" type="text/css">
        <link rel=stylesheet href="Resources/css/bootstrap-responsive.css" type="text/css">
        <link rel=stylesheet href="Resources/css/bootstrap-responsive.min.css" type="text/css">
       
        <script type="text/javascript" src="Resources/js/bootstrap.js" ></script>
        <script type="text/javascript" src="Resources/js/bootstrap.min.js" ></script>
        
        <style>
            body{
                padding-top: 60px;
                padding-left: 20px;
                background-color:#F2F2F2;
            }
        </style>
        <script type="text/javascript">
        function show_alert()
        {
            alert("I am an alert box!");
        }
        </script>
        
        <title>Online Leave Management System</title>
    </head>
    <body>
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">
                    <a class="brand" href="#">Online Leave Application</a>
                    <ul class="nav">
                        <li class="active">
                            <a href="#">About</a>
                        </li>
                        <li class="active">
                            <a href=".">Back</a>
                        </li>
                    
                    </ul>
                </div>
            </div>
        </div>    
        <center><h1>Error!</h1></center>
        <br />
        <br />

        <!--    statements below are used to obtain the user session information.
                These few lines of code
                have to be put on every jsp page of the project   -->

        <%
         try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String studentcount = null, wardencount = null, empcount = null;
            String user = null;     //user=student or warden or employee
            String authquery = null;
            ResultSet result = null;
            mySqlConnector conclass = new mySqlConnector();
            Connection conn = conclass.connector();
            Statement stmnt = conn.createStatement();

            /*
             * first query the users table if the userid and passwords match,
             * then redirect to the userpage. else query the wardens table, if
             * userid and passwords match, then redirect to the wardenpage.
             * else, the "else" block will be executed.
 *
             */

           
                
                authquery = "select count(*) from student where username='" + username + "' and password='" + password + "';";
                result = stmnt.executeQuery(authquery);
                while (result.next()) {
                        studentcount = result.getString(1);
                }
                authquery = "select count(*) from warden where username='" + username + "' and password='" + password + "';";
                result = stmnt.executeQuery(authquery);
                while (result.next()) {
                        wardencount = result.getString(1);
                }
                authquery = "select count(*) from staff where username='" + username + "' and password='" + password + "';";
                result = stmnt.executeQuery(authquery);
                while (result.next()) {
                        empcount = result.getString(1);
                }
                if (studentcount.equals("1") == true) {
                    session.setAttribute("user", username);
                    response.sendRedirect("studentleavepage.jsp");

                    }
                else if (wardencount.equals("1")==true){
                    session.setAttribute("user", username);
                    response.sendRedirect("PendingLeaves.jsp");

                                       }
                else if (empcount.equals("1")==true && username.equals("mess")){
                    session.setAttribute("user", username);
                    response.sendRedirect("Mess.jsp");

                                       }
                               else if (empcount.equals("1") && username.equals("gate")){
                                   session.setAttribute("user",username);
                                   response.sendRedirect("GateLeaves.jsp");
                               }
                else if (empcount.equals("1") && username.equals("swd")){
                                   session.setAttribute("user",username);
                                   response.sendRedirect("SWD.jsp");
                               }
                else if (username != null && password != null && studentcount.equals("1") == false && wardencount.equals("1") == false && empcount.equals("1") == false ) {
                        session.setAttribute("auth", "wrong");
                        response.sendRedirect(".");
                        out.println("<center><label><h1>Invalid Username or Password. Please try again.</h1></label></center>");
                        %><br /><br /><center><a href=".">Go Back</a></center><%
                    } else {
                        out.println("<center><label><h3>Sorry! You are not authorized to view this page.</h3></label></center>");
                        %><br /><br /><br /><center><a href=".">Go Back</a></center><%
                      }

                        
                    } catch (IllegalStateException e) {
                        session.setAttribute("auth", "error");
                        response.sendRedirect(".");
                        out.println("<center><label><h3>Error! Please Login again to continue.</h3></label></center>");
        %><br /><br /><br /><center><a href=".">Go Back</a></center><%
                    } catch (com.mysql.jdbc.exceptions.jdbc4.CommunicationsException ce) {
                        
                        response.sendRedirect("commerror.jsp");
                    }
        %>

    </body>
</html>
