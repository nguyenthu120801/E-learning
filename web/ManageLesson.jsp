<%@page import="entity.Category"%>
<%@page import="java.util.Vector"%>
<%@page import="model.DAOCategory"%>
<%@page import="model.DAOTeacher"%>
<%@page import="entity.Student"%>
<%@page import="model.DAOStudent"%>
<%@page import="model.DAOAccount"%>
<%@page import="entity.Account"%>
<%@page import="entity.Teacher"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

        <style>
            #lessonContent{
                background-color: #EEEEEE; 
                overflow-y: scroll; 
                height: 820px
            }
            #myVideo {
                width: 80%;
                height: 700px;
                margin-left: 10%;

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
                        <a href="#" class="btn btn-info py-4 px-lg-5 text-white"><img src="<%=image%>" alt="Avatar" class="avatar">  ${sessionScope.account.username}</a>
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


    <div class="container-fluid">
        <div class="row" style="border-right: 1px solid black">
            <div id="lessonContent" class="col-md-3" style="background-color: #EEEEEE; border-right: 1px solid black">
                <h3 style="margin-top: 1%; margin-bottom: 1%"><a href="Teacher" style="color: #06BBCC; text-decoration: none"> <i class="bi bi-arrow-left"></i> Back</a></h3>
                <h3>COURSE CONTENT</h3>
                <div class="teacher row">
                    <c:if test="${messageError != null}">
                        <h5 style="color: red">${messageError}</h5>
                    </c:if>
                    <c:if test="${messageSuccess !=null}">
                        <h5 style="color: green">${messageSuccess}</h5>
                    </c:if>
                    <div class="col-md-4">
                        <button class="btn btn-info" style="color: black" data-bs-toggle="collapse" data-bs-target="#addLesson" aria-expanded="false" aria-controls="addLesson"> <i class="bi bi-folder-plus"></i> lesson</button>

                    </div>

                    <form method="POST" action="Manage">
                        <input type="hidden" name="s" value="addLesson" />
                        <div class="card card-body collapse" id="addLesson" style="margin-top: 3%">
                            <input type="text" name="lessonName" required placeholder="Enter Lesson Name"/>
                            <input type="submit" value="Submit" />
                        </div>
                    </form>


                </div>

                <div>
                    <!--List Lesson in course -->
                    <c:forEach var="l" items="${lesson}">
                        <div class="list-group" style="margin: 15px 0">

                            <div class="list-group-item list-group-item-info" style="background-color: #06BBCC">
                                <div class="row">
                                    <div class="col-md-10">
                                        <!--Control card have same target and false is close -->
                                        <a style="background-color: #06BBCC; color: white; text-decoration: none; cursor: pointer" data-bs-toggle="collapse" data-bs-target="#collapseExample${l.lessonNo}" aria-expanded="false" aria-controls="CollapseExample${l.lessonNo}">
                                            <i class="bi bi-plus-circle-fill" style="margin-right: 3%"></i>${l.lessonNo}. ${l.lessonName}  
                                        </a>
                                    </div>
                                    <div class="col-md-2 teacher">
                                        <a style="float: right;" href="Manage?s=removeLesson&lessonID=${l.lessonID}">
                                            <i onclick="return confirm('Are you sure you want to delete lesson: ${l.lessonName}')" style="color:red" class="bi bi-x">
                                            </i>
                                        </a>
                                        <a style="float: right; margin-right: 2%" type="button" data-bs-toggle="collapse" data-bs-target="#updateLesson${l.lessonID}" aria-expanded="false" aria-controls="updateLesson${l.lessonID}"><i class="bi bi-pencil" style="color: green;"></i></a>
                                    </div>
                                </div>

                                <!--Form update Lesson -->
                                <form method="POST" action="Manage">
                                    <input type="hidden" name="s" value="updateLesson" />
                                    <input type="hidden" name="id" value="${l.lessonID}" />
                                    <input type="hidden" name="No" value="${l.lessonNo}" />
                                    <div class="card card-body collapse" id="updateLesson${l.lessonID}" style="margin-top: 1%">
                                        Lesson Name:<input type="text" name="lessonName" value="${l.lessonName}" />
                                        <input type="hidden" name="lessonNo" value="${l.lessonNo}" />
                                        <input type="submit" value="Submit" />
                                    </div>
                                </form>
                            </div>
                        </div>
                        <c:choose>
                            <c:when test="${l.lessonID == lID}">
                                <!-- -->
                                <div class="list-group collapse multi-collapse show" id="collapseExample${l.lessonNo}">
                                    <div class="teacher">
                                        <div class="row" style="margin-bottom: 2%">
                                            <div class="col-md-4"><button style="background-color: #f0fbfc; border-radius: 10%" data-bs-toggle="collapse" data-bs-target="#addVideo${l.lessonNo}" aria-expanded="false" aria-controls="addVideo${l.lessonNo}">Add Video</button></div>
                                            <div class="col-md-4"><button style="background-color: #f0fbfc; border-radius: 10%" data-bs-toggle="collapse" data-bs-target="#addPDF${l.lessonNo}" aria-expanded="false" aria-controls="addPDF${l.lessonNo}">Add PDF</button></div>
                                            <div class="col-md-3">
                                                <button class="btn btn-info"><a style="text-decoration: none; color: black" href="list?lessonId=${l.lessonID}"><i class="bi bi-eye"></i> Quiz</a></button>
                                            </div>
                                        </div>

                                        <!--form add video-->
                                        <form method="POST" action="ControllerVideo">
                                            <input type="hidden" name="s" value="addVideo" />
                                            <input type="hidden" name="lessonID" value="${l.lessonID}" />
                                            <div class="card card-body collapse" id="addVideo${l.lessonNo}" style="margin-top: 1%">
                                                <input type="text" name="videoName" required value="" placeholder="Enter Video Name"/>
                                                <input type="file" name="fileVideo" required id="" multiple accept=".mp4">
                                                <input type="submit" value="Submit" />
                                            </div>
                                        </form>

                                        <!--form add pdf-->
                                        <form action="ControllerPDF" method="POST">
                                            <input type="hidden" name="s" value="addPDF" />
                                            <input type="hidden" name="lessonID" value="${l.lessonID}" />
                                            <div class="card card-body collapse" id="addPDF${l.lessonNo}" style="margin-top: 1%">
                                                <input type="text" name="PDFName"  required value="" placeholder="Enter PDF Name"/>
                                                <input type="file" id="file-uploader" required name="FilePDF" accept=".pdf" multiple>
                                                <input type="submit" value="Submit" />
                                            </div>
                                        </form>
                                    </div>

                                    <c:forEach var="v" items="${vectorVideo}">
                                        <c:if test="${l.lessonID == v.lessonID}">
                                            <div class="list-group-item list-group-item-action">
                                                <div class="row">
                                                    <div class="col-md-10">
                                                        <a href="ControllerVideo?teach=teacher&videoID=${v.videoID}" style="text-decoration: none; color: black">
                                                            <i class="bi bi-play-circle" style="color: red; margin-right: 2%"></i>${v.videoName} 
                                                        </a>
                                                    </div>
                                                    <div class="col-md-2 teacher">
                                                        <a style="float: right;" href="ControllerVideo?s=removeVideo&id=${v.videoID}"><i onclick="return confirm('Are you sure you want to delete Video: ${v.videoName}')" class="bi bi-x" style="color: red"></i></a>
                                                        <a style="float: right; margin-right: 2%" type="button" data-bs-toggle="collapse" data-bs-target="#updateVideo${v.videoID}" aria-expanded="false" aria-controls="updateVideo${v.videoID}"><i class="bi bi-pencil" style="color: green;"></i></a>
                                                    </div>
                                                </div>
                                            </div>

                                            <form action="ControllerVideo" method="POST">
                                                <input type="hidden" name="s" value="updateVideo" />
                                                <input type="hidden" name="lessonID" value="${l.lessonID}" />
                                                <input type="hidden" name="videoID" value="${v.videoID}" />
                                                <div class="card card-body collapse" id="updateVideo${v.videoID}" style="margin-top: 1%">
                                                    Name:<input type="text" name="videoName" value="${v.videoName}"/>
                                                    New File Video:<input type="file" name="fileVideo" value="" accept=".mp4"/>
                                                    <input type="submit" value="Submit" />
                                                </div>
                                            </form>
                                        </c:if>
                                    </c:forEach>

                                    <c:forEach var="p" items="${vectorPDF}">
                                        <c:if test="${l.lessonID == p.lessonID}">
                                            <div class="list-group-item list-group-item-action">
                                                <div class="row">
                                                    <div class="col-md-10" >
                                                        <a href="ControllerPDF?teach=Teacher&pdfID=${p.pdfID}" style="text-decoration: none; color: black"> 
                                                            <i class="bi bi-book" style="color: green; margin-right: 2%"></i>${p.pdfName}
                                                        </a>
                                                    </div>
                                                    <div class="col-md-2 teacher" >
                                                        <a style="float: right;" href="ControllerPDF?s=removePDF&pdfID=${p.pdfID}"><i onclick="return confirm('Are you sure you want to delete pdf ${p.pdfName}')" class="bi bi-x" style="color: red"></i></a>
                                                        <a style="float: right; margin-right: 2%" href="ControllerPDF?s=updatePDF" data-bs-toggle="collapse" data-bs-target="#updateVideo${p.pdfID}" aria-expanded="false" aria-controls="updateVideo${p.pdfID}"><i class="bi bi-pencil" style="color: green;"></i></a>
                                                    </div>
                                                </div>
                                            </div>

                                            <form action="ControllerPDF" method="POST">
                                                <input type="hidden" name="s" value="updatePDF" />
                                                <input type="hidden" name="lessonID" value="${l.lessonID}" />
                                                <input type="hidden" name="pdfid" value="${p.pdfID}" />
                                                <input type="hidden" name="oldFilePDF" value="${p.filePDF}" />
                                                <div class="card card-body collapse" id="updateVideo${p.pdfID}" style="margin-top: 1%">
                                                    Name:<input type="text" name="PDFName" value="${p.pdfName}"/>
                                                    New File PDF:<input type="file" name="filePDF" value="" accept=".pdf"/>
                                                    <input type="submit" value="Submit" />
                                                </div>
                                            </form>

                                        </c:if>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>



                                <!-- -->
                                <div class="list-group collapse multi-collapse" id="collapseExample${l.lessonNo}">
                                    <div class="teacher">
                                        <div class="row" style="margin-bottom: 2%">
                                            <div class="col-md-4"><button style="background-color: #f0fbfc; border-radius: 10%" data-bs-toggle="collapse" data-bs-target="#addVideo${l.lessonNo}" aria-expanded="false" aria-controls="addVideo${l.lessonNo}">Add Video</button></div>
                                            <div class="col-md-4"><button style="background-color: #f0fbfc; border-radius: 10%" data-bs-toggle="collapse" data-bs-target="#addPDF${l.lessonNo}" aria-expanded="false" aria-controls="addPDF${l.lessonNo}">Add PDF</button></div>
                                            <div class="col-md-3">
                                                <button class="btn btn-info"><a style="text-decoration: none; color: black" href="list?lessonId=${l.lessonID}"><i class="bi bi-eye"></i> Quiz</a></button>
                                            </div>
                                        </div>

                                        <!--form add video-->
                                        <form method="POST" action="ControllerVideo">
                                            <input type="hidden" name="s" value="addVideo" />
                                            <input type="hidden" name="lessonID" value="${l.lessonID}" />
                                            <div class="card card-body collapse" id="addVideo${l.lessonNo}" style="margin-top: 1%">
                                                <input type="text" name="videoName" required value="" placeholder="Enter Video Name"/>
                                                <input type="file" name="fileVideo" required id="" multiple accept=".mp4">
                                                <input type="submit" value="Submit" />
                                            </div>
                                        </form>

                                        <!--form add pdf-->
                                        <form action="ControllerPDF" method="POST">
                                            <input type="hidden" name="s" value="addPDF" />
                                            <input type="hidden" name="lessonID" value="${l.lessonID}" />
                                            <div class="card card-body collapse" id="addPDF${l.lessonNo}" style="margin-top: 1%">
                                                <input type="text" name="PDFName"  required value="" placeholder="Enter PDF Name"/>
                                                <input type="file" id="file-uploader" required name="FilePDF" accept=".pdf" multiple>
                                                <input type="submit" value="Submit" />
                                            </div>
                                        </form>
                                    </div>

                                    <c:forEach var="v" items="${vectorVideo}">
                                        <c:if test="${l.lessonID == v.lessonID}">
                                            <div class="list-group-item list-group-item-action">
                                                <div class="row">
                                                    <div class="col-md-10">
                                                        <a href="ControllerVideo?teach=teacher&videoID=${v.videoID}" style="text-decoration: none; color: black">
                                                            <i class="bi bi-play-circle" style="color: red; margin-right: 2%"></i>${v.videoName} 
                                                        </a>
                                                    </div>
                                                    <div class="col-md-2 teacher">
                                                        <a style="float: right;" href="ControllerVideo?s=removeVideo&id=${v.videoID}"><i onclick="return confirm('Are you sure you want to delete Video: ${v.videoName}')" class="bi bi-x" style="color: red"></i></a>
                                                        <a style="float: right; margin-right: 2%" type="button" data-bs-toggle="collapse" data-bs-target="#updateVideo${v.videoID}" aria-expanded="false" aria-controls="updateVideo${v.videoID}"><i class="bi bi-pencil" style="color: green;"></i></a>
                                                    </div>
                                                </div>
                                            </div>

                                            <form action="ControllerVideo" method="POST">
                                                <input type="hidden" name="s" value="updateVideo" />
                                                <input type="hidden" name="lessonID" value="${l.lessonID}" />
                                                <input type="hidden" name="videoID" value="${v.videoID}" />
                                                <input type="hidden" name="oldFileVideo" value="${v.fileVideo}" />
                                                <div class="card card-body collapse" id="updateVideo${v.videoID}" style="margin-top: 1%">
                                                    Name:<input type="text" name="videoName" value="${v.videoName}"/>
                                                    New File Video:<input type="file" name="fileVideo" value="" accept=".mp4"/>
                                                    <input type="submit" value="Submit" />
                                                </div>
                                            </form>
                                        </c:if>
                                    </c:forEach>

                                    <c:forEach var="p" items="${vectorPDF}">
                                        <c:if test="${l.lessonID == p.lessonID}">
                                            <div class="list-group-item list-group-item-action">
                                                <div class="row">
                                                    <div class="col-md-10" >
                                                        <a href="ControllerPDF?teach=Teacher&pdfID=${p.pdfID}" style="text-decoration: none; color: black"> 
                                                            <i class="bi bi-book" style="color: green; margin-right: 2%"></i>${p.pdfName}
                                                        </a>
                                                    </div>
                                                    <div class="col-md-2 teacher" >
                                                        <a style="float: right;" href="ControllerPDF?s=removePDF&pdfID=${p.pdfID}"><i onclick="return confirm('Are you sure you want to delete pdf ${p.pdfName}')" class="bi bi-x" style="color: red"></i></a>
                                                        <a style="float: right; margin-right: 2%" href="ControllerPDF?s=updatePDF" data-bs-toggle="collapse" data-bs-target="#updateVideo${p.pdfID}" aria-expanded="false" aria-controls="updateVideo${p.pdfID}"><i class="bi bi-pencil" style="color: green;"></i></a>
                                                    </div>
                                                </div>
                                            </div>

                                            <form action="ControllerPDF" method="POST">
                                                <input type="hidden" name="s" value="updatePDF" />
                                                <input type="hidden" name="lessonID" value="${l.lessonID}" />
                                                <input type="hidden" name="pdfid" value="${p.pdfID}" />
                                                <input type="hidden" name="oldFilePDF" value="${p.filePDF}" />
                                                <div class="card card-body collapse" id="updateVideo${p.pdfID}" style="margin-top: 1%">
                                                    Name:<input type="text" name="PDFName" value="${p.pdfName}"/>
                                                    New File PDF:<input type="file" name="filePDF" value="" accept=".pdf"/>
                                                    <input type="submit" value="Submit" />
                                                </div>
                                            </form>

                                        </c:if>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                </div>

            </div>
            <div class="col-md-9" style="background-color: #f0fbfc" >
                <h3 style="text-align: center; margin-top: 2%">Learning: ${name}</h3>


                <c:choose>
                    <c:when test="${pdfName != null}">
                        <embed src="./PDF/${pdfName}" width="100%" height="750" type="application/pdf" alt="sorry">
                    </c:when>
                    <c:when test="${videoName != null}">
                        <video id="myVideo" height="650px" controls autoplay>
                            <source src="./Video/${videoName}" type="video/mp4" >
                        </video>
                    </c:when>    
                    <c:otherwise>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
        <!-- Footer Start -->
        <section>
        <%@include file="component/footer.jsp" %>
        </section>
        <!-- Footer End -->        
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

</body>



</html>