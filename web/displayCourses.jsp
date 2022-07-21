<%@page import="model.DAOLesson"%>
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
            Vector<Courses> vector = (Vector<Courses>) request.getAttribute("displayAllCourses");
            String flow = request.getAttribute("flow") != null ? (String) request.getAttribute("flow") : null;
            String sortBy = request.getAttribute("sortBy") != null ? (String) request.getAttribute("sortBy") : null;
            String categorySelected = request.getAttribute("categorySelected") != null ? (String) request.getAttribute("categorySelected") : null;
            String directLink = request.getAttribute("directLink") != null ? (String) request.getAttribute("directLink") : null;
            String stringNumberOfPage = (String) request.getAttribute("numberOfPage");
            int numberOfPage = Integer.parseInt(stringNumberOfPage);
            Vector<Courses> vectorUserCourses = (Vector<Courses>) request.getAttribute("vectorUserCourses");

        %>
    </head>

    <body>
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->


        <!-- Navbar Start -->
        <%@ include file="component/navbar.jsp" %>
        <%DAOLesson dao1 = new DAOLesson();%>
        <!-- Navbar End -->
        <!-- Courses Start -->
        <div class="container-xxl py-4">
            <div class="container">
                <div class="text-center wow fadeInDown" data-wow-delay="0.1s">
                    <h4 class="section-title bg-white text-center text-primary px-3">Courses</h4>
                </div>
                <div class="row">
                    <div class="col-2 border">
                        <div class="list-group mt-2" >

                            <% for (Category ca : vectorCategory) {%>
                            <a href="Category?category=<%=ca.getCategoryID()%>" 
                               class="py-3 list-group-item list-group-item-action <%=(String.valueOf(ca.getCategoryID()).equals(categorySelected) ? "active" : "")%>"><%=ca.getCategoryName()%></a>
                            <%}%>  


                        </div>
                    </div>
                    <div class="border col-10">
                        <%if (categorySelected == null) {%>
                        <form action="Courses" method="get" class=" my-3 wow fadeInDown row fs-5 fw-bolder"  data-wow-delay="0.2s">   
                            <input hidden name="courses" value="sortCourses">
                            <div class="border col-2 text-center py-2 ms-2 fs-5 fw-bolder">Sort By : </div>
                            <select name="sortBy" class="form-select form-select-md col-3 mx-1 py-2 fs-5 fw-bolder" aria-label=".form-select-lg example" style="width: 15%">
                                <option value="Name" <%=(sortBy != null ? (sortBy.equalsIgnoreCase("Name") ? "selected" : "") : "")%> >Title</option>
                                <option value="Price"<%=(sortBy != null ? (sortBy.equalsIgnoreCase("Price") ? "selected" : "") : "")%> >Price</option>
                            </select>
                            <select name="flow" class="form-select form-select-md col-3 mx-1 py-2 fs-5 fw-bolder" aria-label=".form-select-lg example" style="width: 15%">
                                <option value="Asc" <%=(flow != null ? (flow.equalsIgnoreCase("Asc") ? "selected" : "") : "")%> >Ascending</option>
                                <option value="Desc" <%=(flow != null ? (flow.equalsIgnoreCase("Desc") ? "selected" : "") : "")%>  >Descending</option>
                            </select>
                            <input class="mx-2 btn btn-primary border border-primary col-1 py-2 fs-5 fw-bolder" type="submit" value="Sort">
                        </form>
                        <%}%>



                        <div class="row g-4 justify-content-center">
                            <%int count10 = 0; %>
                            <% for (Courses course : vector) {
                                    count10++;
                                    boolean isExist = false;%>
                            <div class="col-lg-4 col-md-6 wow fadeInDown" data-wow-delay="0.1s">
                                <div class="course-item bg-light">
                                    <div class="position-relative overflow-hidden">
                                        <div style="height: 240px">
                                            <img class="img-fluid w-100" src="<%=course.getImage()%>" alt="">
                                        </div>
                                        <div class="w-100 d-flex justify-content-center position-absolute bottom-0 start-0 mb-4">
                                            <a href="Courses?courses=detailCourse&courseID=<%=course.getCourseID()%>" class="flex-shrink-0 btn btn-sm btn-primary px-3 border-end" 
                                               style="border-radius: 30px <%=(dao1.CheckLessonExistInCourse(course.getCourseID()) == false ? "" : "0 0")%> 30px;">Read More</a>
                                            <%            if (vectorUserCourses != null) {
                                                    for (Courses userCourse : vectorUserCourses) {
                                                        System.out.println(userCourse);
                                                        if (userCourse.getCourseID() == course.getCourseID()) {
                                                            isExist = true;
                                                            break;
                                                        }

                                                    }
                                                }
                                            %>
                                            <% if (isExist && dao1.CheckLessonExistInCourse(course.getCourseID())) {%>

                                            <form action="ControllerLesson" method="POST">
                                                <input type="hidden" name="courseID" value="<%=course.getCourseID()%>">
                                                <input type="submit" class="flex-shrink-0 btn btn-sm btn-primary px-3" style="border-radius: 0 30px 30px 0;" value="Learn Course">
                                            </form>
                                            <%} else if (dao1.CheckLessonExistInCourse(course.getCourseID())) {%>
                                            <a href="CheckOrder?courses=displayCourses&courseID=<%=course.getCourseID()%>" class="flex-shrink-0 btn btn-sm btn-primary px-3" 
                                               style="border-radius: 0 30px 30px 0;">Register Course</a>
                                            <%}%>
                                        </div>
                                    </div>
                                    <div class="text-center p-4 pb-0">
                                        <div class="mb-1">

                                        </div>
                                        <h5 class="mb-2"><%= course.getCourseName().length() <= 24 ? course.getCourseName() : course.getCourseName().substring(0, 24) + "..."%></h5>
                                        <h3 class="mb-2">$<%=course.getPrice()%></h3>

                                    </div>
                                    <div class="d-flex border-top">
                                        <small class="flex-fill text-center border-end py-2"><i class="fa fa-user-tie text-primary me-2"></i><%=course.getTeacherName()%></small>
                                    </div>
                                </div>
                            </div>
                            <%}%>
                            <%
                                String prePageSelected = "1", nextPageSelected = "2";
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

                            %>
                            <%if (count10 != 0) {%>
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item <%=(Integer.parseInt(pageSelected) == 1 ? "disabled" : "")%>"   ><a class="page-link" href="<%=directLink%><%=preNextDirectLink%>page=<%=prePageSelected%>">Previous</a></li>
                                        <%for (int idx = 1; idx <= numberOfPage; idx++) {%>                                    
                                    <li class="page-item"><a class="page-link" href="<%=directLink%><%=firstCharInDirectLink%>page=<%=idx%>"><%=idx%></a></li>                             
                                        <%}%>
                                    <li class="page-item <%=(Integer.parseInt(pageSelected) == numberOfPage ? "disabled" : "")%>"><a class="page-link" href="<%=directLink%><%=preNextDirectLink%>page=<%=nextPageSelected%>">Next</a></li>
                                </ul>
                            </nav>
                            <%}%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Courses End -->


        <!-- Testimonial Start -->
        <%--<%@include file="component/testimonial.jsp" %>--%>
        <!-- Testimonial End -->


        <!-- Footer Start -->
        <%@include file="component/footer.jsp" %>
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