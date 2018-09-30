
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.HashMap;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@MultipartConfig
public class GetPhoto extends HttpServlet {

    
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session=request.getSession();
        HashMap h=(HashMap)session.getAttribute("UserDetails");
        if(h!=null){
            try {
                ServletContext application=getServletContext();
                db.DbConnect db=(db.DbConnect)application.getAttribute("DBCon");
                if(db==null){
                    db=new db.DbConnect(); 
                    application.setAttribute("DBCon", db);
                }
                String e=request.getParameter("email");
                //System.out.println(e);
                ResultSet rs=db.checkUser(e);
                if(rs!=null){
                    response.getOutputStream().write(rs.getBytes(10));
                }else{
                    response.getOutputStream().write(null);
                }
                response.getOutputStream().flush();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }else{
            session.setAttribute("msg","Plz Login First!");
            response.sendRedirect("index.jsp");
        }
    }

}
