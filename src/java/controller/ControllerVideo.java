/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.LessonVideo;
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
import model.DAOLesson;
import model.DAOLessonVideo;

/**
 *
 * @author PC
 */
public class ControllerVideo extends HttpServlet {

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
            service = "watchVideo";
        }
        DAOLessonVideo dao = new DAOLessonVideo();
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            if (service.equals("watchVideo")) {
                int id = Integer.parseInt(request.getParameter("videoID"));
                String teach = request.getParameter("teach");
                ResultSet rs = dao.getData("select * from LessonVideo where VideoID =" + id);
                try {
                    if (rs.next()) {
                        String video = rs.getString(3);
                        String name = rs.getString(2);
                        int lessonID = rs.getInt(4);
                        if(teach == null){
                            request.getRequestDispatcher("ControllerLesson?videoID=" + id + "&video=" + video + "&name=" + name + "&lessonID=" + lessonID + "").forward(request, response);
                        }else{
                            request.getRequestDispatcher("ManageLesson?videoID=" + id + "&video=" + video + "&name=" + name + "&lessonID=" + lessonID + "").forward(request, response);
                        }
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(ControllerVideo.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (service.equals("addVideo")) {
                int lessonID = Integer.parseInt(request.getParameter("lessonID"));
                String videoName = request.getParameter("videoName");
                String fileVideo = request.getParameter("fileVideo");
                if (dao.CheckVideoNameExsit(videoName, lessonID)) {
                    String message = "Video " + videoName + " was exsited in lesson";
                    response.sendRedirect("ManageLesson?lessonID=" + lessonID + "&messageError=" + message + "");
                } else if (dao.CheckVideoFileExsit(fileVideo, lessonID)) {
                    String message = "File Video " + fileVideo + " was exsited in lesson";
                    response.sendRedirect("ManageLesson?lessonID=" + lessonID + "&messageError=" + message + "");
                } else {
                    int n = dao.addVideo(new LessonVideo(videoName, fileVideo, lessonID));
                    if (n > 0) {
                        String message = "Video " + videoName + " was added successfully!";
                        response.sendRedirect("ManageLesson?lessonID=" + lessonID + "&messageSuccess=" + message + "");
                    } else {
                        String message = "Video " + videoName + " was added Fail!";
                        response.sendRedirect("ManageLesson?lessonID=" + lessonID + "&messageError=" + message + "");
                    }
                }
            }

            if (service.equals("updateVideo")) {
                int lessonID = Integer.parseInt(request.getParameter("lessonID"));
                String videoName = request.getParameter("videoName");
                String fileVideo = request.getParameter("fileVideo");
                int videoID = Integer.parseInt(request.getParameter("videoID"));
                if (dao.CheckVideoNameExsit(videoName, lessonID)) {
                    String message = "Video " + videoName + " was exsited in lesson";
                    response.sendRedirect("ManageLesson?lessonID=" + lessonID + "&messageError=" + message + "");
                } else if (dao.CheckVideoFileExsit(fileVideo, lessonID) && fileVideo != null) {
                    String message = "File Video " + fileVideo + " was exsited in lesson";
                    response.sendRedirect("ManageLesson?lessonID=" + lessonID + "&messageError=" + message + "");
                } else {
                    if (fileVideo == null || fileVideo.equals("")) {
                        String Video = dao.getVideoByID(videoID);
                        dao.updateVideo(new LessonVideo(videoID, videoName, Video, lessonID));
                    }else{
                        dao.updateVideo(new LessonVideo(videoID, videoName, fileVideo, lessonID));
                    }
                    String message = "Video " + videoName + " was update successfully!";
                    response.sendRedirect("ManageLesson?lessonID=" + lessonID + "&messageSuccess=" + message + "");
                }
            }

            if (service.equals("removeVideo")) {
                int id = Integer.parseInt(request.getParameter("id"));
                DAOLesson daoLesson = new DAOLesson();
                int lessonID = daoLesson.getLessonIDByVideoID(id);
                int n = dao.deleteVideo(id);
                if (n > 0) {
                    String message = "This Video was removed successfully!";
                    response.sendRedirect("ManageLesson?lessonID=" + lessonID + "&messageSuccess=" + message + "");
                } else {
                    String message = "Can't remove this video";
                    response.sendRedirect("ManageLesson?lessonID=" + lessonID + "&messageError=" + message + "");
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
