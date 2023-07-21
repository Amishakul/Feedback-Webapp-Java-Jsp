<%@ page import="java.sql.*" %>

<html>
<head>
        <title> FeedBack Management System </title>
        <link rel="stylesheet" href="mystyle.css"/>
</head>
<body>
<center>
         <div class="nav">
                 <a href="home.jsp" > Home </a>
                 
                 <a href="delete.jsp" > Delete your feedback </a>
         </div>
         <h1> View Feedbacks from our Students </h1>
         <%
        String un = (String) session.getAttribute("un");
        if (un == null) {
            response.sendRedirect("index.jsp");
        } 
    %>
         <table border="5" style="width:80%;">
                <tr>
                <th> Name </th>
                <th> Ratings </th>
                <th> Query/Feedbacks </th>
                </tr>

       <%
           try 
           {
           DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
           String url = "jdbc:mysql://localhost:3306/feedback_app";
           Connection con = DriverManager.getConnection(url, "root", "amishaka");
           String sql = "SELECT name, feedback, query FROM student";
           PreparedStatement pst = con.prepareStatement(sql);
           ResultSet rs = pst.executeQuery();

           while(rs.next())
           {
      %>
            <tr style="text-align:center;">
            <td> <%= rs.getString(1) %> </td>
            <td> <%= rs.getString(2) %> </td>
            <td> <%= rs.getString(3) %> </td>

            </tr>
      <%    }
            con.close();
            }
            catch(SQLException e)
            {
                     out.println("sql issue " + e);
            }
    %>
    </table>
</center>
</body>
</html>