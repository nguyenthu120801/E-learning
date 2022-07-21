

<%@page import="model.DAOTeacher"%>
<%@page import="entity.Teacher"%>
<%@page import="model.DAOStudent"%>
<%@page import="entity.Student"%>
<%@page import="model.DAOAccount"%>
<%@page import="entity.Account"%>
<%@page import="model.DAOCategory"%>
<%@page import="entity.Category"%>
<%@page import="java.util.Vector"%>

<%
    DAOCategory daoCategory = new DAOCategory();

    Vector<Category> vectorCategory = daoCategory.getAllCategory();

    String searchValue = (String) request.getAttribute("searchValue");
    if (searchValue == null) {
        searchValue = "";
    }
    String roleName = session.getAttribute("account") != null ? ((Account) session.getAttribute("account")).getRoleName() : null;
    Account account1 = session.getAttribute("account") != null ? ((Account) session.getAttribute("account")) : null;

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
            <a href="Teacher?teacher=addCourse" class="nav-item nav-link <%=(roleName != null ? (roleName.equals("Teacher") ? "" : "d-none") : "d-none")%>">Create Course</a>
            <%if (account1 == null || !account1.getRoleName().equalsIgnoreCase("Teacher")) {%>
            <a href="Courses" class="nav-item nav-link">Courses</a>
            <%}%>

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
                    <% String URL = "";
                        Account account = (Account) session.getAttribute("account");
                        // if role is student
                        if (account.getRoleName().equals("Student")) {
                            URL = "ProfileStudent";
                        } else {
                            URL = "ProfileTeacher";
                        }
                    %>
                    <a href="<%=URL%>" class="dropdown-item">Profile</a>
                    <a href="MyCourse" class="dropdown-item <%=(roleName != null ? (roleName.equals("Student") ? "" : "d-none") : "")%>">My Course</a>
                    <a href="Teacher?teacher=teachingCourses" class="dropdown-item <%=(roleName != null ? (roleName.equals("Teacher") ? "" : "d-none") : "")%>">My Teaching Course</a>
                    <a href="Logout" class="dropdown-item">Log Out <i class="bi bi-box-arrow-right"></i></a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <a href="Login" class="btn btn-info py-4 px-lg-5 d-none d-lg-block text-white">Join Now<i class="fa fa-arrow-right ms-3"></i></a>
            </c:otherwise>
        </c:choose>

</div>
</nav>