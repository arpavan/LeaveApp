/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package LeaveApp;

/**
 *
 * @author Aniket
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class mySqlConnector {
    
    public Connection connector() throws ClassNotFoundException, IllegalAccessException, InstantiationException, SQLException
    {
        String connectionURL = "jdbc:mysql://localhost:3306/leaveapp";
        Connection connection = null;
        Class.forName("com.mysql.jdbc.Driver").newInstance(); 
        connection = DriverManager.getConnection(connectionURL, "root", "");
        return connection;
    }
    
}
