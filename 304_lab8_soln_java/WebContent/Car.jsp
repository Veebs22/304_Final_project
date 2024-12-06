<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Inventory</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        h3 {
            text-align: center;
            margin-top: 30px;
        }
        .table {
            margin-top: 20px;
            margin-left: auto;
            margin-right: auto;
            width: 80%;
        }
        .table th, .table td {
            text-align: left;
            padding: 12px;
            vertical-align: middle;
        }
        .table th {
            background-color: #007bff;
            color: white;
        }
        .table td {
            background-color: #ffffff;
        }
        .table tr:nth-child(even) td {
            background-color: #f2f2f2;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
        }
        .footer {
            text-align: center;
            margin-top: 30px;
            padding: 10px;
            background-color: #007bff;
            color: white;
        }
    </style>
</head>
<body>

<%@ include file="auth.jsp" %>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
    String userName = (String) session.getAttribute("authenticatedUser");
%>

<div class="container">
    <%
        String sql = "SELECT * FROM Cars";
        NumberFormat currFormat = NumberFormat.getCurrencyInstance();

        try {
            out.println("<h3>Car Inventory</h3>");

            getConnection();
            Statement stmt = con.createStatement();
            stmt.execute("USE orders");

            PreparedStatement pstmt = con.prepareStatement(sql);
            ResultSet rst = pstmt.executeQuery();

            // Loop through the result set and display car details in tables
            while (rst.next()) {
                out.println("<div class=\"table-responsive\">");
                out.println("<table class=\"table table-bordered table-striped\">");
                out.println("<tr><th>Name</th><td>" + rst.getString(1) + "</td></tr>");
                out.println("<tr><th>Year</th><td>" + rst.getInt(2) + "</td></tr>");
                out.println("<tr><th>Price</th><td>" + currFormat.format(rst.getInt(3)) + "</td></tr>");
                out.println("<tr><th>MPG</th><td>" + rst.getDouble(4) + "</td></tr>");
				out.println("<tr><th>0-60 (Mph)</th><td>" + rst.getDouble(6) + "</td></tr>");
                out.println("</table>");
                out.println("</div>");
            }
        } catch (SQLException ex) {
            out.println("<p class=\"text-danger\">" + ex + "</p>");
        } finally {
            closeConnection();
        }
    %>
</div>

<div class="footer">
    <p>&copy; 2024 Car Inventory | All rights reserved</p>
</div>

<!-- Bootstrap JS (Optional for functionality like collapsible navbar) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
