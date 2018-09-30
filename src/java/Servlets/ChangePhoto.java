package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
@WebServlet("/ChangePhoto")
public class ChangePhoto extends HttpServlet {

    
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
HttpSession session=request.getSession();
HashMap h=(HashMap)session.getAttribute("UserDetails");
if(h!=null){
        Part p=request.getPart("photo");
        java.io.InputStream is;
        if(p!=null){
            is = p.getInputStream();
        }else{
            is=null;
        }
        ServletContext application=getServletContext();
        db.DbConnect db=(db.DbConnect)application.getAttribute("DBCon");
        if(db==null){
            db=new db.DbConnect(); 
            application.setAttribute("DBCon", db);
        }
        String s=db.changePhoto((String)h.get("email"), is);
        if(s.equalsIgnoreCase("Error")){
            session.setAttribute("msg","Photo Updation Failed.");
        }else if(s.equalsIgnoreCase("Exception")){
            session.setAttribute("msg","Photo Updation Failed.(Exception Occured)");
        }
        else if (s.equalsIgnoreCase("Done")){
            session.setAttribute("msg","Photo Updated successfully.");
        }
        response.sendRedirect("editprofile.jsp");
}else{
    session.setAttribute("msg","Plz Login First!");
    response.sendRedirect("index.jsp");
}
    }catch(Exception e){
            e.printStackTrace();
        }
    }

}
