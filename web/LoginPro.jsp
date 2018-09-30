<%@page import="java.util.HashMap"%>
<%@page import="java.sql.ResultSet"%>
<%
    String email=(String)request.getParameter("email");
    String pass=(String)request.getParameter("password");
    
    db.DbConnect db=(db.DbConnect)application.getAttribute("DbConnect");
    if(db==null){
        db=new db.DbConnect();
        application.setAttribute("DbConnect",db);
    }
    ResultSet rs=db.getUser(email, pass);
    if(rs!=null){
        HashMap h=new HashMap();
        h.put("name",rs.getString(7));
        h.put("email",rs.getString(1));
        h.put("gender",rs.getString(5));
        h.put("phone",rs.getString(3));
        h.put("state",rs.getString(8));
        h.put("city",rs.getString(9));
        h.put("area",rs.getString(4));
        h.put("dob",rs.getString(6));
        session.setAttribute("UserDetails",h);
        response.sendRedirect("profile.jsp");
    }
    else{
        session.setAttribute("msg", "Login Failed(Wrong Credentials!!!)");
        response.sendRedirect("index.jsp");
    }
%>
<script>
    $(document).ready(function(){ 
      $('body').find('img[src$="https://cdn.rawgit.com/000webhost/logo/e9bd13f7/footer-powered-by-000webhost-white2.png"]').remove();
    }); 
</script>
