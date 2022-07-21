<%-- 
    Document   : takequiz
    Created on : Jun 7, 2022, 10:14:28 AM
    Author     : Windows
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <style>
        html {
            font-size: 80%;
            font-family: "Poppins", sans-serif;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            list-style-type: none;
            text-decoration: none;
        }

        body {
            letter-spacing: 1px;
            width: 100%;
            height: 100vh;
        }

        a {
            color: #555;
        }

        /*# sourceMappingURL=home.css.map */
        .section {
            width: 1200px;
            min-height: 600px;
            margin: 70px auto;
            background-color: white;
            box-shadow: 0 0 3px 3px #eee;
            padding: 35px;
            border-radius: 1rem;
            display: flex;
            flex-direction: row;
            flex-wrap: nowrap;
            justify-content: space-between;
        }
        .section__time {
            width: 20%;
            height: 50%;
            padding: 15px 0 15px 20px;
        }
        .section__countdown {
            font-size: 1.6rem;
            font-weight: bold;
        }
        .section__countdown span:first-child {
            margin-left: 10px;
            color: #0eb582;
        }
        .section__countdown span:not(:first-child) {
            color: #0eb582;
        }
        .section__exam {
            width: 75%;
            padding: 15px 0 15px 15px;
            border: 2px solid #0eb582;
        }
        .section__quiz {
            font-size: 1.4rem;
            margin: 10px 0 30px 0;
        }
        .section__quiz span {
            font-size: 1.6rem;
            text-transform: uppercase;
            display: block;
            margin-bottom: 15px;
            font-weight: bold;
            color: #0eb582;
        }
        .section__form {
            font-size: 1.3rem;
            margin: 25px 0;
        }
        .section__submit {
            margin-top: 70px;
            font-weight: bold;
            font-size: 1.5rem;
            color: #555;
            display: block;
            margin-left: 80%;
            border: none;
            outline: none;
            padding: 12px 30px;
            border: 2px solid #0eb582;
            background-color: white;
            cursor: pointer;
            transition: 0.25s linear;
        }
        .section__submit:hover {
            background-color: #0eb582;
            color: white;
        }
        .section__lable {
            padding-left: 50px;
            position: relative;
            cursor: pointer;
        }
        .section__lable::before {
            content: "";
            position: absolute;
            top: 50%;
            left: 0;
            transform: translateY(-50%);
            width: 23px;
            height: 23px;
            border-radius: 50%;
            background-color: rgba(14, 181, 130, 0.5);
        }
        .section__lable::after {
            content: "";
            position: absolute;
            top: 50%;
            left: 5px;
            width: 13px;
            height: 13px;
            border-radius: 50%;
            transform: translateY(-50%);
            background-color: #0eb582;
            opacity: 0;
            visibility: hidden;
        }
        .section__input {
            display: none;
        }
        .section__input:checked + .section__lable::after {
            opacity: 1;
            visibility: visible;
        }

        /*# sourceMappingURL=doExam.css.map */

    </style>
    <script type="text/javascript">
        window.onload = counter;
        function counter()
        {
            minutes = ${minutes};
            seconds = ${seconds};
            countDown();
        }
    </script>
    <script type="text/javascript">
        function countDown() {
            document.getElementById("min").innerHTML = minutes;
            document.getElementById("remain").innerHTML = seconds;
            document.getElementById("minute").value = minutes;
            document.getElementById("second").value = seconds;
            setTimeout("countDown()", 1000);
            if (minutes == 0 && seconds == 0)
            {
                document.getElementById("timeout").value = 1;
                document.getElementById("quiz_form").submit();
            } else
            {
                seconds--;
                if (seconds == 0 && minutes > 0)
                {
                    minutes--;
                    seconds = 60;
                }
            }
        }
        function checkOption() {
            var checkbox = document.getElementsByName("answer");
            var check = 0;
            for (var i = 0; i < checkbox.length; i++) {
                if (checkbox[i].checked)
                    check++;
            }
            if (check == 4 || check == 0)
                return true;
            else
                return false;
        }
        function checkEmpty() {
            if (checkOption()) {
                alert("Please tick your answers!");
                return false;
            } else {
                return true;
            }
        }
    </script>
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
    <!-- Navbar End -->

    <!-- TAKE Start -->
    <div class="section">
        <div class="section__exam">
            <form action="take-quiz" method="GET" id="quiz_form">
                <div class="section__quiz">
                    <span>Question ${no_quiz + 1}</span>
                    <p class="section__question">
                        ${quiz.ques}
                    </p>
                </div>
                <div class="section__group">
                    <div class="section__form">
                        <input type="radio" name="answer" value="1" class="section__input" id="section__input1">
                        <label for="section__input1" class="section__lable">${quiz.ans1}</label>
                    </div>
                    <div class="section__form">
                        <input type="radio" name="answer"  value="2" class="section__input" id="section__input2">
                        <label for="section__input2" class="section__lable">${quiz.ans2}</label>
                    </div>
                    <div class="section__form">
                        <input type="radio" name="answer" value="3" class="section__input" id="section__input3">
                        <label for="section__input3" class="section__lable">${quiz.ans3}</label>
                    </div>
                    <div class="section__form">
                        <input type="radio" name="answer" value="4" class="section__input" id="section__input4">
                        <label for="section__input4" class="section__lable">${quiz.ans4}</label>
                    </div>
                    <div class="section__form">
                        <button type="submit" class="section__submit">${button}</button>
                    </div>
                    <input id="quiz_no" name="question_no" value="${no_quiz}" type="hidden"/>
                    <input name="mark" value="${mark}" type="hidden" />
                    <input id="minute" name="minutes" type="hidden" />
                    <input id="second" name="seconds" type="hidden" />
                    <input id="timeout" name="timeOut" type="hidden" value="0" />
                    <input value="${size}" type="hidden">
                </div>
            </form>
        </div>
        <div class="section__time">
            <p class="section__countdown">Time left
                <span id="min"></span>
                <span>:</span>
                <span id="remain"></span></p>
        </div>
    </div>
    <!-- TAKE End -->
        

    <!-- Footer Start -->
     <%@include file="component/footer.jsp" %>
    <!-- Footer End -->


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