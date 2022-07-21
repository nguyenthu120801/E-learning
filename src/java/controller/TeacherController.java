/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Account;
import entity.Category;
import entity.Courses;
import entity.Teacher;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.DAOCategory;
import model.DAOCourses;
import model.DAOLesson;
import model.DAOTeacher;

/**
 *
 * @author nanht
 */
public class TeacherController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        int teacherID = -1;
        Account account = null;

        if (session.getAttribute("account") != null) {
            account = (Account) session.getAttribute("account");
            if (account.getRoleName().equalsIgnoreCase("Teacher")) {
                Teacher t = new DAOTeacher().getTeacherInfoByUsername(account.getUsername());
                teacherID = t.getID();
            }

        } else {
            Dispatcher.dispatch(request, response, "LoginController");
        }
        String service = request.getParameter("teacher");
        if (service == null) {
            service = "teachingCourses";
        }
        DAOCourses daoCourse = new DAOCourses();
        DAOCategory daoCategory = new DAOCategory();
        Vector<Category> vectorCategory = daoCategory.getAllCategory();
        int numberOfPage = daoCourse.numberOfPageInTeacherCourses(teacherID);
        int page = 1;
        String pageSelected = request.getParameter("page");
        if (pageSelected != null) {
            page = Integer.parseInt(pageSelected);
        }
        String queryString = request.getQueryString() != null ? ("?" + request.getQueryString()) : "";
        String directLink = request.getServletPath() + queryString;
        char pageChosen = directLink.charAt(directLink.indexOf("&page") + 6);
        directLink = directLink.substring(1, directLink.length());

        directLink = directLink.replaceAll("&page=" + pageChosen + "", "");
        if (directLink.contains("?page=")) {
            directLink = directLink.substring(0, 7);
        }
        System.out.println(directLink);
        System.out.println(pageChosen);
        request.setAttribute("directLink", directLink);
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            if (service.equals("teachingCourses")) {
                Teacher t;

                if (account != null) {
                    t = new DAOTeacher().getTeacherInfoByUsername(account.getUsername());
                    teacherID = t.getID();
                    Vector<Courses> vectorCoursesPage = daoCourse.getTeacherCoursesInPage(page, teacherID);
                    request.setAttribute("vectorTeacherCourses", vectorCoursesPage);

                }
                request.setAttribute("pageSelected", String.valueOf(page));
                request.setAttribute("numberOfPage", String.valueOf(numberOfPage));
                Dispatcher.dispatch(request, response, "TeacherCourses.jsp");

            }
            if (service.equals("addCourse")) {
                if (session.getAttribute("account") == null) {
                    Dispatcher.dispatch(request, response, "LoginController");
                }
                String startCreate = request.getParameter("startCreate");
                if (startCreate == null) {
                    request.setAttribute("vectorCategory", vectorCategory);
                    Dispatcher.dispatch(request, response, "addCourse.jsp");
                } else {
                    String courseName = request.getParameter("courseName");
                    String image = request.getParameter("image");
                    double price = Double.parseDouble(request.getParameter("price"));
                    int categoryID = Integer.parseInt(request.getParameter("courseCategory"));
                    String description = request.getParameter("description");
                    Courses co = new Courses(courseName, image, price, categoryID, teacherID, description);
                    daoCourse.addCourse(co);
                    Dispatcher.dispatch(request, response, "Teacher?teacher=teachingCourses");
                    // response.sendRedirect("Teacher?teacher=teachingCourses");
                }

            }
            if (service.equals("updateCourse")) {
                if (session.getAttribute("account") == null) {
                    Dispatcher.dispatch(request, response, "LoginController");
                }

                String updateCourse = request.getParameter("updateCourse");
                if (updateCourse == null) {
                    int courseID = Integer.parseInt(request.getParameter("courseID"));
                    Vector<Courses> vectorCourse = daoCourse.getCourseByID(courseID);
                    request.setAttribute("vectorCourse", vectorCourse);
                    request.setAttribute("vectorCategory", vectorCategory);
                    Dispatcher.dispatch(request, response, "updateCourse.jsp");
                } else {
                    int courseID = Integer.parseInt(request.getParameter("courseID"));
                    String courseName = request.getParameter("courseName");
                    String image = request.getParameter("image");
                    double price = Double.parseDouble(request.getParameter("price"));
                    int categoryID = Integer.parseInt(request.getParameter("courseCategory"));
                    String description = request.getParameter("description");
                    Courses co = new Courses(courseID, courseName, image, price, categoryID, teacherID, description);
                    daoCourse.updateCourse(co);
                    Vector<Courses> aCourse1 = daoCourse.getCourseByID(courseID);
                    String courseName1 = "";
                    for (Courses courses1 : aCourse1) {
                        courseName1 = courses1.getCourseName();
                    }
                    String error = "Course name : '" + courseName1 + "' Update Successful";
                    System.out.println(error);
                    request.setAttribute("error", error);
                    Dispatcher.dispatch(request, response, "Teacher?teacher=teachingCourses");

                }

            }
            if (service.equals("deleteCourse")) {
                if (session.getAttribute("account") == null) {
                    Dispatcher.dispatch(request, response, "LoginController");
                }
                String course = request.getParameter("courseID");
                int courseID = Integer.parseInt(course);
                Vector<Courses> aCourse = daoCourse.getCourseByID(courseID);
                String courseName = "";
                for (Courses courses : aCourse) {
                    courseName = courses.getCourseName();
                }
                int n = daoCourse.deleteCourse(courseID);
                String error = "Course name : '" + courseName + "' already has student studied";
                if (n == 0) {

                    request.setAttribute("error", error);
                    Dispatcher.dispatch(request, response, "Teacher?teacher=teachingCourses");
                } else {
                    error = "Course name : '" + courseName + "' delete successful";
                    request.setAttribute("error", error);

                    Dispatcher.dispatch(request, response, "Teacher?teacher=teachingCourses");
                    // response.sendRedirect("Teacher?teacher=teachingCourses");
                }

            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
