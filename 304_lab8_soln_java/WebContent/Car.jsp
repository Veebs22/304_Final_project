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
        .container {
            max-width: 2000px; 
            margin: 0 auto;
            padding: 20px;
        }
        .car-item {
            margin-bottom: 30px; /* Space between car entries */
            display: flex;
            align-items: center;
        }
        .car-image {
            max-width: 500px; /* Adjust image size */
            height: auto;
            margin-right: 100px; /* Space between image and data */
        }
        .car-details {
            flex: 1; /* Allow details to take available space */
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
<%@ include file="header.jsp" %>

<div class="container">
    <%
   
        String output = "CarID asc";
      
            String sql2 = "select state FROM Customer WHERE userid = ?";
                    try {
                    getConnection();
                    Statement stmt = con.createStatement();
                    stmt.execute("USE orders");
                    PreparedStatement pstmt = con.prepareStatement(sql2);
	                pstmt.setString(1, userName);	
                  
                    ResultSet rst = pstmt.executeQuery();
                    if (rst.next()) {
                        String state = rst.getString(1);
                       switch(state){
                        case "CA": output = "CarMPG desc"; break;
                        case "TX": output = "CarPower desc"; break;
                        case "BC": output = "CarWinterCapable Desc"; break;
                        case "QB": output = "CarWinterCapable Desc"; break;
                        case "WA": output = "CarWinterCapable Desc"; break;
                        case "AB": output = "CarWeight Desc"; break;
                         case "MA": output = "CarZeroToSixty asc"; break;
                       }
                    }
                } catch (SQLException ex) {
                    out.println("<p class='text-danger'>" + ex + "</p>");
                } finally {
                    closeConnection();
                }
               
        
    String recomendation = output;
    
        String sql = "SELECT * FROM Cars ORDER BY "+recomendation+"";
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
                String carName = rst.getString(2); 
                int carYear = rst.getInt(3); 
                String imageUrl = "img/" + rst.getInt(1) + ".jpg";  
                out.println("<div class='row car-item'>");

                // Display car image
                out.println("<div class='col-md-4 text-center'>");
                out.println("<img src='" + imageUrl + "' alt='" + carYear + " " + carName + "\n Image not available!"+"' class='car-image' />");
                out.println("</div>");

                // Display car details
                out.println("<div class='col-md-8 car-details'>");
                out.println("<table class='table table-bordered table-striped'>");
                out.println("<tr><th>Name</th><td>" + carName + "</td></tr>");
                out.println("<tr><th>Year</th><td>" + carYear + "</td></tr>");
                out.println("<tr><th>Price</th><td>" + currFormat.format(rst.getInt(4)) + "</td></tr>");
                out.println("<tr><th>MPG</th><td>" + rst.getDouble(5) + "</td></tr>");
                out.println("<tr><th>0-60 (Mph)</th><td>" + rst.getDouble(7) + "</td></tr>");
                out.println("</table>");
                out.println("</div>");

                out.println("</div>"); 
            }
        } catch (SQLException ex) {
            out.println("<p class='text-danger'>" + ex + "</p>");
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
