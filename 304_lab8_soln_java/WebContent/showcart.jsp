<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Your Shopping Cart</title>
</head>
<body>

<%
    int userId = (int) session.getAttribute("userId");
    if (userId == -1) {
        out.println("<h1>You need to log in to view your cart.</h1>");
    } else {
        try {
            getConnection();
            // Fetch the cart contents from the database
            String query = "SELECT * FROM shopping_cart WHERE user_id = ?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (!rs.next()) {
                out.println("<h1>Your shopping cart is empty!</h1>");
            } else {
                out.println("<h1>Your Shopping Cart</h1>");
                out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
                
                double total = 0;
                do {
                    String productId = rs.getString("product_id");
                    int quantity = rs.getInt("quantity");
                    double price = rs.getDouble("price");

                    // Fetch product details from the products table if needed (e.g., product name)
                    String productQuery = "SELECT name FROM products WHERE product_id = ?";
                    PreparedStatement productStmt = con.prepareStatement(productQuery);
                    productStmt.setString(1, productId);
                    ResultSet productRs = productStmt.executeQuery();

                    if (productRs.next()) {
                        String productName = productRs.getString("name");
                        double subtotal = price * quantity;
                        total += subtotal;

                        out.print("<tr>");
                        out.print("<td>" + productId + "</td>");
                        out.print("<td>" + productName + "</td>");
                        out.print("<td>" + quantity + "</td>");
                        out.print("<td>" + price + "</td>");
                        out.print("<td>" + subtotal + "</td>");
                        out.print("</tr>");
                    }
                } while (rs.next());
                
                out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td><td>" + total + "</td></tr>");
                out.println("</table>");
                out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            con.close();
        }
    }
%>

<h2><a href="listprod.jsp">Continue Shopping</a></h2>

</body>
</html>
