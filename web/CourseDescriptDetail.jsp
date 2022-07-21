<%@page import="model.DAOLesson"%>
<%@page import="entity.Lesson"%>
<%@page import="java.util.Vector"%>
<%@page import="entity.Courses"%>
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
        <link
            href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap"
            rel="stylesheet">

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
            Vector<Lesson> vectorLesson = (Vector<Lesson>) request.getAttribute("vectorLesson");
            Vector<Courses> vectorCourse = (Vector<Courses>) request.getAttribute("vectorCourse");
            String courseDescript = null;
            Vector<Courses> vectorID = (Vector<Courses>) request.getAttribute("vectorID");
            Vector<Courses> vectorUserCourses = (Vector<Courses>) request.getAttribute("vectorUserCourses");
            boolean isExist = false;
        %>
    </head>

    <body>
        <!-- Spinner Start -->
        <div id="spinner"
             class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->


        <!-- Navbar Start -->
        <%@ include file="component/navbar.jsp" %>

        <!-- Navbar End -->

        <%DAOLesson dao1 = new DAOLesson();%>
        <div class="container-fluid py-5 wow fadeInDown row" data-wow-delay="0.1s">

            <div class="border col-4">
                <div class="row g-4 justify-content-center">      
                    <%
                        for (Courses course : vectorCourse) {

                            courseDescript = course.getDescription();
                        }%>

                    <% for (Courses course : vectorID) {%>
                    <div class="col-12 wow fadeInDown" data-wow-delay="0.1s">
                        <div class="course-item bg-light">
                            <div class="position-relative overflow-hidden">
                                <div style="height: 240px">
                                    <img style="width: 100%" class="img-fluid" src="<%=course.getImage()%>" alt="">
                                </div>
                                <div class="w-100 d-flex justify-content-center position-absolute bottom-0 start-0 mb-4">
                                    <% if (vectorUserCourses != null) {
                                            for (Courses userCourse : vectorUserCourses) {
                                                if (userCourse.getCourseID() == course.getCourseID()) {
                                                    isExist = true;
                                                    break;
                                                }
                                            }
                                        }
                                    %>
                                    <% if (isExist && dao1.CheckLessonExistInCourse(course.getCourseID())) {%>
                                    <a href="ControllerLesson?courseID=<%=course.getCourseID()%>" class="p-3 flex-shrink-0 btn btn-sm btn-primary px-3" style="border-radius: 30px 30px 30px 30px;">Learn Course</a>
                                    <%} else if (dao1.CheckLessonExistInCourse(course.getCourseID())) {
                                        if (roleName == null || (roleName != null && !roleName.equalsIgnoreCase("Teacher")) || (roleName != null && roleName.equalsIgnoreCase("Student"))) {%>
                                    <a href="CheckOrder?courses=displayCourses&courseID=<%=course.getCourseID()%>" class="p-3 flex-shrink-0 btn btn-sm btn-primary px-3" style="border-radius: 30px 30px 30px 30px;">Register Course</a>
                                    <%}
                                        }%>

                                </div>
                            </div>
                            <div class="text-center p-4 pb-0">
                                <div class="mb-1">

                                </div>
                                <h5 class="mb-2"><%=course.getCourseName()%></h5>
                                <h3 class="mb-2">$<%=course.getPrice()%></h3>

                            </div>
                            <div class="d-flex border-top">
                                <small class="flex-fill text-center border py-2"><i class="fa fa-user-tie text-primary me-2"></i><%=course.getTeacherName()%></small>
                            </div>
                        </div>
                    </div>
                    <%}%>
                </div>
                <div class="money-back text-center my-2">30-Day Money-Back Guarantee</div>
            </div>
            <div class="col-8 row">
                <div class="border row align-items-center " >
                    <b style="font-size: 20px">Course Content Description:</b>
                    <p><%=courseDescript%></p>
                </div>
                <div class="border row">
                    <div class="my-2">
                        <ol class="list-group list-group-numbered">
                            <% int count = 0;
                                for (Lesson les : vectorLesson) {
                                    count++;
                            %>
                            <li class="list-group-item list-group-item-action d-flex justify-content-between align-items-start">
                                <div class="ms-2 me-auto">
                                    <div class="fw-bold"><%=les.getLessonName()%></div>
                                </div>
                            </li>
                            <%}%>
                            <% if (count == 0) { %>

                            <h1 class="mb-4 justify-content-center text-primary"><i class="bi bi-exclamation-triangle display-1 text-primary"></i>This Course Is Under Development Process And Don't Have Any Courses Yet</h1>
                            <%}%>
                        </ol>
                    </div>
                </div>
            </div>
        </div>




        <!-- Footer Start -->
        <%@include file="component/footer.jsp" %>
        <!-- Footer End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>


        <!-- JavaScript Libraries -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
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