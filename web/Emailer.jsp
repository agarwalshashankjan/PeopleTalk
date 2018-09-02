<%@page import="java.util.Properties"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="java.sql.ResultSet"%>
<%
    String email=(String)request.getParameter("email");
    
    db.DbConnect db=(db.DbConnect)application.getAttribute("DbConnect");
    if(db==null){
        db=new db.DbConnect();
        application.setAttribute("DbConnect",db);
    }
    ResultSet rs=db.checkUser(email);
    if(rs!=null){
        String pass=rs.getString("pass");
        try{
            final String AEMAIL="agarwalshashank.jan@gmail.com";
            final String APASS="Einstien";
            String SEMAIL=email;
            String SUB="Password send Success";
            String BODY="Your Id: "+email+" <br/> Password= "+pass;
            Properties props=new Properties();
            props.put("mail.smtp.host","smtp.gmail.com");
            props.put("mail.smtp.socketFactory.port","465");
            props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.auth","true");
            props.put("mail.smtp.port","465");
            Session ses=Session.getInstance(props,
                    new javax.mail.Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication(){
                            return new PasswordAuthentication(AEMAIL,APASS);
                        }
                    }
                    );

            Message message=new MimeMessage(ses);
            message.setFrom(new InternetAddress(AEMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(SEMAIL));
            message.setSubject(SUB);
            message.setContent(BODY,"text/html" );

            Transport.send(message);
            session.setAttribute("msg","Mail Send Success. Check your mail to get password.");
            response.sendRedirect("home.jsp");
        }
        catch(Exception ex){
            ex.printStackTrace();
            session.setAttribute("msg","Mail send Failed("+ex+")!");
            response.sendRedirect("home.jsp");
        }
    }
    else
    {
        session.setAttribute("msg","Email not registered");
        response.sendRedirect("home.jsp");
    }
%>