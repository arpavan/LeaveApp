<%-- 
    Document   : leaveapplicationpage
    Created on : Apr 12, 2012, 10:17:13 PM
    Author     : Aniket
--%>

<%@page import="java.util.StringTokenizer"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="LeaveApp.mySqlConnector" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
            function call_alert()
            {
                alert ( "Something went wrong! We are working on it and hope to get back online soon." );
            }
            function call_success()
            {
                alert ( "Leave Application Successfull." );
            }
        </script>
        <title>update database</title>
    </head>
    <body>
        <%
        try
                       {
            
        
        String id = null;
        
        //String username = session.getAttribute("user");
        
        mySqlConnector conclass=new mySqlConnector();
        Connection conn=conclass.connector();
        Statement stmnt = conn.createStatement();
        
        
        ResultSet result = stmnt.executeQuery("select * from student where username='"+session.getAttribute("user")+"'");
        
           while(result.next())
		  {
			  
			  id = result.getString("id");
                    }
        
        
        String fromDate = request.getParameter("txtFromDate");
        StringTokenizer tk = new StringTokenizer(fromDate,"/");
        String ndate = tk.nextToken();
        String nmonth = tk.nextToken();
        String nyear = tk.nextToken();
        String finalDate = nyear + "-" + nmonth + "-" + ndate;
        
        
        
        String endDate = request.getParameter("txtToDate");
        StringTokenizer tk1 = new StringTokenizer(endDate,"/");
        String n1date = tk1.nextToken();
        String n1month = tk1.nextToken();
        String n1year = tk1.nextToken();
        String finalDate1 = n1year + "-" + n1month + "-" + n1date;
       
        
        
        String reason = request.getParameter("txtReason");
        
       
        String consent = request.getParameter("leaveConsent");
     
        String status = "Pending";
        
        mySqlConnector conclass1=new mySqlConnector();
        Connection conn1=conclass1.connector();
        Statement stmnt1 = conn1.createStatement();
        Statement stmnt2 = conn1.createStatement();
        Boolean result1 = stmnt1.execute("insert into leaveinfo(id,startDate,endDate,status,reason,consent) values('" +id+"','"+ finalDate +"','"+ finalDate1 +"','"+status+ "','" +reason+"','"+consent+"')"); 
        ResultSet leavesubmit = stmnt2.executeQuery("SELECT leaveID FROM student, leaveinfo ORDER BY leaveID DESC LIMIT 1");
        
        //JOptionPane.showMessageDialog(null, "Leave Application Successfull","Success",JOptionPane.INFORMATION_MESSAGE);
        leavesubmit.next();
        String leaveID = leavesubmit.getString("leaveID");
        session.setAttribute("leaveID", leaveID);
        response.sendRedirect("submitsuccess.jsp");
               }
        catch(NullPointerException e)
                               {
            //JOptionPane.showMessageDialog(null, "Error has occured,try again","Success",JOptionPane.INFORMATION_MESSAGE);
        response.sendRedirect("commerror.jsp");
        
        }
        %>
    </body>
</html>
