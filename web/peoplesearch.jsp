<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.HashMap"%>
<%
    HashMap h=(HashMap)session.getAttribute("UserDetails");
    if(h!=null){
        
%><!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PeopleTalk</title>


    <link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/talk.css" rel="stylesheet">

  
  </head>
 
  <body data-spy="scroll" data-target="#my-navbar">
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="profile.jsp">PeopleTalk</a>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><div class="navbar-text"><p>Welcome: <%=(String)h.get("name")%></p></div></li>
					<li><a href="profile.jsp">Home</a></li>
					<li><a href="Logout.jsp">Logout</a><li>
				</ul>			
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="panel panel-default text center">
                    <%
                        String state=request.getParameter("state");
                        String city=request.getParameter("city");
                        String area=request.getParameter("area");
                    %>
			<div class="panel-heading text-center">
				<h3>Search Results for: <%=state%>/<%=city%>/<%=area%></h3>
			</div>
		</div>
	</div>
	</br>
	</br>
        <%
            db.DbConnect db=(db.DbConnect)application.getAttribute("DBCon");
                if(db==null){
                    db=new db.DbConnect(); 
                    application.setAttribute("DBCon", db);
                }
                ResultSet rs=db.getSearchUser(state,city,area,(String)h.get("email"));
            while(rs.next()){
        %>
		<div class="row">
				<div class="col-lg-3">
					<%
                ResultSet rs2=db.checkUser((String)h.get("email"));
                if(rs.getBinaryStream(10)!=null){
                 %>
                <img src="GetPhoto?email=<%=rs.getString("email")%>" width="120" height="150">                            
                <%   
                }else{
                 %>
                <img src="img/xyz.jpg" width="120" height="150">                           
                <%    
                }
                                            %>
                                            
				</div>
				<div class="col-lg-7">
					<form action="" class="form-horizontal">
						<div class="form-group">
                                                    <label for="email" class="control-label">Name: <font color="grey"><%=rs.getString("name")%></font></label><br>
							<label for="name" class="control-label">Email:<font color="grey"> <%=rs.getString("email")%></font></label><br>
							<label for="phone" class="control-label">Phone: <font color="grey"><%=rs.getString("phone")%></font></label><br>
							<label for="gender" class="control-label">Gender: <font color="grey"><%=rs.getString("gender")%></font></label><br>
							<label for="dob" class="control-label">Date of Birth: <font color="grey"><%=rs.getString("dob")%></font></label><br>
							
						</div>
					</form>
				</div>
				<form action="talk.jsp" method="post" class="form-horizontal">
					<div class="col-lg-2">
						<div class="form-group">
						<br>
						<br>
                                                <input type="hidden" name="temail" value="<%=rs.getString("email")%>" />
							<button type="submit" class="btn btn-primary">Talk</button>
						</div>
					</div>
				</form>
			</div>
			<hr>
			<%
                            }
                        %>
	<!--footer-->
	<div class="navbar navbar-inverse navbar-fixed-bottom">
		<div class="container">
			<div class="navbar-text pull-left">
				<p>Design and Develop by Shashank Agarwal</p>
			</div>
                        <div class="navbar-text pull-right">
                                                <% 
                             Integer hitsCount = (Integer)application.getAttribute("hitCounter");  
                             if( hitsCount ==null || hitsCount == 0 )
                             {      
                                    hitsCount = 1;   
                             }else
                                 {        
                                   hitsCount += 1;   
                             }   
                             application.setAttribute("hitCounter", hitsCount);
                             %> 
                             <p>Total number of visits:
                             <%= hitsCount%>
                             </p>
                        </div>
		</div>
	</div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
<%
}
else{
session.setAttribute("msg","Please Login First!!!!");
response.sendRedirect("index.jsp");
}
%>
<script>
    $(document).ready(function(){ 
      $('body').find('img[src$="https://cdn.rawgit.com/000webhost/logo/e9bd13f7/footer-powered-by-000webhost-white2.png"]').remove();
    }); 
</script>
