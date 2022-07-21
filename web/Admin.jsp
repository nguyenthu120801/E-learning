
<%@page import="entity.Account"%>
<%@page import="model.DAOAccount"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>eLEARNING</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
    </head>

    <body>
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <%
            // get attribute
            Object name = request.getAttribute("name");
        %>     
        <!-- Spinner End -->
        <nav class="navbar navbar-dark bg-primary">
            <div class="container-fluid">
                <a class="navbar-brand"><i class="bi bi-person-circle"></i> WELCOME TO ADMIN</a>
                <form class="d-flex" action="Admin">
                    <input type="hidden" name="service" value="SearchAccount">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name="name" value ="<%=name == null ? "" : name%>" required>                   
                    <button class="btn btn-outline-success" type="submit" >Search</button>
                </form>
            </div>
        </nav>

        <section style="margin-top: 50px">
            <div class="row vh-100" >
                <div class="col-lg-3">
                    <ul class="list-group">
                        <li class="list-group-item list-group-item-info"><a href="Admin">Account Management</a></li>
                        <li class="list-group-item list-group-item-info"><a href="Admin?service=AddAccount">Create Account</a></li>
                    </ul>
                    <%
                        DAOAccount daoAccount = new DAOAccount();
                        // get attribute
                        Object value = request.getAttribute("message");
                        String color = "";
                    %>
                    <% // if set attribute
                        if (value != null) {
                            String message = value.toString();
                            // if message contain remove or not found
                            if (message.equals("not found") || message.contains("remove")) {
                                color = "red";
                            } else {
                                color = "green";
                            }
                    %>
                    <p style="color:<%=color%>;text-align: center"><%=message%></p>
                    <%}%>
                    <br>
                    <a href="Logout" class="btn btn-lg btn-primary position-fixed bottom-0 start-0 ">Logout <i class="bi bi-box-arrow-right"></i></a>
                </div>

                <div class="col-lg-9">
                    <table class="table table-info">
                        <thead>
                            <tr>
                                <th scope="col">STT</th>
                                <th scope="col">Username</th>
                                <th scope="col">RoleName</th>
                                <th scope="col">Edit| Remove</th>
                                <th scope="col">View Detail</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%  // get attribute
                                Object valueList = request.getAttribute("list");
                                int STT = 0;
                                // if set value for list
                                if (valueList != null) {
                                    List<Account> list = (List<Account>) valueList;
                                    // loop for traverse through list
                                    for (Account account : list) {
                                        if (!account.getRoleName().equals("Admin")) {
                                            STT++;
                            %>
                            <tr>
                                <th scope="row"><%=STT%></th>
                                <td><%=account.getUsername()%></td>
                                <td><%=account.getRoleName()%></td>
                                <td>
                                    <%// if role is student
                                        if (account.getRoleName().equals("Student")) {
                                    %>
                                    <a href="Admin?service=EditAccount&STT=<%=STT%>&username=<%=account.getUsername()%>&role=<%=account.getRoleName()%>">Edit</a>| 
                                    <%}%>
                                    <a href="Admin?service=RemoveAccount&username=<%=account.getUsername()%>&role=<%=account.getRoleName()%>" onclick="return confirm('Are you sure you want to delete?')">Remove</a>
                                </td>
                                <td><a href="Admin?service=Profile&username=<%=account.getUsername()%>&STT=<%=STT%>">View</a></td>
                            </tr>
                            <%}%> 
                            <%}%>
                            <%}%>
                        </tbody>
                    </table>

                </div>
            </div>
        </section>

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>


        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>
    </body>

</html>