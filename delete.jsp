<%@ page import="java.sql.*" %>

<html>
<head>
    <title>FeedBack Management System</title>
    <link rel="stylesheet" href="mystyle.css"/>
    <script>
        function confirmDelete() {
            return confirm("Are you sure you want to delete?");
        }
    </script>
</head>
<body>
<center>
    <div class="nav">
        <a href="home.jsp">Home</a>
       
        <a href="view.jsp">View Feedbacks</a>
    </div>
    <h1>Delete Your Feedback</h1>
    <%
        String un = (String) session.getAttribute("un");
        if (un == null) {
            response.sendRedirect("index.jsp");
        } 
    %>
    <form method="POST">
        <input type="email" name="email" placeholder="Enter your registered email ID" required min="1">
        <br><br>
        <input type="submit" value="Delete" name="btn" onclick="return confirmDelete()">
        <br><br>
    </form>

    <%
        if (request.getParameter("btn") != null) {
            String email = request.getParameter("email");
            
            try {
                DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                String url = "jdbc:mysql://localhost:3306/feedback_app";
                Connection con = DriverManager.getConnection(url, "root", "amishaka");
                String sql = "DELETE FROM student WHERE email=?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, email);
                int r = pst.executeUpdate();

                out.println(r + " record deleted");
                con.close();
            } catch (SQLException e) {
                out.println("SQL issue: " + e);
            }
        }
    %>
</center>
</body>
</html>
