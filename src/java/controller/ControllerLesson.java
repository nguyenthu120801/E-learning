
package controller;

import entity.Lesson;
import entity.LessonPDF;
import entity.LessonVideo;
import entity.Quiz;
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
public class ControllerLesson extends HttpServlet {

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
        String service = request.getParameter("s");
        if (service == null) {
            service = "learnLesson";
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

        //int courseID = 2;
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            if (service.equals("learnLesson")) {
                String linkVideo = request.getParameter("video");
                String nameOfCourse = request.getParameter("name");
                String linkPDF = request.getParameter("pdf");
                String lessonID = request.getParameter("lessonID");
                String videoID = request.getParameter("videoID");
                String pdfID = request.getParameter("pdfID");
                int minVideoID = daoVideo.getMinVideoIDByCourseID(courseID);
                int maxVideoID = daoVideo.getMaxVideoIDByCourseID(courseID);

                Vector<Lesson> vectorLesson = daoLesson.addToVector("select * from Lesson where courseID =" + courseID); // fix cung course id la 1 sau se chinh lai cho cung vs database
                Vector<LessonVideo> vectorVideo = daoVideo.ListAll("select * from LessonVideo");
                Vector<LessonPDF> vectorPDF = daoPDF.ListAll("select * from LessonPDF");
                Vector<Quiz> vectorQuiz = daoQuiz.getAllLessonOfQuiz();

                // start to learn course
                if (linkVideo == null && linkPDF == null) {
                    ResultSet rs = daoLesson.getData("select top 1 FileVideo, VideoName, VideoID, LessonID from LessonVideo where LessonID = (\n"
                            + "select top 1 LessonID from Lesson where CourseID = " + courseID + " and LessonNo = 1)");
                    try {
                        if (rs.next()) {
                            linkVideo = rs.getString(1);
                            nameOfCourse = rs.getString(2);
                            videoID = rs.getString(3);
                            lessonID = rs.getString(4);
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(ControllerLesson.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

                int videoId = 0;
                if (videoID != null) {
                    videoId = Integer.parseInt(videoID);
                }
                int pdfId = 0;
                if (pdfID != null) {
                    pdfId = Integer.parseInt(pdfID);
                }
                int lessonId = 0;
                if(lessonID != null){
                    lessonId = Integer.parseInt(lessonID);
                }                    

                if (daoLesson.checkLessonIDExist(lessonId)) {
                    int minPDFId = daoPDF.getMinPDFIDByLessonID(lessonId);
                    int maxPDFId = daoPDF.getMaxPDFIDByLessonID(lessonId);
                    int maxVideoId = daoLesson.getMaxVideoIDByLessonID(lessonId);
                    int minVideoIdNextLesson = daoLesson.getMinVideoIDByLessonID(lessonId + 1);
                    int minVideoId = daoLesson.getMinVideoIDByLessonID(lessonId);
                    if (videoID != null) {
                        if (videoId == maxVideoId) {
                            request.setAttribute("PreviousLesson", "ControllerVideo?videoID=" + (maxVideoId - 1));
                            request.setAttribute("NextLesson", "ControllerPDF?pdfID=" + minPDFId);
                        } else if (videoId == minVideoId && daoLesson.checkLessonIDExist(lessonId - 1)) {
                            int maxPDFIdPrevious = daoPDF.getMaxPDFIDByLessonID(lessonId - 1);
                            request.setAttribute("PreviousLesson", "ControllerPDF?pdfID=" + maxPDFIdPrevious);
                            request.setAttribute("NextLesson", "ControllerVideo?videoID=" + (minVideoId + 1));
                        } else {
                            request.setAttribute("PreviousLesson", "ControllerVideo?videoID=" + (videoId - 1) + "");
                            request.setAttribute("NextLesson", "ControllerVideo?videoID=" + (videoId + 1));
                        }
                    } else {
                        if (minPDFId == maxPDFId) {
                            request.setAttribute("PreviousLesson", "ControllerVideo?videoID=" + maxVideoId);
                            request.setAttribute("NextLesson", "ControllerVideo?videoID=" + minVideoIdNextLesson);
                        } else if (pdfId == minPDFId) {
                            request.setAttribute("PreviousLesson", "ControllerVideo?videoID=" + maxVideoId);
                            request.setAttribute("NextLesson", "ControllerPDF?pdfID=" + (minPDFId + 1));
                        } else if (pdfId == maxPDFId) {
                            request.setAttribute("PreviousLesson", "ControllerPDF?pdfID=" + (maxPDFId - 1));
                            request.setAttribute("NextLesson", "ControllerVideo?videoID=" + minVideoIdNextLesson);
                        } else {
                            request.setAttribute("PreviousLesson", "ControllerPDF?pdfID=" + pdfId);
                            request.setAttribute("NextLesson", "ControllerPDF?pdfID=" + pdfId);
                        }
                    }
                } else {
                    request.setAttribute("PreviousLesson", "ControllerVideo?videoID=" + (videoId - 1) + "");
                    request.setAttribute("NextLesson", "ControllerVideo?videoID=" + (videoId + 1));
                }
                
                
                if (daoVideo.checkMaxPdfIDInCourse(courseID)) {
                    if (pdfId == daoPDF.getMaxPdfIDInCourse(courseID)) {
                        request.setAttribute("LastLesson", "True");
                    }
                } else if (videoId == maxVideoID && videoId != 0) {
                    request.setAttribute("LastLesson", "True");
                }

                request.setAttribute("lesson", vectorLesson);
                request.setAttribute("vectorVideo", vectorVideo);
                request.setAttribute("vectorPDF", vectorPDF);
                request.setAttribute("vectorQuiz", vectorQuiz);

                request.setAttribute("videoName", linkVideo);
                request.setAttribute("pdfName", linkPDF);

                request.setAttribute("name", nameOfCourse);

                request.setAttribute("vID", videoID);
                request.setAttribute("lID", lessonID);
                request.setAttribute("pID", pdfID);

                request.setAttribute("min", minVideoID);
                request.setAttribute("max", maxVideoID);

                request.getRequestDispatcher("LearnCourse.jsp").forward(request, response);
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
