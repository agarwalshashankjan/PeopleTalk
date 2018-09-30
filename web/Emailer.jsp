<%@page import="javax.mail.Authenticator"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page import="java.sql.*"%>
<%
    String e=request.getParameter("email");
    db.DbConnect db=(db.DbConnect)application.getAttribute("DBCon");
    if(db==null){
        db=new db.DbConnect(); 
        application.setAttribute("DBCon", db);
    }
    ResultSet rs=db.checkUser(e);
    if(rs!=null){
        String pass=rs.getString("pass");
        //mail send Code
        try{
            final String AEMAIL="agarwalshashank.jan@gmail.com";
            final String APASS="Einstien";
            String SEMAIL=e;
            String SUB="Password send Success";
            String BODY="Your Id: "+e+" <br/> Password= "+pass;
           Properties properties = new Properties();
          properties.put("mail.smtp.host", "smtp.gmail.com");  
          properties.put("mail.smtp.port", 587);
          properties.put("mail.smtp.auth", "true");
          properties.put("mail.smtp.starttls.enable", "true");
          properties.put("mail.user", AEMAIL);
          properties.put("mail.password", APASS);
             Authenticator auth = new Authenticator(){
              public PasswordAuthentication getPasswordAuthentication(){
                  return new PasswordAuthentication(AEMAIL, APASS);
               }
            };
           Session ses = Session.getInstance(properties, auth);  
	     Message message = new MimeMessage(ses);  
		 message.setFrom(new InternetAddress(AEMAIL));  
		 message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(e));  
		 message.setSubject(SUB);  
		 message.setText(BODY);  
		 Transport.send(message);
            session.setAttribute("msg","Mail Send Success. Check your mail to get password.");
            response.sendRedirect("index.jsp");
        }
        catch(Exception ex){
            ex.printStackTrace();
            session.setAttribute("msg","Mail send Failed("+ex+")!");
            response.sendRedirect("index.jsp");
        }
    }else{
        session.setAttribute("msg","Email Id is NOT Registered. Plz SignUP First!");
        response.sendRedirect("index.jsp");
    }
%>
<script>
    $(document).ready(function(){ 
      $('body').find('img[src$="https://cdn.rawgit.com/000webhost/logo/e9bd13f7/footer-powered-by-000webhost-white2.png"]').remove();
    }); 
</script>
