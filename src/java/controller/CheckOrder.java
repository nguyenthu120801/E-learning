/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Account;
import entity.Category;
import entity.Courses;
import entity.Student;
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
import model.DAOStudent;
import model.DAOup;

/**
 *
 * @author PC
 */
public class CheckOrder extends HttpServlet {

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
        String service = request.getParameter("courses");
        if (service == null) {
            service = "displayCourses";
        }
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            /* TODO output your page here. You may use following sample code. */
            DAOCourses daoCourse = new DAOCourses();
            DAOCategory daoCategory = new DAOCategory();
            DAOup daoup = new DAOup();
            DAOStudent dao = new DAOStudent();
            Vector<Category> vectorCategory = daoCategory.getAllCategory();
            Object a = session.getAttribute("account");
            if (a != null) {
                Account m = (Account) a;
                int n1 = 0;
                if (service.equals("displayCourses")) {
                    int courseID = Integer.parseInt(request.getParameter("courseID"));
                    int idstu = dao.getID(m.getUsername());
                    n1 = 2;
                    Vector<Student> e = dao.GetStudentByID(idstu);
                    Vector<Courses> vectorCourse = daoCourse.getCourseByID(courseID);
                    session.setAttribute("n", n1);
                    session.removeAttribute("error");
                    request.setAttribute("stu", e);
                    request.setAttribute("displayCourses", vectorCourse);
                    request.getRequestDispatcher("pay.jsp").forward(request, response);

                }

                if (service.equals("checkouts")) {
                    int courseID = Integer.parseInt(request.getParameter("courseID"));
                    int idstu = dao.getID(m.getUsername());
                    Vector<Student> e = dao.GetStudentByID(idstu);

                    int n = daoup.Addpay(idstu, courseID);
                    String mess = null;
                    n1 = 1;

                    mess = "Checkout successful";

                    request.setAttribute("mess", mess);
                    session.setAttribute("n", n1);
                    request.setAttribute("stu", e);
                    Vector<Courses> vectorCourse = daoCourse.getCourseByID(courseID);
                    request.setAttribute("displayCourses", vectorCourse);
                    request.getRequestDispatcher("pay.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect("login.jsp");
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
