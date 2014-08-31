<%@ page import="java.sql.*" %>
<%
session.setAttribute("username", null);
session.setAttribute("usertype", null);
session.setAttribute("userid", null);
%>
<jsp:include page="/header.jsp"/>

<br/><h3 style="color:green">Thank you for your custom.</h3><br/>

<jsp:include page="/footer.jsp"/>

