<%@page import="entity.Student"%>
<%@page import="java.util.Vector"%>
<%@page import="entity.Courses"%>
<%@page import="entity.Courses"%>
<!doctype html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="autnehor" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
        <meta name="gerator" content="Jekyll v3.8.5">
        <title>eLearning</title>

        <link rel="canonical" href="https://getbootstrap.com/docs/4.3/examples/checkout/">

        <!-- Bootstrap core CSS -->
        <link href="/docs/4.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <link href="form-validation.css" rel="stylesheet">
        <%
            Vector<Courses> vector = (Vector<Courses>) request.getAttribute("displayCourses");
            Vector<Student> vector1 = (Vector<Student>) request.getAttribute("stu");
        %>
    </head>
    <body class="bg-light">
        <%@ include file="component/navbar.jsp" %>

        <div class="container">
            <div class="py-4 text-center">
                <!--<img class="d-block mx-auto mb-4" src="https://getbootstrap.com/docs/4.3/assets/brand/bootstrap-solid.svg" alt="" width="72" height="72">-->
            </div>

            <div class="row">
                <% for (Courses course : vector) {%>
                <div class="col-md-6 order-md-2 mb-5">
                    <h4 class="d-flex justify-content-between align-items-center mb-4">
                        <span class="text-muted">Your cart</span>
                        <span class="badge badge-secondary badge-pill">3</span>
                    </h4>
                    <ul class="list-group mb-6">
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div style="height: 270px">
                                <img class="img-fluid" src="<%=course.getImage()%>" alt="" style="width:350px; height: 270px">
                            </div>
                            <div class="mx-3">
                                <h6 class="my-0">Product name</h6>
                                <small class="text-muted"><%=course.getCourseName()%></small>
                            </div>
                            <div style="margin-bottom: 150px">

                                <a href="RemovePayMent?courses=Remove&courseID=<%=course.getCourseID()%>"
                                   class="nav-item nav-link active" onclick="return confirm('Are you sure you want to delete?')" 
                                   style="" xpath="1"><button class="nav-item nav-link active">Cancel</button></a>

                        </li>
                        <div class="nmv">
                            <li class="list-group-item d-flex justify-content-between lh-condensed">
                                <span style="color: black ">Price: (USD)</span>
                                <strong>$<%=course.getPrice()%></strong>
                                <%}%>
                            </li>
                        </div>
                    </ul>
                    <style>
                        .nmv
                        {
                            margin-top: 20px;
                        }


                    </style>

                </div>
                <% for (Student a : vector1) {%>
                <div class="col-md-6 order-md-1">
                    <h4 class="mb-2">Billing address</h4>
                    <form class="needs-validation" novalidate action="" method="post">
                        <input type="hidden" name="do" value="insert">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="firstName">FullName</label>
                                <input type="text" class="form-control" id="firstName" readonly placeholder="<%=a.getFullName()%>" value="<%=a.getFullName()%>" required name="firstname">
                                <div class="invalid-feedback">
                                    Valid first name is required.
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="lastName">Gender</label>
                                <input type="text" class="form-control" id="lastName" readonly placeholder="" value="<%=a.getGender()%>" required name="lastname">
                                <div class="invalid-feedback">
                                    Valid last name is required.
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="username">Username</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                </div>
                                <input type="text" class="form-control" id="username" readonly placeholder="Username" value="<%=a.getUsername()%>" required name="username">
                                <div class="invalid-feedback" style="width: 100%;">
                                    Your username is required.
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="email">Email <span class="text-muted">(Optional)</span></label>
                            <input type="email" class="form-control" readonly id="email" value="<%=a.getEmail()%>" placeholder="you@example.com" name="email">
                            <div class="invalid-feedback">
                                Please enter a valid email address for shipping updates.
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="address">Address</label>
                            <input type="text" class="form-control" id="address" readonly value="<%=a.getAddress()%>" placeholder="1234 Main St" required name="address">
                            <div class="invalid-feedback">
                                Please enter your shipping address.
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="username">Phone</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                </div>
                                <input type="text" class="form-control" id="username" readonly value="<%=a.getPhone()%>" placeholder="Phone" required name="phone">
                                <div class="invalid-feedback" style="width: 100%;">
                                    Your username is required.
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="username">Image</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                </div>
                                <input type="text" class="form-control" id="username" readonly value="<%=a.getImage()%>" placeholder="link" required name="phone">
                                <div class="invalid-feedback" style="width: 100%;">
                                    Your username is required.
                                </div>
                            </div>
                        </div>
                        <%}%>
                        <form>
                            <hr class="mb-4">
                            <c:if test="${sessionScope.n==1}">
                                <div>

                                    <button>
                                        <a href="MyCourse" class="bv">
                                            Enroll Course
                                        </a> 
                                    </button>

                                </div>
                            </c:if>
                            <hr class="mb-4">
                        </form>
                        <div class="er">
                            <p>${requestScope.mess}</p>
                        </div>
                        <c:if test="${sessionScope.n!=1}">
                            <% for (Courses course : vector) {%>
                            <a href="CheckOrder?courses=checkouts&courseID=<%=course.getCourseID()%>" class="nav-item nav-link active btn btn-primary" onclick="return confirm('Are you sure you want to continue!!!')" style="" xpath="1">Continue Checkout</a>
                            <%}%>

                        </c:if>
                    </form>
                </div>
            </div>
        </div>
        <style>
            .er{
                color: green;
            }
        </style>
        <style>
            .bv{
                font-size: 25px;
                margin-auto: 5px;

            }
        </style>           

        <style>
            .abc{
                background-color: #06BBCC;
                color: white;
                margin-left:180px;
                size: 250px;
                padding: 24px 48px;


            }

        </style>

        <div class="container-fluid bg-dark text-light footer pt-5 mt-5 wow fadeIn" data-wow-delay="0.1s">
            <div class="container py-5">
                <div class="row g-5">
                    <div class="col-lg-3 col-md-6">
                        <h4 class="text-white mb-3">Quick Link</h4>
                        <a class="btn btn-link" href="">About Us</a>
                        <a class="btn btn-link" href="">Contact Us</a>
                        <a class="btn btn-link" href="">Privacy Policy</a>
                        <a class="btn btn-link" href="">Terms & Condition</a>
                        <a class="btn btn-link" href="">FAQs & Help</a>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h4 class="text-white mb-3">Contact</h4>
                        <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>123 Street, New York, USA</p>
                        <p class="mb-2"><i class="fa fa-phone-alt me-3"></i>+012 345 67890</p>
                        <p class="mb-2"><i class="fa fa-envelope me-3"></i>info@example.com</p>
                        <div class="d-flex pt-2">
                            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-twitter"></i></a>
                            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-facebook-f"></i></a>
                            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-youtube"></i></a>
                            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h4 class="text-white mb-3">Gallery</h4>
                        <div class="row g-2 pt-2">
                            <div class="col-4">
                                <img class="img-fluid bg-light p-1" src="img/course-1.jpg" alt="">
                            </div>
                            <div class="col-4">
                                <img class="img-fluid bg-light p-1" src="img/course-2.jpg" alt="">
                            </div>
                            <div class="col-4">
                                <img class="img-fluid bg-light p-1" src="img/course-3.jpg" alt="">
                            </div>
                            <div class="col-4">
                                <img class="img-fluid bg-light p-1" src="img/course-2.jpg" alt="">
                            </div>
                            <div class="col-4">
                                <img class="img-fluid bg-light p-1" src="img/course-3.jpg" alt="">
                            </div>
                            <div class="col-4">
                                <img class="img-fluid bg-light p-1" src="img/course-1.jpg" alt="">
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h4 class="text-white mb-3">Newsletter</h4>
                        <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
                        <div class="position-relative mx-auto" style="max-width: 400px;">
                            <input class="form-control border-0 w-100 py-3 ps-4 pe-5" type="text" placeholder="Your email">
                            <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">SignUp</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="copyright">
                    <div class="row">
                        <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                            &copy; <a class="border-bottom" href="#">Your Site Name</a>, All Right Reserved.

                            <!--/*** This template is free as long as you keep the footer author?s credit link/attribution link/backlink. If you'd like to use the template without the footer author?s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                            Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a><br><br>
                            Distributed By <a class="border-bottom" href="https://themewagon.com">ThemeWagon</a>
                        </div>
                        <div class="col-md-6 text-center text-md-end">
                            <div class="footer-menu">
                                <a href="">Home</a>
                                <a href="">Cookies</a>
                                <a href="">Help</a>
                                <a href="">FQAs</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script>window.jQuery || document.write('<script src="/docs/4.3/assets/js/vendor/jquery-slim.min.js"><\/script>')</script><script src="https://getbootstrap.com/docs/4.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o" crossorigin="anonymous"></script>
        <script src="https://getbootstrap.com/docs/4.3/examples/checkout/form-validation.js"></script></body>
</html>

