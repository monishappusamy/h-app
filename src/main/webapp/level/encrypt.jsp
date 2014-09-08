<jsp:include page="/level/header-level.jsp"/>


<%
//String actual_password = request.getParameter("actual_password");
//if(actual_password.equals("INJ3C+0R"))
	
%>
<div class="container">
<div class="jumbotron">
<center>
<h2>Level 3</h2>
A well reputed company's database has been Hacked. However the passwords in the database were encrypted. <br/>The Encrypted value of CEO's password is : HLG/>%)J 
</div>
<link href="../bootstrap/signin.css" rel="stylesheet">
<div class="row"> 
<div style = "background:#eef" class="col-lg-6"><center><br/>
Hackers have cracked the encryption algorithm.  The cracked algorithm has been implemented below.   <br/><br/>
Enter string to encrypt: <br/>
	
<form class="form-signin" method="get">

<input style="margin-bottom: 10px;" name="encrypt_value" type="" id="password" class="form-control" placeholder="">
<button style="width:50%" id="submit" class="btn btn-lg btn-primary btn-block" type="submit">Encrypt</button>
</form>
<%
String s=request.getParameter("encrypt_value");
out.print("Encrypted string is : ");
try{
	for ( int i = 0; i < s.length(); ++i )
	{
	  char c = s.charAt(i);
	  int j = (int) c;
	  out.print((char)(j-(i+1)));
	}
}
catch(Exception e){
out.println("");
}
%>
<br/>

<br/>
</div>
<div style = "background:#eef" class="col-lg-6"><center>	<br/>
Enter the Password to proceed to next level: <br/>
<h3>Sign in</h3>
<form class="form-signin" method="get">
 <h4>Username : CEO</h4>
<br\><input name="password" type="password" id="password" class="form-control" placeholder="Password" required>
<button style="width:50% "id="submit" class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
</form>
</center>
</div>
</div>
</div>
</body>
</html>