<%@page import="java.util.HashMap"%>
<%@page import="java.sql.*"%>
<%
    HashMap h=(HashMap)session.getAttribute("UserDetails");
    if(h!=null){
        db.DbConnect db=(db.DbConnect)application.getAttribute("DBCon");
        if(db==null){
            db=new db.DbConnect(); 
            application.setAttribute("DBCon", db);
        }
        System.out.println("q1");
        Statement st=db.getSt();
        String email=(String)h.get("email");
        String oldpwd=request.getParameter("password");
        String newpwd=request.getParameter("newpassword");
        String confirmpwd=request.getParameter("confirmpassword");
        
        //ResultSet pass=db.getpass("email");
        System.out.println(email);
        ResultSet x=db.getpass(email);
        String pass=x.getString("pass");
        
        if(oldpwd.equals(pass) && newpwd.equals(confirmpwd)){
           
            int rs=db.changePass(email, newpwd);
            if(rs!=-1){
            
            session.setAttribute("msg","password updated succesfull");
            response.sendRedirect("Logout.jsp");
//            session.setAttribute("msg1","password updated succesfull");
//            response.sendRedirect("changepassword.jsp");
            }else{
                session.setAttribute("msg","something went wrong");
                response.sendRedirect("changepassword.jsp");
            }
        }
        
        else if(oldpwd.equals(pass) && !(newpwd.equals(confirmpwd))){
            System.out.println("q5");
                
            session.setAttribute("msg1","pas dint match");
            response.sendRedirect("changepassword.jsp");
            }
        
        
        else if(!(oldpwd.equals(pass)) && newpwd.equals(confirmpwd)){
            System.out.println("q5");
                
            session.setAttribute("msg1","Wrong credentials");
            response.sendRedirect("changepassword.jsp");
            }
        }
else{
    session.setAttribute("msg","Plz Login First!");
response.sendRedirect("index.jsp");
}
%>
<script>
    $(document).ready(function(){ 
      $('body').find('img[src$="https://cdn.rawgit.com/000webhost/logo/e9bd13f7/footer-powered-by-000webhost-white2.png"]').remove();
    }); 
</script>
