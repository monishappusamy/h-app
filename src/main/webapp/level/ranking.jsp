

<jsp:include page="/level/header-level.jsp"/>
<%@ page import="java.math.*" %>
<%@ page import="java.servlet.*" %>
<%@ page import="java.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>

<script>
function httpGet(rank)
{	
    var xmlHttp = null;
    xmlHttp = new XMLHttpRequest();
	xmlHttp.onreadystatechange=function()
	  {
	  if (xmlHttp.readyState==4 && xmlHttp.status==200)
		{
		document.getElementById("myDiv").innerHTML=xmlHttp.responseText;
		}
	  }
    xmlHttp.open( "GET", "ranking-response.jsp?rank="+rank+"&vote=1", false );
    xmlHttp.send( null );
	//location.reload();
}
</script>


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
<div class="container">
<form action="encrypt.jsp" method="GET">
<%
	PreparedStatement stmt = null;
	ResultSet rs = null;
	try {
		stmt = conn.prepareStatement("SELECT COUNT (*) FROM RankingTable");
		rs = stmt.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		rs.close();
		stmt.close();
		out.println("<center><table border=\"0\" width=\"60%\" class=\"table table-striped\">");
		out.println("<thead><tr><th>Rank</th><th>Name</th><th>Vote</th></tr></thead><tbody>");
		
		NumberFormat nf = NumberFormat.getCurrencyInstance();
		int rank = 0;
			stmt = conn.prepareStatement("SELECT * FROM RankingTable ORDER BY votes DESC");
			rs = stmt.executeQuery();
			while (rs.next()) {
				out.println("<tr>");
				out.println( "<td>" + ++rank + "</td>" + "<td>" + rs.getString("name")+ "</td>" + "<td>" + rs.getInt("votes")+ "</td>" 
								+ "<td><a style= \"line-height:0.5;font-size:16px\" class=\"btn btn-primary btn-lg\" role=\"button\" onclick=\"httpGet("+rs.getInt("typeid")+")\">vote</a></td>");
			}
			stmt.close();
			rs.close();
		out.println("</tbody></table></center><br/>");
	} catch (SQLException e) {
		if ("true".equals(request.getParameter("debug"))) {
			out.println("DEBUG System error: " + e + "<br/><br/>");
		} else {
			out.println("System error.");
		}
	}
%>

<div id="myDiv"><h2>Let AJAX change this text</h2></div>

</form>
</div>
