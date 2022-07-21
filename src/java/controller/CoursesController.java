/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Account;
import entity.Category;
import entity.Courses;
import entity.Lesson;
import entity.Teacher;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
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
public class CoursesController extends HttpServlet {

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

        }

        String service = request.getParameter("courses");
        if (service == null) {
            service = "displayAllCourses";
        }
        try (PrintWriter out = response.getWriter()) {

            /* TODO output your page here. You may use following sample code. */
            DAOCourses daoCourse = new DAOCourses();
            DAOCategory daoCategory = new DAOCategory();
            DAOLesson daoLesson = new DAOLesson();
            Vector<Courses> vectorCourses = daoCourse.getAllCourses();
            Vector<Category> vectorCategory = daoCategory.getAllCategory();
            int numberOfPage = daoCourse.numberOfPage();
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
            Vector<Courses> vectorCoursesPage = daoCourse.getCoursesInPage(page);

            if (service.equals("displayAllCourses")) {
                  String username = "";
                if (account != null) {
                    username = account.getUsername();
                    Vector<Courses> vectorUserCourses = DAOCourses.getCoursesByUsername(username);
                    request.setAttribute("vectorUserCourses", vectorUserCourses);
                }
                request.setAttribute("pageSelected", String.valueOf(page));
                request.setAttribute("numberOfPage", String.valueOf(numberOfPage));
                request.setAttribute("displayAllCourses", vectorCoursesPage);
                Dispatcher.dispatch(request, response, "displayCourses.jsp");
            }
           
          
            if (service.equals("detailCourse")) {
                  String username = "";
                if (account != null) {
                    username = account.getUsername();
                    Vector<Courses> vectorUserCourses = DAOCourses.getCoursesByUsername(username);
                    request.setAttribute("vectorUserCourses", vectorUserCourses);
                }
                
                String course = request.getParameter("courseID");
                int courseID = Integer.parseInt(course);
                Vector<Lesson> vectorLesson = daoLesson.getLessonByCourseID(courseID);
                Vector<Courses> vectorCourse = daoCourse.getCourseByID(courseID);
                request.setAttribute("vectorCourse", vectorCourse);
                request.setAttribute("vectorLesson", vectorLesson);
                
                Vector<Courses> vectorID = new Vector<Courses>();
                vectorID = daoCourse.getCourseByID(courseID);
                request.setAttribute("vectorID", vectorID);
                Dispatcher.dispatch(request, response, "CourseDescriptDetail.jsp");
            }

            if (service.equals("sortCourses")) {

                String sortBy = request.getParameter("sortBy");
                String flow = request.getParameter("flow");

                if (sortBy.equalsIgnoreCase("name")) {
                    vectorCourses = DAOCourses.getAllCoursesByName(flow, page);
                } else if (sortBy.equalsIgnoreCase("price")) {
                    vectorCourses = DAOCourses.getAllCoursesByPrice(flow, page);
                }
                request.setAttribute("sortBy", sortBy);
                request.setAttribute("flow", flow);
                request.setAttribute("displayAllCourses", vectorCourses);
                request.setAttribute("pageSelected", String.valueOf(page));
                request.setAttribute("numberOfPage", String.valueOf(numberOfPage));

                Dispatcher.dispatch(request, response, "displayCourses.jsp");
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
