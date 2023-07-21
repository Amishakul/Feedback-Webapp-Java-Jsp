<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>FeedBack Management System</title>
    <link rel="stylesheet" href="mystyle.css"/>
    <script>
        function validateForm() {
            var name = document.getElementsByName("name")[0].value;
            var email = document.getElementsByName("email")[0].value;
            var phone = document.getElementsByName("phone")[0].value;
            var rating = document.querySelector('input[name="f"]:checked');
            var query = document.getElementsByName("query")[0].value;

            // Check if any of the required fields are filled
            if (name.trim().length > 0 || email.trim().length > 0 || phone.trim().length > 0 || rating || query.trim().length > 0) {
                // Validate name field
                if (name.trim().length < 3) {
                 alert("Name should have at least 3 characters");
                 return false;
            }
                if (!/^[A-Za-z]+$/.test(name)) {
                alert("Name should only contain alphabets");
                return false;
           }
                if (/^\s/.test(name)) {
                alert("Name should not start with a space");
                return false;
            }








                // Validate phone field
                if (phone.trim().length !== 10 || !/^\d+$/.test(phone)) {
                    alert("Phone number should have exactly 10 digits");
                    return false;
                }

                // Validate email field
                if (!/\S+@\S+\.\S+/.test(email)) {
                    alert("Invalid email format");
                    return false;
                }

                // Validate star rating
                if (!rating) {
                    alert("Please select a star rating");
                    return false;
                }

                // Validate query field
                if (query.trim().length === 0) {
                    alert("Please enter a query/feedback");
                    return false;
                }
            }

            return true;
        }

        
    </script>
</head>
<body>
<center>
    <div class="nav">
        <a href="delete.jsp">Delete your feedback</a>
        <a href="view.jsp">View feedbacks</a>
        <a href="logout.jsp"> Logout</a>
    </div>
    <h1>FeedBack for our Courses</h1>
    <%
        String un = (String) session.getAttribute("un");
        if (un == null) {
            response.sendRedirect("index.jsp");
        } else {
            out.println("Welcome " + un + "\uD83D\uDE03");
        }
    %>
    <form method="POST" onsubmit="return validateForm()">
        <br><br>
        
        
        <input type="text" name="name" placeholder="Enter name" required  />
        <br><br>
        <input type="text" name="email" placeholder="Enter email"  required/>
        <br><br>
        <input type="text" name="phone" placeholder="Enter your phone no" required />
        <br><br>

        Please feel free to rate our courses between 1-5 ratings 🥰
        <br><br>
        <input type="radio" name="f" value="1 star">⭐
        <input type="radio" name="f" value="2 stars">⭐⭐
        <input type="radio" name="f" value="3 stars">⭐⭐⭐
        <input type="radio" name="f" value="4 stars">⭐⭐⭐⭐
        <input type="radio" name="f" value="5 stars">⭐⭐⭐⭐⭐
        <br><br>
        <textarea name="query" placeholder="Enter query/feedback" rows=4 cols=30 required ></textarea>
        <br><br>
        <input type="submit" name="btn" value="Submit"/>
        <br><br>
    </form>

    <%
        if (request.getParameter("btn") != null) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phoneStr = request.getParameter("phone");
            long phone = 0;
            if (!phoneStr.isEmpty()) {
                phone = Long.parseLong(phoneStr);
            }
            String fb = request.getParameter("f");
            String query = request.getParameter("query");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/feedback_app";
                Connection con = DriverManager.getConnection(url, "root", "amishaka");
                String sql = "INSERT INTO student (name, email, phone, feedback, query) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, name);
                pst.setString(2, email);
                pst.setLong(3, phone);
                pst.setString(4, fb);
                pst.setString(5, query);
                pst.executeUpdate();
                out.println("Your response is successfully submitted. Thank you");

                con.close();
            } catch (ClassNotFoundException e) {
                out.println("Database driver not found");
            } catch (SQLException e) {
                out.println("Issue with database operation: " + e.getMessage());
            }
        }

        
        
    %>
</center>
</body>
</html>