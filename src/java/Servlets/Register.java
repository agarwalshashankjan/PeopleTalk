package Servlets;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletContext;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/Register")
@MultipartConfig
public class Register extends HttpServlet {
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=null;
		HttpSession session=null;
		try {
                    session=request.getSession();
                    out=response.getWriter();
                    String name=request.getParameter("name");
                    String phone=request.getParameter("phone");
                    String email=request.getParameter("email");
                    String gender=request.getParameter("gender");
                    String state=request.getParameter("state");
                    String city=request.getParameter("city");
                    String area=request.getParameter("area");
                    String d=request.getParameter("dob");
                    
                    System.out.println(name);
                    System.out.println(phone);
                    System.out.println(email);
                    System.out.println(gender);
                    System.out.println(state);
                    System.out.println(city);
                    System.out.println(area);
                    System.out.println(d);

                    java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("dd/MM/yyyy");
                    java.util.Date dt=sdf.parse(d);
                    java.sql.Date dob=new java.sql.Date(dt.getTime());

                    String pass=request.getParameter("password");
                    Part p=request.getPart("photo");
                    java.io.InputStream is;
                    
                    if(p!=null){
                        is=p.getInputStream();
                    }else{
                        is=null;
                    }
                    ServletContext application=getServletContext();
                    db.DbConnect db=(db.DbConnect)application.getAttribute("DbConnect");
                    if(db==null){
                        db=new db.DbConnect();
                        application.setAttribute("DbConnect",db);
                    } else {
                    }
                    String s=db.insertUser(email, pass, name, phone, gender, dob, state, city, area, is);
                    if(s.equalsIgnoreCase("Done")){
                        HashMap h=new HashMap();
                        h.put("name",name);
                        h.put("email",email);
                        h.put("phone",phone);
                        h.put("dob",d);
                        h.put("gender",gender);
                        h.put("state",state);
                        h.put("city",city);
                        h.put("area",area);
                        session.setAttribute("UserDetails",h);
                        response.sendRedirect("profile.jsp");
                    }
                    else if(s.equalsIgnoreCase("Error")){
                        session.setAttribute("msg","Registration Failed.");
                    }else if(s.equalsIgnoreCase("Already")){
                        session.setAttribute("msg","EmailID Already Registered.");
                    }else if(s.equalsIgnoreCase("Exception")){
                        session.setAttribute("msg","Registration Failed.(Exception Occured)");
                    }
                    response.sendRedirect("index.jsp");
                }catch(Exception ex){
                    ex.printStackTrace();
		}
	}

}
