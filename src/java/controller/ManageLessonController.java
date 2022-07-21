/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Lesson;
import entity.LessonPDF;
import entity.LessonVideo;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
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
public class ManageLessonController extends HttpServlet {

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
            if (service == null) {
                service = "ManageLesson";
            }
            DAOLesson daoLesson = new DAOLesson();
            DAOLessonVideo daoVideo = new DAOLessonVideo();
            DAOLessonPDF daoPDF = new DAOLessonPDF();
            QuizDAO daoQuiz = new QuizDAO();
            HttpSession session = request.getSession();
            String courseId = request.getParameter("courseID");
            int courseID = 0;
            if (courseId == null) {
                courseID = (int) session.getAttribute("courseID");
            } else {
                courseID = Integer.parseInt(courseId);
                session.setAttribute("courseID", courseID);
            }

            if (service.equals("ManageLesson")) {
                String linkVideo = request.getParameter("video");
                String nameOfCourse = request.getParameter("name");
                String linkPDF = request.getParameter("pdf");
                String lessonID = request.getParameter("lessonID");
                String videoID = request.getParameter("videoID");
                String pdfID = request.getParameter("pdfID");
                String messageError = request.getParameter("messageError");
                String messageSuccess = request.getParameter("messageSuccess");

                Vector<Lesson> vectorLesson = daoLesson.addToVector("select * from Lesson where courseID =" + courseID); // fix cung course id la 1 sau se chinh lai cho cung vs database
                Vector<LessonVideo> vectorVideo = daoVideo.ListAll("select * from LessonVideo");
                Vector<LessonPDF> vectorPDF = daoPDF.ListAll("select * from LessonPDF");

                // start to learn course
                if (linkVideo == null && linkPDF == null) {
                    ResultSet rs = daoLesson.getData("select top 1 FileVideo, VideoName, VideoID, LessonID from LessonVideo where LessonID = (\n"
                            + "select top 1 LessonID from Lesson where CourseID = " + courseID + " and LessonNo = 1)");
                    try {
                        if (rs.next()) {
                            linkVideo = rs.getString(1);
                            nameOfCourse = rs.getString(2);
                            videoID = rs.getString(3);
                            if (lessonID == null) {
                                lessonID = rs.getString(4);
                            }
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(ControllerLesson.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

                request.setAttribute("lesson", vectorLesson);
                request.setAttribute("vectorVideo", vectorVideo);
                request.setAttribute("vectorPDF", vectorPDF);

                request.setAttribute("videoName", linkVideo);
                request.setAttribute("pdfName", linkPDF);

                request.setAttribute("name", nameOfCourse);

                request.setAttribute("vID", videoID);
                request.setAttribute("lID", lessonID);
                request.setAttribute("pID", pdfID);
                request.setAttribute("courseID", courseID);

                request.setAttribute("messageSuccess", messageSuccess);
                request.setAttribute("messageError", messageError);
                request.getRequestDispatcher("ManageLesson.jsp").forward(request, response);
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
