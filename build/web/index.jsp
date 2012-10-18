<%-- 
    Document   : index
    Created on : Apr 10, 2012, 10:00:35 PM
    Author     : Pavan
--%>

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

        <script type="text/javascript">
            function call_alert()
            {
                alert ( "Something went wrong! We are working on it and hope to get back online soon." );
            }
            function validateForm()
            {
                var u=document.forms["loginform"]["username"].value;
                var p=document.forms["loginform"]["password"].value;
                
                if (u==null || u=="")
                {
                    alert("Enter a username!");
                    return false;
                }
                else if (p==null || p=="")
                {
                    alert("Password field cannot be blank!");
                    return false;
                }
                else if (u==null || u=="" || p==null || p=="")
                {
                    alert("Please enter your username and password to continue!");
                    return false;
                }
            }
        </script>
        <style>
            body{
                padding-top: 60px;
                padding-left: 20px;
                background-color:#F2F2F2;
            }
        </style>

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
                    </ul>
                </div>
            </div>
        </div>
    <center>
        <h1>Login</h1>
        <br />
        <h5>Please enter your User ID and Password in the fields below:</h5><br />
        <span style="display:inline-block">
            <form class="form-horizontal well" name="loginform" id="login" action="sessionview.jsp" onsubmit="return validateForm()" method="POST">
                <fieldset>
                    <div class="control-group">
                        <label class="control-label" for="userid">User ID</label>
                        <div class="controls">
                            <input type="text" class="input-xlarge" id="userid" name="username" value="" /><br />
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="pwd">Password</label>
                        <div class="controls">
                            <input type="password" class="input-xlarge" id="pwd" name="password" value="" /><br />
                        </div>
                    </div>
                    <%  //out.println(session.getAttribute("auth")+"<br />");
                        String errormsg = "";
                        try {
                            if (session.getAttribute("auth").equals("wrong") == true) {

                                errormsg = "Invalid username and password!";
                                session.invalidate();

                            } else if (session.getAttribute("auth").equals("error") == true) {
                                errormsg = "Error Logging in. Please try again.";
                                session.invalidate();
                            } else {
                                errormsg = "";
                            }
                        } catch  (NullPointerException ne){
                            errormsg="";
                        }
                    %>
                    <div class="control-group error">  
                        <center><label > <%= errormsg%> </label></center>
                    </div>
                    <center><button name="submitbutton" type="submit" class="btn" >Submit</button></center>
                </fieldset>
            </form>
        </span>
    </center>
</body>
</html>