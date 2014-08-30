<%@ page import="java.math.*" %>
<%@ page import="java.servlet.*" %>
<%@ page import="java.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" href="../../favicon.ico">
	<title>Hackathon</title>
	<script type="text/javascript" src="./js/util.js"></script>
	
	<!-- Bootstrap core CSS -->
    <link href="./bootstrap/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Custom styles for this template -->
    <link href="./bootstrap/starter-template.css" rel="stylesheet">

</head>
<body>
<%
	String username = (String) session.getAttribute("username");
	String usertype = (String) session.getAttribute("usertype");
%>
	<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
			  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			  </button>
			  <a class="navbar-brand" href="#">Wipro Store</a>
			</div>
			<div class="collapse navbar-collapse">
			  <ul class="nav navbar-nav">
				<li class="active"><a href="home.jsp">Home</a></li>
				<li><a href="about.jsp">About</a></li>
				<%
					if (usertype != null && usertype.equals("ADMIN")) {
				%>
				<li><a href="contact.jsp">Comments</a></li>
				<li><a href="admin.jsp">Admin</a></li>
				<%
					} else {
				%>
				<li><a href="contact.jsp">Contact us</a></li>
				<%
					}
				%>
				<%
					if (usertype == null) {
				%>
						<li><a href="login.jsp">Login</a></li>
				<%
					} else {
				%>
						<li><a href="logout.jsp">Logout</a></li>
				<%
					}
				%>
				
				
				<%
					if (usertype == null || ! usertype.equals("ADMIN")) {
				%>
						<li><a href="basket.jsp">Your Basket</a></li>
				<%
					}
				%>
						<li><a href="search.jsp">Search</a></li>

				
			  </ul>
			  
			  <ul class="nav navbar-nav navbar-right">
				<li><a href="#GuestUser">
						<%
							if (username != null) {
								out.println("</a></li><li><a href=\"password.jsp\">"+ username +"</a></li>");
							} else {
								out.println("Guest user");
							}
						%>
	
				</a></li>
			  </ul>
			</div><!--/.nav-collapse -->
		</div>
    </div>

	<div class="container">
	<div class="row row-offcanvas row-offcanvas-right">
	<div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar" role="navigation">
          <div class="list-group">
			<%
			Connection c1 = null;
			PreparedStatement stmt1 = null;
			ResultSet rs1 = null;
			try {
				// Get hold of the JDBC driver
				Class.forName("org.hsqldb.jdbcDriver" );
				// Establish a connection to an in memory db
				c1 = DriverManager.getConnection("jdbc:hsqldb:mem:SQL", "sa", "");
				stmt1 = c1.prepareStatement("SELECT * FROM ProductTypes ORDER BY type");
				rs1 = stmt1.executeQuery();
				while (rs1.next()) {
					String type = rs1.getString("type");
					out.println("<a class=\"list-group-item\" href=\"product.jsp?typeid=" + rs1.getInt("typeid") + "\" >" + type + "</a>");
				}
			} catch (SQLException e) {
				if ("true".equals(request.getParameter("debug"))) {
					c1.createStatement().execute("UPDATE Score SET status = 1 WHERE task = 'HIDDEN_DEBUG'");
					out.println("DEBUG System error: " + e + "<br/><br/>");
				} else {
					out.println("System error.");
				}
			} finally {
				stmt1.close();
				rs1.close();
				c1.close();
			}
		%>
		
			
            <a href="#" class="list-group-item active">Link</a>
          </div>
        </div><!--/span-->
