<jsp:include page="/level/header-level.jsp"/>
<%!
	private String getRndPassword() {
		// Dont want to make things too easy ;)
		StringBuffer sb = new StringBuffer();
		int passwordSize = 5 + (int)(Math.random() * 10);
		for (int i = 0; i < passwordSize; i++) {
			int start = Character.valueOf('0').charValue();
			int end = Character.valueOf('z').charValue();
			int charValue = start + (int)(Math.random() * (end - start));
				sb.append((char)charValue);
		}
	    return sb.toString();
	}
%>
<%
				String password = (String) request.getParameter("password");	
				if (request.getMethod().equals("POST") && password.equals((String) session.getAttribute("password"))) {
					response.sendRedirect("http://localhost:8080/wiprostore/level/2.jsp"); //replacelink
					return;
				}
				else{
%>
	<link href="../bootstrap/signin.css" rel="stylesheet">	
		<div class="container">
			<form class="form-signin" method="POST">
				<%
				String rnd_pwd = getRndPassword();
				session.setAttribute("password", rnd_pwd);
				out.println("<!--DEV 1.0.1 | Copyright 2014 ESS. All rights reserved-->");	
				out.println("<!--"+rnd_pwd+"-->");			
				%>				
				<h2 class="form-signin-heading">Level 1</h2>
				<h3>Enter the password.</h3>
				<input name="password" type="password" id="password" class="form-control" placeholder="Password" required>
				<button id="submit" class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
				<br/><br/>
			</form>
			<%	} %>
		</div>
</body>
</html>