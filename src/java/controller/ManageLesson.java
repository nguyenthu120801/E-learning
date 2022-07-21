/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Lesson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.DAOLesson;
import model.DAOLessonPDF;
import model.DAOLessonVideo;
import model.QuizDAO;

/**
 *
 * @author PC
 */
public class ManageLesson extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String service = request.getParameter("s");
            DAOLesson daoLesson = new DAOLesson();
            DAOLessonVideo daoVideo = new DAOLessonVideo();
            DAOLessonPDF daoPDF = new DAOLessonPDF();
            QuizDAO daoQuiz = new QuizDAO();
            HttpSession session = request.getSession();
            int courseID = (int) session.getAttribute("courseID");
            
            if (service.equals("addLesson")) {
                String name = request.getParameter("lessonName");
                if (daoLesson.CheckLessonNameExsit(name, courseID)) {
                    String message = "Lesson " + name + " was exsited in course";
                    response.sendRedirect("ManageLesson?messageError=" + message + "");
                } else {

                    ResultSet rs = daoLesson.getData("select Max(LessonNo) from Lesson where CourseID = " + courseID + "");
                    try {
                        if (rs.next()) {
                            int lessonNo = rs.getInt(1);
                            daoLesson.AddLesson(new Lesson(-1, name, courseID, lessonNo + 1));
                            String message = "Added Lesson " + name + " Successfully!";
                            response.sendRedirect("ManageLesson?messageSuccess=" + message + "");
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(ControllerLesson.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

            }

            if (service.equals("removeLesson")) {
                int lessonID = Integer.parseInt(request.getParameter("lessonID"));
                int n = daoLesson.removeLesson(lessonID);
                if (n > 0) {
                    String message = "Remove Lesson Successfully!";
                    response.sendRedirect("ManageLesson?messageSuccess=" + message + "");
                } else {
                    String message = "Can't Remove This Lesson";
                    response.sendRedirect("ManageLesson?messageError=" + message + "");
                }
            }

            if (service.equals("updateLesson")) {
                String name = request.getParameter("lessonName");
                int lessonNo = Integer.parseInt(request.getParameter("lessonNo"));
                int oldLessonNo = Integer.parseInt(request.getParameter("No"));
                if (daoLesson.CheckLessonNameExsit(name, courseID)) {
                    String message = "Lesson " + name + " was exsited in course";
                    response.sendRedirect("ManageLesson?messageError=" + message + "");
                } else if (daoLesson.CheckLessonNoExsit(lessonNo, courseID, oldLessonNo)) {
                    String message = "lesson No " + lessonNo + " was exsited in course";
                    response.sendRedirect("ManageLesson?messageError=" + message + "");
                } else {
                    int id = Integer.parseInt(request.getParameter("id"));
                    daoLesson.updateLesson(new Lesson(id, name, -1, lessonNo));
                    String message = "Update Lesson Successfully!";
                    response.sendRedirect("ManageLesson?messageSuccess=" + message + "");
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
