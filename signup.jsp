<%@ page import="java.sql.*" %>

<html>
<head>
        <title> FeedBack Management System </title>
        <link rel="stylesheet" href="mystyle.css"/>
        
</head>
<body>
<center>
          <h1> SignUp Page </h1>
          <a href="index.jsp"> Already Registered </a>
          <br><br>
          <form method="POST">
                   <input type="text" name="un" placeholder="enter username" required pattern="^[A-Za-z]+$"/>
                   <br><br>
                   <input type="password" name="pw1" placeholder="enter password" required >
                   <br><br>
                   <input type="password" name="pw2" placeholder="confirm password" required >
                   <br><br>
                   <input type="submit" value="Sign Up" name="btn">
                   <br><br>
       </form>

       <% 
       if (request.getParameter("btn") != null)
       { 
             String un = request.getParameter("un").trim();  // Trim the username

             if (un.length() == 0)
             {
                 out.println("You did not enter a name");
             }
             else if (un.length() < 2)
             {
                 out.println("Name should be a minimum of 2 characters");
             }
             else if (!un.matches("[A-Za-z]+"))
             {
                 out.println("Name should contain only alphabets");
             }
             else
             {
                 String pw1 = request.getParameter("pw1");
                 String pw2 = request.getParameter("pw2");

                 if (!pw1.equals(pw2))
                 {
                     out.println("Passwords did not match");
                     return;
                 }
                 try 
                 {
                     DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                     String url = "jdbc:mysql://localhost:3306/feedback_app";
                     Connection con = DriverManager.getConnection(url, "root", "amishaka");
                     String sql = "INSERT INTO user VALUES (?, ?)";
                     PreparedStatement pst = con.prepareStatement(sql);
                     pst.setString(1, un);
                     pst.setString(2, pw1);
                     pst.executeUpdate();
                     response.sendRedirect("index.jsp");
                     con.close();
                 }
                 catch(SQLException e)
                 {
                     out.println("SQL issue: " + e);
                 }
             }
       }
       %>
</center>
</body>
</html>
