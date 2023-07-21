<%@ page import="java.sql.*" %>

<html>
<head>
        <title> FeedBack Management System </title>
        <link rel="stylesheet" href="mystyle.css"/>
</head>
<body>
<center>
        
        </div>
          <h1> Login Page </h1>
          <a href="signup.jsp"> New Users Click Here </a>
          <br><br>
          <form method="POST">
                   <input type="text" name="un" placeholder="enter username" required pattern="^[A-Za-z ]+$"/>
                   <br><br>
                   <input type="password" name="pw" placeholder="enter password" required>
                   <br><br>
                   <input type="submit" value="Login" name="btn">
                   <br><br>
       </form>

       <% 
       if (request.getParameter("btn") != null)
       {
             String un = request.getParameter("un");
             String pw = request.getParameter("pw");
             try 
             {
             DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
             String url = "jdbc:mysql://localhost:3306/feedback_app";
             Connection con = DriverManager.getConnection(url, "root", "amishaka");
             String sql = "select * from user where un = ? and pw = ?";
             PreparedStatement pst = con.prepareStatement(sql);
             pst.setString(1, un);
             pst.setString(2, pw);
             ResultSet rs = pst.executeQuery();
             if (rs.next()) {
                       session.setAttribute("un", un);
                       response.sendRedirect("home.jsp");
             } else {
                      out.println("invaild login");

             }
             con.close();
             }
             catch(SQLException e )
             {
                    out.println("sql issue " + e);
             }
       }
       %>
</center>
</body>
</html>
