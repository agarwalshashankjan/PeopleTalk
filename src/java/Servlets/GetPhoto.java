
package servlets;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.HashMap;
import javax.servlet.*;
import javax.servlet.http.*;

public class GetPhoto extends HttpServlet {

    
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session=request.getSession();
        HashMap h=(HashMap)session.getAttribute("UserDetails");
        if(h!=null){
            try {
                ServletContext application=getServletContext();
                db.DbConnect db=(db.DbConnect)application.getAttribute("DbConnect");
                if(db==null){
                    db=new db.DbConnect(); 
                    application.setAttribute("DbConnect", db);
                }
                String e=request.getParameter("email");
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
            response.sendRedirect("home.jsp");
        }
    }
}