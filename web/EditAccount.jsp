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
            // get parameter
            String name = request.getParameter("name");
            String search = request.getParameter("search");
        %>     
        <!-- Spinner End -->
        <nav class="navbar navbar-dark bg-primary">
            <div class="container-fluid">
                <a class="navbar-brand"><i class="bi bi-person-circle"></i> WELCOME TO ADMIN</a>
                <form class="d-flex">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name="name" required>
                    <button class="btn btn-outline-success" type="submit" name="search" value="Search">Search</button>
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
                    <a href="Logout" class="btn btn-lg btn-primary position-fixed bottom-0 start-0 ">Logout <i class="bi bi-box-arrow-right"></i></a>
                </div>
                <div class="col-lg-9">
                    <h2><a href="Admin">Back</a></h2>
                    <% // get attribute
                        Object valueMessage = request.getAttribute("message");
                        Object valueUsername = request.getAttribute("username");
                        Object valueRole = request.getAttribute("role");
                        Object valueSTT = request.getAttribute("STT");
                    %>
                    <% // if set attribute
                        if (valueMessage != null) {
                            String message = valueMessage.toString();
                    %>
                    <p style="color:green"><%=message%></p>
                    <%}%>
                    <div class="row">
                        <% // if set attribute
                            if (valueSTT != null) {
                                String STT = valueSTT.toString();
                        %>
                        <div class="col-md-4"><button class="btn btn-outline-success ">No : <%=STT%></button></div>
                        <%}%>
                        <% // if set attribute
                            if (valueUsername != null) {
                                String username = valueUsername.toString();
                        %>
                        <div class="col-md-8">
                            <button class="btn btn-outline-success  ">Username : <%=username%></button>
                        </div>
                        <%}%>
                    </div>
                    <br>
                    <br>
                    <br>    
                    <form action="Admin" method="POST">
                        <input type="hidden" name="service" value="EditAccount">
                        <% // if set attribute
                            if (valueRole != null) {
                                String role = valueRole.toString();
                        %>
                        <div class="text-primary">Current Role: <%=role%></div>
                        <input type="hidden" name="role" value="<%=role%>">
                        <%}%>
                        <% // if set attribute
                            if (valueUsername != null) {
                                String username = valueUsername.toString();
                        %>
                        <input type="hidden" name="username" value="<%=username%>">
                        <%}%>
                        <% // if set attribute
                            if (valueSTT != null) {
                                String STT = valueSTT.toString();
                        %>
                        <input type="hidden" name="STT" value="<%=STT%>">
                        <%}%>
                        <br>
                        <br>
                        <p >You want to change role name: </p>
                        <fieldset class="row">
                            <!-- ?o?n này ??c l?y roleName current sai -->
                            <% // if set attribute
                                if (valueRole != null) {
                                    String role = valueRole.toString();
                            %>
                            <legend class="col-form-label col-sm-2 pt-0">Role Name</legend>
                            <div class="col-sm-10">
                                <div class="form-check">
                                    <input type="radio" name="roleEdit" value="Student" <%=role.equals("Student") ? "checked" : ""%>>Student<br>

                                </div>
                                <div class="form-check">
                                    <input type="radio" name="roleEdit" value="Teacher" <%=role.equals("Teacher") ? "checked" : ""%>>Teacher<br>
                                </div>
                            </div>
                            <%}%>
                        </fieldset>
                        <button type="submit" class="btn btn-primary" onclick="return confirm('Are you sure you want to save your change?')">Save</button>
                    </form>
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