<style>
  .styled-table {
      border-collapse: collapse;
      margin: 20px auto;
      font-size: 1em;
      font-family: "Verdana", sans-serif;
      min-width: 450px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
  }
  
  .styled-table thead tr {
      background-color: #2e6da4;
      color: #ffffff;
      text-align: center;
  }
  
  .styled-table th,
  .styled-table td {
      padding: 10px 12px;
  }
  
  .styled-table tbody tr {
      border-bottom: 1px solid #bcbcbc;
  }
  
  .styled-table tbody tr:nth-of-type(even) {
      background-color: #f1f1f1;
  }
  
  .styled-table tbody tr:nth-of-type(odd) {
      background-color: #e7f3f9;
  }
  
  .styled-table tbody tr:last-of-type {
      border-bottom: 3px solid #e7f3f9;
  }
  
  .styled-table tbody tr.active-row {
      font-weight: bold;
      color: #0275d8;
  }
  
  body {
      margin: 0;
      font-family: "Helvetica Neue", Arial, sans-serif;
      background-color: #f4eceb;
  }
  
  .example { background-color: #5a3d8f; padding: 10px; } 
  
  .topnav {
      overflow: hidden;
      background-color: #17bebb;
      padding: 10px 0;
  }
  
  .topnav a {
      float: left;
      color: #ffffff;
      text-align: center;
      padding: 12px 14px;
      text-decoration: none;
      font-size: 16px;
      transition: background-color 0.3s, color 0.3s;
  }
  
  .topnav a:hover {
      background-color: #ff4081;
      color: white;
  }
  
  .topnav a.active {
      background-color: #34495e;
      color: white;
  }
  </style>
  
  <H1 class="example" align="center">
      <font class="example" color="#33ccff">
          <div>
              <a href="index.jsp">
              <img style="max-width: 250px; height: auto;" src="img/fit.avif"></a>
          </div>
          <div class="topnav">
              <a class="active" href="index.jsp">Home</a>
              <a href="createAccount.jsp">Register</a>
              <a href="login.jsp">Login</a>
              <a href="EditAccount.jsp">Edit My Info</a>
              <a href="listprod.jsp">Shop</a>
              <a href="listprodForReview.jsp">Review Products</a>
              <a href="listorder.jsp">Orders</a>
              <a href="customer.jsp">Customer Info</a>
              <a href="admin.jsp">Admin</a>
              <a href="logout.jsp">Log Out</a>
              <a href="Car.jsp">All Cars</a>
          </div>
      </font>
  </H1>  
  
  <%
  String userName = (String) session.getAttribute("authenticatedUser");
  
  if(userName != null) {
      out.print("<h3 align=\"center\">Signed in as: " + userName + "</h3>");
  }
  %>    
  <hr>
  