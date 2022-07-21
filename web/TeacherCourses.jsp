

<%@page import="entity.Courses"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
        <%
            Vector<Courses> vectorTeacherCourses = (Vector<Courses>) request.getAttribute("vectorTeacherCourses");
            String categorySelected = request.getAttribute("categorySelected") != null ? (String) request.getAttribute("categorySelected") : null;
            String directLink = request.getAttribute("directLink") != null ? (String) request.getAttribute("directLink") : null;
            String stringNumberOfPage = (String) request.getAttribute("numberOfPage");
            int numberOfPage = Integer.parseInt(stringNumberOfPage);
            String error = (String) request.getAttribute("error");

        %>
    </head>

    <body>
        <script>
            <%if (error != null) {%>
               window.onload = function () {
                   alert("${error}");

               }
            <%}%>
        </script>
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->
        <!-- Navbar Start -->
        <%@ include file="component/navbar.jsp" %>
        <!-- Navbar End -->
        <div class="container-xxl py-5">
            <div class="container">
                <div class="row g-4 justify-content-center">


                    <%                        String prePageSelected = "1", nextPageSelected = "2";
                        String pageSelected = request.getAttribute("pageSelected") != null ? (String) request.getAttribute("pageSelected") : null;
                        String preNextDirectLink = "?";
                        if (pageSelected != null) {
                            prePageSelected = String.valueOf((Integer.parseInt(pageSelected) - 1));
                            nextPageSelected = String.valueOf((Integer.parseInt(pageSelected) + 1));
                        }
                        char firstCharInDirectLink = '&';
                        if (directLink.equals("Courses")) {
                            firstCharInDirectLink = '?';
                        } else if (directLink.equals("Category")) {
                            firstCharInDirectLink = '&';
                        }
                        String controller = "Courses";
                        if (directLink.contains("?")) {
                            controller = "Category?category=" + categorySelected;
                            preNextDirectLink = "&";
                        }
                        int count = 0;
                    %>
                    <% for (Courses course : vectorTeacherCourses) {%>
                    <%count++;%>
                    <div class="col-lg-4 col-md-6 wow fadeInDown" data-wow-delay="0.3s">
                        <div class="course-item bg-light fw-medium">
                            <div class="position-relative overflow-hidden">
                                <div style="height: 240px">
                                    <img class="img-fluid w-100" src="<%=course.getImage()%>" alt="">

                                </div>
                                <div class="w-100 d-flex justify-content-center position-absolute bottom-0 start-0 mb-4">
                                    <a href="Courses?courses=detailCourse&courseID=<%=course.getCourseID()%>" class="flex-shrink-0 btn btn-sm btn-primary p-3 border-end" 
                                       style="border-radius: 30px 30px 30px 30px;">Read More</a>
                                </div>

                            </div>

                            <div class="text-center align-items-center p-2">
                                <div class="fs-5 "><%= course.getCourseName().length() <= 24 ? course.getCourseName() : course.getCourseName().substring(0, 24) + "..."%></div>
                                <h3 class="my-1">$<%=course.getPrice()%></h3>

                            </div>
                            <div class="container-fluid">
                                <div class=" text-center mt-1 row">
                                    <div class="col-4 bg-primary border">
                                        <form action="ManageLesson" method="POST">
                                            <input type="hidden" name="courseID" value="<%=course.getCourseID()%>">
                                            <input type="submit" value="View Lesson" class="btn btn-primary">
                                        </form>
                                    </div>
                                    <div class="col-4 bg-primary border">
                                        <a href="Teacher?teacher=updateCourse&courseID=<%=course.getCourseID()%>" class="  text-light">Update Course</a>             
                                    </div >
                                    <div class="col-4 bg-primary border">
                                        <a href="Teacher?teacher=deleteCourse&courseID=<%=course.getCourseID()%>"  class="  text-light " 
                                           onclick="return confirm('Are you sure you want to delete this course :\n<%=course.getCourseName()%>')">Delete Course</a> 

                                    </div>
                                </div>                       
                            </div>



                        </div>
                    </div>
                    <%}%>
                    <%if (count != 0) {%>
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-center">
                            <li class="page-item <%=(Integer.parseInt(pageSelected) == 1 ? "disabled" : "")%>"   ><a class="page-link" href="<%=directLink%><%=preNextDirectLink%>page=<%=prePageSelected%>">Previous</a></li>
                                <%for (int idx = 1; idx <= numberOfPage; idx++) {%>                                    
                            <li class="page-item"><a class="page-link" href="Teacher?teacher=teachingCourses&page=<%=idx%>"><%=idx%></a></li>                             
                                <%}%>
                            <li class="page-item <%=(Integer.parseInt(pageSelected) == numberOfPage ? "disabled" : "")%>"><a class="page-link" href="<%=directLink%><%=preNextDirectLink%>page=<%=nextPageSelected%>">Next</a></li>
                        </ul>
                    </nav>
                    <%}%>
                </div>
            </div>
        </div>




        <!-- Footer Start -->
        <%if (count == 0) {%>
        <section style="margin-top: 21.5%">
            <%@include file="component/footer.jsp" %>
        </section>
        <%} else {%>
        <%@include file="component/footer.jsp" %>
        <%}%>
        <!-- Footer End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>


        <!-- JavaScript Libraries -->

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
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
