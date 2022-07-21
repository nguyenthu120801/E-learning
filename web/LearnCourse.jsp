<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="model.DAOCategory"%>
<%@page import="entity.Category"%>
<%@page import="java.util.Vector"%>
<%@page import="model.DAOTeacher"%>
<%@page import="entity.Teacher"%>
<%@page import="model.DAOStudent"%>
<%@page import="entity.Student"%>
<%@page import="model.DAOAccount"%>
<%@page import="entity.Account"%>
<%-- 
    Document   : demo
    Created on : May 26, 2022, 6:27:45 PM
    Author     : chuqu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eLearning</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->

        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">

        <script src="https://kit.fontawesome.com/42147adfb1.js" crossorigin="anonymous"></script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>

        <script>
            var vid = document.getElementById("myVideo");
            window.onload = function () {
                vid.autoplay = true;
                vid.load();
            }
        </script>

        <style>

            #myVideo {
                width: 80%;
                height: 710px;
                margin-left: 10%;

            }
            .col-md-3{
                background-color: #EEEEEE; 

                overflow-y: scroll; 
                height: 820px
            }
            .col-md-9{
                background-color: #f0fbfc; 

            }
            .col-md-9 h3 {
                text-align: center;
                margin-top: 2%
            }
            #lesson {
                background-color: #06BBCC;
                color: white; text-decoration: none; 
                cursor: pointer
            }
            .footer{
                position: fixed;
                bottom: 0;
                left: 0
            }
        </style>
        <!-- Navbar Start -->
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%
            DAOCategory daoCategory = new DAOCategory();
            Vector<Category> vectorCategory = daoCategory.getAllCategory();
            String roleName = session.getAttribute("account") != null ? ((Account) session.getAttribute("account")).getRoleName() : null;

        %>

        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <nav class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">
            <a href="Home" class="navbar-brand d-flex align-items-center px-4 px-lg-5">
                <h2 class="m-0 text-info"><i class="fa fa-book me-3"></i>eLEARNING</h2>
            </a>
            <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav ms-auto p-4 p-lg-0">
                    <a href="Home" class="nav-item nav-link">Home</a>
                    <a href="about.jsp" class="nav-item nav-link">About</a>
                    <a href="Courses?courses=addCourse" class="nav-item nav-link <%=(roleName != null ? (roleName.equals("Teacher") ? "" : "d-none") : "d-none")%>">Create Course</a>
                    <a href="Courses" class="nav-item nav-link">Courses</a>

                </div>   
            </div>
            <% // get attribute
                Object value = session.getAttribute("account");
                String image = "https://i.pinimg.com/564x/31/ec/2c/31ec2ce212492e600b8de27f38846ed7.jpg";
                // if  login
                Teacher teacher = null;
                if (value != null) {
                    Account account = (Account) value;
                    String username = account.getUsername();
                    String role = new DAOAccount().getRoleName(username);
                    // if student
                    if (role.equals("Student")) {
                        Student student = new DAOStudent().getProfile(username);
                        image = student.getImage();
                        // if teacher
                    } else if (role.equals("Teacher")) {
                        teacher = new DAOTeacher().getTeacherInfoByUsername(username);
                        image = teacher.getImage();
                    }
                }
            %>
            <c:choose>
                <c:when test="${sessionScope.account != null}">
                    <div class="nav-item dropdown">
                        <a href="#" class="btn btn-info py-4 px-lg-5"><img src="<%=image%>" alt="Avatar" class="avatar">  ${sessionScope.account.username}</a>
                        <div class="dropdown-menu fade-down m-0">
                            <a href="ProfileController" class="dropdown-item">Profile</a>
                            <a href="MyCourse" class="dropdown-item <%=(roleName != null ? (roleName.equals("Student") ? "" : "d-none") : "")%>">My Course</a>
                            <a href="Teacher?teacher=teachingCourses" class="dropdown-item <%=(roleName != null ? (roleName.equals("Teacher") ? "" : "d-none") : "")%>">My Teaching Course</a>
                            <a href="Logout" class="dropdown-item">Log Out <i class="bi bi-box-arrow-right"></i></a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="login.jsp" class="btn btn-info py-4 px-lg-5 d-none d-lg-block">Join Now<i class="fa fa-arrow-right ms-3"></i></a>
                    </c:otherwise>
                </c:choose>

        </div>
    </nav>


    <!-- Navbar End -->


    <div class="container-fluid" style="height: 715px">
        <div class="row">
            <div class="col-md-3">
                <h3 style="margin-top: 1%; margin-bottom: 1%"> <a class="text-info" style="text-decoration: none" href="MyCourse"> <i class="bi bi-arrow-left"></i> Back </a></h3>
                <h3>COURSE CONTENT</h3>
                <div>
                    <%int videoNumber = 0;%>
                    <%int pdfNumber = 0;%>
                    <!--<button ><a href="ControllerLesson?s=ManageLesson&courseID=${courseID}">Manage Lesson</a></button>-->
                    <!--List Lesson in course -->
                    <c:forEach var="l" items="${lesson}">
                        <div class="list-group" style="margin: 15px 0">

                            <div class="list-group-item list-group-item-info" style="background-color: #06BBCC">
                                <div class="row">
                                    <!--Control card have same target and false is close -->
                                    <a id="lesson" data-bs-toggle="collapse" data-bs-target="#collapseExample${l.lessonNo}" aria-controls="CollapseExample${l.lessonNo}">
                                        <i class="bi bi-plus-circle-fill" style="margin-right: 3%"></i>${l.lessonNo}. ${l.lessonName}  
                                    </a>

                                </div>
                            </div>
                        </div>
                        <c:choose>
                            <c:when test="${l.lessonID == lID}">
                                <div class="list-group collapse multi-collapse show" id="collapseExample${l.lessonNo}">
                                    <c:forEach var="v" items="${vectorVideo}">

                                        <c:if test="${l.lessonID == v.lessonID}">
                                            <%videoNumber++;%>
                                            <c:choose>
                                                <c:when test="${v.videoID == vID}">
                                                    <div class="list-group-item list-group-item-primary">
                                                        <div class="row">
                                                            <a href="ControllerVideo?videoID=${v.videoID}"  style="text-decoration: none; color: black">
                                                                <i class="bi bi-play-circle" style="color: red; margin-right: 2%"></i>Video <%=videoNumber%>. ${v.videoName} 
                                                            </a>
                                                        </div>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="list-group-item list-group-item-action">
                                                        <div class="row">
                                                            <a href="ControllerVideo?videoID=${v.videoID}"  style="text-decoration: none; color: black">
                                                                <i class="bi bi-play-circle" style="color: red; margin-right: 2%"></i>Video <%=videoNumber%>. ${v.videoName} 
                                                            </a>
                                                        </div>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>


                                        </c:if>
                                    </c:forEach>
                                    <c:forEach var="p" items="${vectorPDF}">
                                        <c:if test="${l.lessonID == p.lessonID}">
                                            <%pdfNumber++;%>
                                            <c:choose>
                                                <c:when test="${p.pdfID == pID}">
                                                    <div class="list-group-item list-group-item-primary">
                                                        <a href="ControllerPDF?pdfID=${p.pdfID}" style="text-decoration: none; color: black"> 
                                                            <i class="bi bi-book" style="color: green; margin-right: 2%"></i>PDF <%=pdfNumber%>. ${p.pdfName}
                                                        </a>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="list-group-item list-group-item-action">
                                                        <a href="ControllerPDF?pdfID=${p.pdfID}" style="text-decoration: none; color: black"> 
                                                            <i class="bi bi-book" style="color: green; margin-right: 2%"></i>PDF <%=pdfNumber%>. ${p.pdfName}
                                                        </a>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>


                                        </c:if>
                                    </c:forEach>
                                    <c:forEach var="q" items="${vectorQuiz}">
                                        <c:if test="${l.lessonID == q.id}">
                                            <ul class="list-group">
                                                <a href="start-quiz?lessonId=${l.lessonID}" class="list-group-item bg-light"><i class="bi bi-patch-question" style="margin-right: 2%"></i>Take Quiz</a>
                                            </ul>
                                        </c:if>

                                    </c:forEach>


                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="list-group collapse multi-collapse" id="collapseExample${l.lessonNo}">
                                    <c:forEach var="v" items="${vectorVideo}">
                                        <c:if test="${l.lessonID == v.lessonID}">
                                            <%videoNumber++;%>
                                            <div class="list-group-item list-group-item-action">
                                                <a href="ControllerVideo?videoID=${v.videoID}"  style="text-decoration: none; color: black">
                                                    <i class="bi bi-play-circle" style="color: red; margin-right: 2%"></i>Video <%=videoNumber%>. ${v.videoName} 
                                                </a>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                    <c:forEach var="p" items="${vectorPDF}">
                                        <c:if test="${l.lessonID == p.lessonID}">
                                            <%pdfNumber++;%>
                                            <div class="list-group-item list-group-item-action">
                                                <a href="ControllerPDF?pdfID=${p.pdfID}" style="text-decoration: none; color: black"> 
                                                    <i class="bi bi-book" style="color: green; margin-right: 2%"></i>PDF <%=pdfNumber%>. ${p.pdfName}
                                                </a>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                    <c:forEach var="q" items="${vectorQuiz}">
                                        <c:if test="${l.lessonID == q.id}">
                                            <ul class="list-group">
                                                <a href="start-quiz?lessonId=${l.lessonID}" class="list-group-item bg-light"><i class="bi bi-patch-question" style="margin-right: 2%"></i>Take Quiz</a>
                                            </ul>
                                        </c:if>

                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>


                    </c:forEach>
                </div>
            </div>
            <div class="col-md-9" >
                <h3>Learning: ${name}</h3>
                <c:choose>
                    <c:when test="${pdfName != null}">
                        <div class="mx-5">
                            <embed id="myPDF" src="./${pdfName}" width="98%" height="750px" type="application/pdf" alt="sorry">
                        </div>
                    </c:when>
                    <c:when test="${videoName != null}">
                        <video id="myVideo" controls autoplay>
                            <source src="./Video/${videoName}" type="video/mp4" >
                        </video>
                    </c:when>
                    <c:otherwise>
                        <h3 class="text-center text-danger">This Course not have lesson. Please wait for teacher create the lesson
                            </h3>
                        </c:otherwise>
                    </c:choose>
            </div>
        </div>


        <div class="container-fluid bg-info text-center py-2 footer">
            <c:choose>

                <c:when test="${vID == min && vID != 0}">
                    <button  type="button" id="btnPrevious" class="btn btn-secondary mx-5 disabled"><i class="bi bi-chevron-left"></i> Previous Lesson</a> </button>
                    <button type="button" id="btnNext" class="btn btn-success"><a class="text-white" style="text-decoration: none" href="${NextLesson}">Next Lesson</a> <i class="bi bi-chevron-right"></i> </button>
                </c:when>
                <c:when test="${LastLesson != null}">
                    <button  type="button" id="btnPrevious" class="btn btn-secondary mx-5"><a class="text-white" style="text-decoration: none" href="${PreviousLesson}"><i class="bi bi-chevron-left"></i> Previous Lesson</a> </button>
                    <button type="button" id="btnNext" class="btn btn-success disabled"><a class="text-white" style="text-decoration: none" href="${NextLesson}.">Next Lesson</a> <i class="bi bi-chevron-right"></i> </button>
                </c:when>
                <c:when test="${LastLesson == null && min == 0}">
                </c:when>
                <c:otherwise>
                    <button  type="button" id="btnPrevious" class="btn btn-secondary mx-5"><a class="text-white" style="text-decoration: none" href="${PreviousLesson} "><i class="bi bi-chevron-left"></i> Previous Lesson </a></button>
                    <button type="button" id="btnNext" class="btn btn-success"><a class="text-white" style="text-decoration: none" href="${NextLesson} ">Next Lesson</a> <i class="bi bi-chevron-right"></i> </button>
                </c:otherwise>
            </c:choose>
        </div>
        <script>
            function Back() {
                history.back();
            }
        </script>


        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

</body>
</html>
