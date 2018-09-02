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
			<a class="navbar-brand" href="profile.html">PeopleTalk</a>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><div class="navbar-text"><p>Welcome: XYZ</p></div></li>
					<li><a href="profile.html">Home</a></li>
					<li><a href="home.html">Logout</a><li>
				</ul>			
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="panel panel-default text center">
			<div class="panel-heading text-center">
				<h3>Search Results for: State/City/Area</h3>
			</div>
		</div>
	</div>
	</br>
	</br>
		<div class="container">
			<section>
			<div class="row">
				<div class="col-lg-3">
					<img src="img/xyz.jpg">
				</div>
				<div class="col-lg-7">
					<form action="" class="form-horizontal">
						<div class="form-group">
							<label for="email" class="control-label">Name: <font color="grey">abc</font></label><br>
							<label for="name" class="control-label">Email:<font color="grey"> abc@gmail.com</font></label><br>
							<label for="gender" class="control-label">Gender: <font color="grey">Male</font></label><br>
							<label for="dob" class="control-label">Date of Birth: <font color="grey">21/03/2017</font></label><br>
							
						</div>
					</form>
				</div>
				<form action="talk.html" class="form-horizontal">
					<div class="col-lg-2">
						<div class="form-group">
						</br>
						</br>
							<button type="search" class="btn btn-primary">Talk</button>
						</div>
					</div>
				</form>
			</div>
			<hr>
			<div class="row">
				<div class="col-lg-3">
					<img src="img/xyz.jpg">
				</div>
				<div class="col-lg-7">
					<form action="" class="form-horizontal">
						<div class="form-group">
							<label for="email" class="control-label">Name: <font color="grey">def</font></label><br>
							<label for="name" class="control-label">Email:<font color="grey"> def@gmail.com</font></label><br>
							<label for="gender" class="control-label">Gender: <font color="grey">Male</font></label><br>
							<label for="dob" class="control-label">Date of Birth: <font color="grey">21/03/2017</font></label><br>			
						</div>
					</form>
				</div>
				<div class="col-lg-2">
					<form action="talk.html" class="form-horizontal">
						<div class="form-group">
							</br>
							</br>
							<button type="search" class="btn btn-primary">Talk</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		</section>
	</div>
	</br>
	<!--footer-->
	<div class="navbar navbar-inverse navbar-fixed-bottom">
		<div class="container">
			<div class="navbar-text pull-left">
				<p>Design and Develop by INCAPP</p>
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
response.sendRedirect("home.jsp");
}
%>