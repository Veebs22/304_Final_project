<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Detail</title>
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
            max-width: 800px; 
            margin: 0 auto;
            padding: 20px;
        }
        .car-item {
            margin-bottom: 100px;
            display: flex;
            align-items: center;
           
        }
        .car-image {
            max-width: 1600px; 
            height: auto;
            margin-right: 20px; 
        }
        .car-details {
            flex: 1;
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
        // Get the car ID from the request
        String carId = request.getParameter("id"); 

        // Check if the car ID is valid
        if (carId != null && !carId.isEmpty()) {
            NumberFormat currFormat = NumberFormat.getCurrencyInstance();
            String sql = "SELECT * FROM Cars WHERE CarID = ?";
            
            try {
                getConnection();
                Statement stmt = con.createStatement();
                stmt.execute("USE orders");

                // Prepare and execute the query to get the car details based on the provided car ID
                PreparedStatement pstmt = con.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(carId)); // Set the car ID in the query
                ResultSet rst = pstmt.executeQuery();

                // Check if the car was found
                if (rst.next()) {
                    String carName = rst.getString("CarName");
                    int carYear = rst.getInt("CarYear");
                    String imageUrl = "img/" + rst.getInt("CarID") + ".jpg";

                    out.println("<h3>Car Details</h3>");
                    out.println("<div class='row car-item'>");
                
                    // Display the car image
                    out.println("<div class='col-md-12 text-center'>");
                    out.println("<img src='" + imageUrl + "' alt='" + carYear + " " + carName + "' class='car-image' />");
                    out.println("</div>");

                    // Display the car's details
                    out.println("<div class='col-md-6 car-details'>");
                    out.println("<table class='table table-bordered table-striped'>");
                    out.println("<tr><th>Name</th><td>" + carName + "</td></tr>");
                    out.println("<tr><th>Year</th><td>" + carYear + "</td></tr>");
                    out.println("<tr><th>Price</th><td>" + currFormat.format(rst.getInt("CarPrice")) + "</td></tr>");
                    out.println("<tr><th>MPG</th><td>" + rst.getDouble("CarMPG") + "</td></tr>");
                    out.println("<tr><th>Estimated Monthly Fuel Cost </th><td>" + currFormat.format(rst.getInt("CarMonthlyFuelCosts"))+ "</td></tr>");
                    out.println("<tr><th>0-60 (Mph)</th><td>" + rst.getDouble("CarZeroToSixty")+" Seconds" + "</td></tr>");
                    out.println("<tr><th>Horsepower</th><td>" + rst.getDouble("CarPower") + "</td></tr>");
                    out.println("<tr><th>Reliability Score: </th><td>" + rst.getDouble("CarReliability")+"/10" + "</td></tr>");
                    out.println("<tr><th>Cargo Volume (all seats in place): </th><td>" + rst.getDouble("CarCargoVolume")+" Litres " + "</td></tr>");
                    out.println("<tr><th>Number of seats: </th><td>" + rst.getInt("CarNumberOfSeats")+ "</td></tr>");
                    out.println("<tr><th>Safe to drive in winter?</th><td>" + rst.getString("CarWinterCapable")+ "</td></tr>");
                     
                    
                    out.println("</table>");
                    out.println("</div>");

                    out.println("</div>"); 
                } else {
                    out.println("<p class='text-danger'>Car not found. Please check the ID and try again.</p>");
                }
            } catch (SQLException ex) {
                out.println("<p class='text-danger'>" + ex + "</p>");
            } finally {
                closeConnection();
            }
        } else {
            out.println("<p class='text-danger'>No car ID provided. Please select a car.</p>");
        }
    %>
</div>

<div class="footer">
    <p>&copy; 2024 Car Inventory | All rights reserved</p>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
