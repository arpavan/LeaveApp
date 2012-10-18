package TestPackage;

import com.meterware.httpunit.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import junit.framework.*;
/*
 * To change this template, choose Tools | Templates and open the template in
 * the editor.
 */

/**
 *
 * @author Alok
 */
public class TestIndex extends TestCase {

    HelperClass hc = new HelperClass();

    public void testMess() throws Exception {

        WebResponse response = hc.loginForm("mess", "mess");
        assertEquals("Page Title", "Mess - Online Leave Application", response.getTitle());
        WebTable table = response.getTables()[0];
        int rowcount = table.getRowCount();

        for (int i = 1; i < rowcount; i++) {
            TableCell statusCell = table.getTableCell(i, 5);

            assertEquals("status", "Approved", statusCell.getText());

            TableCell startdateCell = table.getTableCell(i, 3);
            Calendar cal = Calendar.getInstance();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String date = formatter.format(cal.getTime());

            assertEquals("date", date, startdateCell.getText());
        }

    }

    public void testGate() throws Exception {
        WebResponse response = hc.loginForm("gate", "gate");
        assertEquals("Page Title", "Main Gate - Online Leave Application", response.getTitle());

        WebTable allTable, leavetodayTable, arrivetodayTable;
        allTable = response.getTables()[0];
        leavetodayTable = response.getTables()[1];
        arrivetodayTable = response.getTables()[2];

        int allRows, leavetodayRows, arrivetodayRows;
        allRows = allTable.getRowCount();
        leavetodayRows = leavetodayTable.getRowCount();
        arrivetodayRows = arrivetodayTable.getRowCount();

        for (int i = 1; i < leavetodayRows; i++) {  // For the leaving Today table
            TableCell statusCell = leavetodayTable.getTableCell(i, 5);

            assertEquals("status", "Approved", statusCell.getText());

            TableCell startDateCell = leavetodayTable.getTableCell(i, 3);
            Calendar cal = Calendar.getInstance();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String date = formatter.format(cal.getTime());

            assertEquals("date", date, startDateCell.getText());
        }

        for (int i = 1; i < arrivetodayRows; i++) { //For the arriving today table
            TableCell statusCell = arrivetodayTable.getTableCell(i, 5);

            assertEquals("status", "OnLeave", statusCell.getText());

            TableCell returnDateCell = arrivetodayTable.getTableCell(i, 4);
            Calendar cal = Calendar.getInstance();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String date = formatter.format(cal.getTime());

            assertEquals("date", date, returnDateCell.getText());
        }

        for (int i = 1; i < allRows; i++) { //For the all leaves table
            TableCell statusCell = allTable.getTableCell(i, 5);

            assertEquals("status", "OnLeave", statusCell.getText());

            TableCell returnDateCell = allTable.getTableCell(i, 4);
            TableCell startDateCell = allTable.getTableCell(i, 3);
            Calendar cal = Calendar.getInstance();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String date = formatter.format(cal.getTime());
            assertEquals("date", 1, returnDateCell.getText().compareTo(date) | 1);
            assertEquals("date", -1, startDateCell.getText().compareTo(date) | -1);


        }
    }

    public void testSWD() throws Exception {
        WebResponse response = hc.loginForm("swd", "swd");
        assertEquals("Page Title", "SWD - Online Leave Application", response.getTitle());
        WebTable defaultertable = response.getTables()[1];
        int defaulterrow = defaultertable.getRowCount();

        for (int i = 1; i < defaulterrow; i++) {
            TableCell statusCell = defaultertable.getTableCell(i, 5);

            assertEquals("status", "Defaulter", statusCell.getText());
        }
    }

    public void testErrorLogin() throws Exception {
        WebResponse response = hc.loginForm("wrong", "wrong");
        assertEquals("Page Title", "Online Leave Management System", response.getTitle());
        
    }
}
