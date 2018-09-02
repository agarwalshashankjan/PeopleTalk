<%@page import="java.util.HashMap"%>
<%
        session.invalidate();
    response.sendRedirect("home.jsp");
%>