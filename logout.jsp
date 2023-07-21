<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>FeedBack Management System</title>
    <link rel="stylesheet" href="mystyle.css"/>
    <style>
        .center {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            gap: 45px;
            
        }
    </style>
    <script>
        function confirmLogout() {
            return confirm("Are you sure you want to log out?");
        }
    </script>
</head>

<body>
    <center>
        <%
        String un = (String) session.getAttribute("un");
        if (un == null) {
            response.sendRedirect("index.jsp");
        } 
    %>
        <form method="POST" onsubmit="return validateForm()" class="center">
            <input type="submit" value="Logout" name="logout" onclick="return confirmLogout()">
            <input type="submit" value="Back" name="back">
        </form>

        <%
            if (request.getParameter("logout") != null) {
                session.invalidate();
                response.sendRedirect("index.jsp");
                return;
            } else if (request.getParameter("back") != null) {
                response.sendRedirect("home.jsp");
                return;
            }
        %>
    </center>
</body>
</html>
