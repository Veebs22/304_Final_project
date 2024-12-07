<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="jdbc.jsp" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Edit Account</title>
</head>
<body>
    <h2>Edit Your Account</h2>

<%
    // Check if the user is logged in
   String username = (String) session.getAttribute("authenticatedUser");

    if (username == null) {
%>
        <p>You need to be logged in to edit your account details. Please <a href="login.jsp">log in</a>.</p>
<%
    } else {
        // If logged in, fetch user details from the database
        try {
            getConnection();
            Statement stmt = con.createStatement();
            stmt.execute("USE orders");
            String query = "SELECT firstName, lastName, email, phonenum, address, city, state, postalCode, country FROM customer WHERE userid = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                String email = rs.getString("email");
                String phoneNumber = rs.getString("phonenum");
                String address = rs.getString("address");
                String city = rs.getString("city");
                String state = rs.getString("state");
                String postalCode = rs.getString("postalCode");
                String country = rs.getString("country");
%>

    <form action="editAccount.jsp" method="post">
        <label for="firstName">First Name:</label><br>
        <input type="text" id="firstName" name="firstName" value="<%= firstName %>" required><br><br>

        <label for="lastName">Last Name:</label><br>
        <input type="text" id="lastName" name="lastName" value="<%= lastName %>" required><br><br>

        <label for="email">Email:</label><br>
        <input type="email" id="email" name="email" value="<%= email %>" required><br><br>

        <label for="phoneNumber">Phone Number:</label><br>
        <input type="text" id="phoneNumber" name="phoneNumber" value="<%= phoneNumber %>" required><br><br>

        <label for="address">Address:</label><br>
        <input type="text" id="address" name="address" value="<%= address %>" required><br><br>

        <label for="city">City:</label><br>
        <input type="text" id="city" name="city" value="<%= city %>" required><br><br>

        <label for="state">State:</label><br>
        <input type="text" id="state" name="state" value="<%= state %>" required><br><br>

        <label for="postalCode">Postal Code:</label><br>
        <input type="text" id="postalCode" name="postalCode" value="<%= postalCode %>" required><br><br>

        <label for="country">Country:</label><br>
        <input type="text" id="country" name="country" value="<%= country %>" required><br><br>

        <input type="submit" value="Update Account">
    </form>

<%
            } else {
                out.println("<p>User not found!</p>");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>There was an error fetching your data.</p>");
        }
    }

    // Handle form submission to update user information
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String updatedFirstName = request.getParameter("firstName");
        String updatedLastName = request.getParameter("lastName");
        String updatedEmail = request.getParameter("email");
        String updatedPhoneNumber = request.getParameter("phoneNumber");
        String updatedAddress = request.getParameter("address");
        String updatedCity = request.getParameter("city");
        String updatedState = request.getParameter("state");
        String updatedPostalCode = request.getParameter("postalCode");
        String updatedCountry = request.getParameter("country");

        // Debugging: print the parameters to the console (optional)
        System.out.println("Updated Info: " +
            "firstName=" + updatedFirstName +
            ", lastName=" + updatedLastName +
            ", email=" + updatedEmail +
            ", phoneNumber=" + updatedPhoneNumber +
            ", address=" + updatedAddress +
            ", city=" + updatedCity +
            ", state=" + updatedState +
            ", postalCode=" + updatedPostalCode +
            ", country=" + updatedCountry);

        try {
            getConnection();
            Statement stmt = con.createStatement();
            stmt.execute("USE orders");
            String updateQuery = "UPDATE customer SET firstName = ?, lastName = ?, email = ?, phonenum = ?, address = ?, city = ?, state = ?, postalCode = ?, country = ? WHERE userid = ?";
            PreparedStatement updateStmt = con.prepareStatement(updateQuery);
            updateStmt.setString(1, updatedFirstName);
            updateStmt.setString(2, updatedLastName);
            updateStmt.setString(3, updatedEmail);
            updateStmt.setString(4, updatedPhoneNumber);
            updateStmt.setString(5, updatedAddress);
            updateStmt.setString(6, updatedCity);
            updateStmt.setString(7, updatedState);
            updateStmt.setString(8, updatedPostalCode);
            updateStmt.setString(9, updatedCountry);
            updateStmt.setString(10, username);
            
            int result = updateStmt.executeUpdate();

            if (result > 0) {
                out.println("<p>Your account has been updated successfully! <a href="+"index.jsp>"+"return home?"+"</a>.</p>");
            } else {
                out.println("<p>There was an error updating your account. Please try again.</p>");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
%>

</body>
</html>
