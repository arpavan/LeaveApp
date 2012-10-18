/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package TestPackage;

import com.meterware.httpunit.*;
import junit.framework.*;
/**
 *
 * @author Alok
 */
public class HelperClass {
    public WebResponse loginForm(String username,String password) throws Exception{
        WebConversation conversation = new WebConversation();
        HttpUnitOptions.setScriptingEnabled(false);
        HttpUnitOptions.setExceptionsThrownOnScriptError(false);
        WebRequest request = new GetMethodWebRequest("http://localhost:8084/LeaveApp/index.jsp");
        WebResponse response = conversation.getResponse(request);
        WebForm loginform = response.getForms()[0];
        loginform.setParameter("username", username);
        loginform.setParameter("password", password);
        request = loginform.getRequest("submitbutton");
        response = conversation.getResponse(request);
        
        return response;
    }
}
