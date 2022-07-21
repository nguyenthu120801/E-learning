<%-- 
    Document   : FAQ
    Created on : Jul 19, 2022, 10:49:52 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FAQ E-Learning</title>
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
            .footer{
                position: relative;
                bottom: 0;
                left: 0;
            }
            .card{
                font-family: sans-serif;
            }
        </style>
        <%@ include file="component/navbar.jsp" %>
        <br>
        <h1 class="text-center text-uppercase text-info">E-Learning FAQ</h1>
        <div class="container">
        <ul class="list-group">
            <li class="list-group-item text-white my-2 bg-info" data-bs-toggle="collapse" href="#collapseExample1" role="button" aria-expanded="false" aria-controls="collapseExample1">What Types of Programs Are Available?</li>
            <div class="collapse" id="collapseExample1">
                <div class="card card-body bg-light">
                    A broad range of associate's, bachelor's and master's degree programs are available online, offered by both public and private schools, colleges and universities as well as online-only educational institutions.<br>
                    Doctorate degrees and post-graduate certificate programs sometimes have an e-learning option, as well as many vocational diploma and certificate programs. Some schools also offer non-credit adult education classes online.
                </div>
            </div>
            <li class="list-group-item my-2 text-white bg-info" data-bs-toggle="collapse" href="#collapseExample2" role="button" aria-expanded="false" aria-controls="collapseExample2">Who Can Benefit?</li>
            <div class="collapse" id="collapseExample2">
                <div class="card card-body bg-light">
                    Online programs can meet the needs of many types of students, depending on their educational and professional needs. Some examples of students who might benefit from e-learning programs include the following:
                    <br>
                    -On-campus students looking for scheduling flexibility<br>
                    -Off-campus students who do not live near a college or university<br>
                    -Adult students with family and/or work obligations<br>
                    -Working professionals seeking to boost or change their careers<br>
                    -Military personnel
                </div>
            </div>
            <li class="list-group-item my-2 text-white bg-info" data-bs-toggle="collapse" href="#collapseExample3" role="button" aria-expanded="false" aria-controls="collapseExample3">How Do Online Programs Work?</li>
            <div class="collapse" id="collapseExample3">
                <div class="card card-body bg-light">
                    Some programs are a combination of on-campus and online study, while other programs are offered totally online. Often students are allowed to create their own study schedules using class materials, such as taped lectures and slide show presentations, which are accessible 24-7 through an Internet-based portal. Through this platform, students can also find their assignments, upload homework, participate in class discussions and contact their instructors.
                    <br>
                    In some instances, students may be required to log into class at the same time to attend events, such as live webcasts or online chat sessions. In addition, students usually have access to the school library's online databases, where they can view study materials, such as the online editions of academic journals and periodicals. Students in distance-learning programs may be required to complete exams under the supervision of a proctor.
                    <br>
                    Communication between students and instructors can occur through a variety of media, including:
                    <br>
                    +Video chats<br>
                    +Web conferencing
                </div>
            </div>
            <li class="list-group-item my-2 text-white bg-info" data-bs-toggle="collapse" href="#collapseExample4" role="button" aria-expanded="false" aria-controls="collapseExample4">What About In-Person Requirements?</li>
            <div class="collapse" id="collapseExample4">
                <div class="card card-body bg-light">
                    Some online programs may integrate practical components. For instance, students in online programs that prepare them for jobs in the health industry may need to complete laboratory courses or clinical internships.
                    Sometimes, these experiences can be set up in approved locations in the student's area. In these cases, students may need to keep a journal of their experience or a video record of their work to submit to their instructors for review. There are also online programs that require students to attend on-campus classes on weekends or complete one or more residency periods at the college.
                </div>
            </div>
            <li class="list-group-item my-2 text-white bg-info" data-bs-toggle="collapse" href="#collapseExample5" role="button" aria-expanded="false" aria-controls="collapseExample5">How Do I Choose a Program?</li>
            <div class="collapse" id="collapseExample5">
                <div class="card card-body bg-light">
                    One of the major concerns surrounding the choice of an online education program is determining if the program offers a legitimate degree or college credits that are accepted by other schools, employers and institutions that provide student aid funding. Schools recognized by a national or regional accreditation agency offer programs that meet the same standards as a school's on-campus offerings.
                    <br>
                    Most schools list their accreditation on their website, and the Council for Higher Education Accreditation maintains an accreditation directory. Also, the U.S. Department of Education has a database of accredited secondary and postsecondary schools, as well as a list of accreditation agencies.
                </div>
            </div>
        </ul>
        </div>
        <br>
        <section class="footer" style="margin-top: 8%">
            <%@ include file="component/footer.jsp" %>
        </section>
        
    </body>
</html>