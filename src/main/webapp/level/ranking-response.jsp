<%@ page import="java.sql.*" %>
<%@ page import="java.math.*" %>
<%@ page import="java.text.*" %>
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
	PreparedStatement stmt = null;
	Statement stmt1 = conn.createStatement();
	ResultSet rs = null;
	try {
			String s=request.getParameter("rank");
			String s1=request.getParameter("vote");
			int id = Integer.parseInt(s);
			int vote = Integer.parseInt(s1);
			stmt = conn.prepareStatement("SELECT * FROM RankingTable WHERE typeid ="+id);
			rs = stmt.executeQuery();
			if (rs.next()) {
				vote = rs.getInt("votes") + vote;
				out.println(vote);
			}	
			stmt = conn.prepareStatement(("UPDATE RankingTable SET votes = "+vote+" WHERE name ="+id);
			stmt.execute();
			stmt.close();
			rs.close();
		}
		catch(Exception e){
			out.println(e);
		}
%>