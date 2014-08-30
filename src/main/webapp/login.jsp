<%@ page import="java.sql.*" %>
<jsp:include page="/header.jsp"/>

<%!
	private Connection conn = null;

	public void jspInit() {
		try {
			// Get hold of the JDBC driver
			Class.forName("org.hsqldb.jdbcDriver" );
			// Establish a connection to an in memory db
			conn = DriverManager.getConnection("jdbc:hsqldb:mem:SQL", "sa", "");
		} catch (SQLException e) {
			getServletContext().log("Db error: " + e);
		} catch (Exception e) {
			getServletContext().log("System error: " + e);
		}
	}
	
	public void jspDestroy() {
		try {
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			getServletContext().log("Db error: " + e);
		} catch (Exception e) {
			getServletContext().log("System error: " + e);
		}
	}
%>

<%
boolean loggedIn = false;
String username = (String) request.getParameter("username");
String password = (String) request.getParameter("password");
String debug = "Clear";

if (request.getMethod().equals("POST") && username != null) {
	Statement stmt = conn.createStatement();
	ResultSet rs = null;
	try {
		rs = stmt.executeQuery("SELECT * FROM Users WHERE (name = '" + username + "' AND password = '" + password + "')");
		if (rs.next()) {
			loggedIn = true;
			debug="Logged in";				
			// We must have been given the right credentials, right? ;)
			// Put credentials in the session
			String userid = "" + rs.getInt("userid");
			session.setAttribute("username", rs.getString("name"));
			session.setAttribute("userid", userid);
			session.setAttribute("usertype", rs.getString("type"));
			
			// Update the scores
			if (userid.equals("3")) {
				stmt.execute("UPDATE Score SET status = 1 WHERE task = 'LOGIN_TEST'");
			} else if (userid.equals("1")) {
				stmt.execute("UPDATE Score SET status = 1 WHERE task = 'LOGIN_USER1'");
			} else if (userid.equals("2")) {
				stmt.execute("UPDATE Score SET status = 1 WHERE task = 'LOGIN_ADMIN'");
			} 

			Cookie[] cookies = request.getCookies();
			String basketId = null;
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("b_id") && cookie.getValue().length() > 0) {
						basketId = cookie.getValue();
						break;
					}
				}
			}
			if (basketId != null) {
				debug += " basketid = " + basketId;
				int cBasketId = rs.getInt("currentbasketid");
				if (cBasketId > 0) {
					// Merge baskets
					debug += " currentbasketid = " + cBasketId;
					stmt.execute("UPDATE BasketContents SET basketid = " + cBasketId + " WHERE basketid = " + basketId);
					
				} else {
					stmt.execute("UPDATE Users SET currentbasketid = " + basketId + " WHERE userid = " + userid);
				}
				response.addCookie(new Cookie("b_id", ""));
			}

		}
	} catch (Exception e) {
		if ("true".equals(request.getParameter("debug"))) {
			stmt.execute("UPDATE Score SET status = 1 WHERE task = 'HIDDEN_DEBUG'");
			out.println("DEBUG System error: " + e + "<br/><br/>");
		} else {
			out.println("System error.");
		}
	} finally {
		if (rs != null) {
			rs.close();
		}
		stmt.close();
	}
}
%>

<%
if ("true".equals(request.getParameter("debug"))) {
	out.println("DEBUG: " + debug + "<br/><br/>");
}
// Display the form
if (request.getMethod().equals("POST") && username != null) {
	if (loggedIn) {
		out.println("<br/>You have logged in successfully: " + username);
		return;
		
	} else {
		out.println("<p style=\"color:red\">You supplied an invalid name or password.</p>");

	}
}
%>

<link href="./bootstrap/signin.css" rel="stylesheet">	
	<div class="container">

		  <form class="form-signin" method="POST">
				<h2 class="form-signin-heading">Please sign in</h2>
				<input name="username" type="email" class="form-control" placeholder="Email address" required autofocus>
				<input name="password" type="password" id="password" class="form-control" placeholder="Password" required>
				<label class="checkbox">
				  <input type="checkbox" value="remember-me"> Remember me
				</label>
				<button id="submit" class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
				<br/><br/>
				If you dont have an account with us then please <a href="register.jsp">Register</a> now for a free account.
		  </form>
		</div> <!-- /container -->
<jsp:include page="/footer.jsp"/>

