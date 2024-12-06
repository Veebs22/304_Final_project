<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Customer Sign Up</title>
</head>
<body>
    <h2>Customer Sign Up</h2>
    <form action="createAccount.jsp" method="post">
        <label for="firstName">First Name:</label><br>
        <input type="text" id="firstName" name="firstName" required><br><br>

        <label for="lastName">Last Name:</label><br>
        <input type="text" id="lastName" name="lastName" required><br><br>

        <label for="email">Email:</label><br>
        <input type="email" id="email" name="email" required><br><br>

        <label for="phoneNumber">Phone Number:</label><br>
        <input type="text" id="phoneNumber" name="phoneNumber" required><br><br>

        <label for="address">Address:</label><br>
        <input type="text" id="address" name="address" required><br><br>

        <label for="city">City:</label><br>
        <input type="text" id="city" name="city" required><br><br>

        <label for="state">State:</label><br>
        <input type="text" id="state" name="state" required><br><br>

        <label for="postalCode">Postal Code:</label><br>
        <input type="text" id="postalCode" name="postalCode" required><br><br>

        <label for="country">Country:</label><br>
        <input type="text" id="country" name="country" required><br><br>

        <label for="username">Username:</label><br>
        <input type="text" id="username" name="username" required><br><br>

        <label for="password">Password:</label><br>
        <input type="password" id="password" name="password" required><br><br>

        <input type="submit" value="Sign Up">
    </form>

<%
    // Check if the form is submitted
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String postalCode = request.getParameter("postalCode");
        String country = request.getParameter("country");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // Establish connection to the database
             getConnection();
			Statement stmt2 = con.createStatement(); 
			stmt2.execute("USE orders");

            // SQL query to insert customer data
            String query = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, email);
            stmt.setString(4, phoneNumber);
            stmt.setString(5, address);
            stmt.setString(6, city);
            stmt.setString(7, state);
            stmt.setString(8, postalCode);
            stmt.setString(9, country);
            stmt.setString(10, username);
            stmt.setString(11, password);

            // Execute update
            int result = stmt.executeUpdate();

            // Check if data was inserted successfully
            if (result > 0) {
%>
                <p>Sign-up successful!</p>
<%
            } else {
%>
                <p>There was an error during sign-up. Please try again.</p>
<%
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
