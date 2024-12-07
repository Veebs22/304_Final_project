<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="jdbc.jsp" %>
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	// No products currently in list.  Create a list.
	productList = new HashMap<String, ArrayList<Object>>();
}

// Add new product selected
// Get product information
String userName = (String) session.getAttribute("authenticatedUser");

int userid = -1;
try {
    getConnection();
    	Statement stmt2 = con.createStatement();
		 stmt2.execute("USE orders");
    String sql = "SELECT * FROM customer WHERE userid ="+userName+"";
  	Statement stmt = con.createStatement();
	ResultSet rst = stmt.executeQuery(sql);
	if(rst.next()){
		userid = rst.getInt(1);
	}
    con.close();
} catch (Exception e) {
    e.printStackTrace();
}
session.setAttribute("userId",userid);
String id = request.getParameter("id");
String name = request.getParameter("name");
String price = request.getParameter("price");
Integer quantity = new Integer(1);

// Store product information in an ArrayList
ArrayList<Object> product = new ArrayList<Object>();
product.add(id);
product.add(name);
product.add(price);
product.add(quantity);

// Update quantity if add same item to order again
if (productList.containsKey(id))
{	product = (ArrayList<Object>) productList.get(id);
	int curAmount = ((Integer) product.get(3)).intValue();
	product.set(3, new Integer(curAmount+1));
}
else
	productList.put(id,product);

session.setAttribute("productList", productList);

// Store the cart item in the database
try {
    getConnection();
    Statement stmt3 = con.createStatement();
		 stmt3.execute("USE orders");
    String insertQuery = "INSERT INTO shoppingCart (userid, product_id, productName, quantity, price) VALUES (?, ?, ?, ?, ? )";
    PreparedStatement stmt = con.prepareStatement(insertQuery);
    stmt.setInt(1, userid);
	stmt.setString(2, id);
    stmt.setString(3, name);
    stmt.setDouble(4, Double.parseDouble(price));
    stmt.setInt(5, quantity);
    stmt.executeUpdate();
    con.close();
} catch (Exception e) {
    e.printStackTrace();
}

%>
<jsp:forward page="showcart.jsp" />