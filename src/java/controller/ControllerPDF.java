/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.LessonPDF;
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
import model.DAOLessonPDF;

/**
 *
 * @author PC
 */
public class ControllerPDF extends HttpServlet {

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
            service = "viewPDF";
        }
        DAOLessonPDF dao = new DAOLessonPDF();
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            if (service.equals("viewPDF")) {
                int id = Integer.parseInt(request.getParameter("pdfID"));
                String teacher = request.getParameter("teach");
                ResultSet rs = dao.getData("select * from LessonPDF where pdfID =" + id);
                try {
                    if (rs.next()) {
                        String pdf = rs.getString(3);
                        int pdfID = rs.getInt(1);
                        String pdfName = rs.getString(2);
                        int lessonID = rs.getInt(4);
                        if (teacher == null) {
                            request.getRequestDispatcher("ControllerLesson?pdf=" + pdf + "&pdfID=" + pdfID + "&name=" + pdfName + "&lessonID=" + lessonID + "").forward(request, response);
                        } else {
                            request.getRequestDispatcher("ManageLesson?pdf=" + pdf + "&pdfID=" + pdfID + "&name=" + pdfName + "&lessonID=" + lessonID + "").forward(request, response);
                        }
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(ControllerPDF.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (service.equals("addPDF")) {
                int lessonID = Integer.parseInt(request.getParameter("lessonID"));
                String pdfName = request.getParameter("PDFName");
                String filePDF = request.getParameter("FilePDF");
                if (dao.CheckPDFNameExsit(pdfName, lessonID)) {
                    String message = "PDF " + pdfName + " was exsited in lesson";
                    response.sendRedirect("ManageLesson?lessonID=" + lessonID + "&messageError=" + message + "");
                } else if (dao.CheckPDFFileExsit(filePDF, lessonID)) {
                    String message = "File PDF " + filePDF + " was exsited in lesson";
                    response.sendRedirect("ManageLesson?lessonID=" + lessonID + "&messageError=" + message + "");
                } else {
                    int n = dao.addPDF(new LessonPDF(-1, pdfName, filePDF, lessonID));
                    if (n > 0) {
                        String message = "PDF " + pdfName + " was added successfully!";
                        response.sendRedirect("ManageLesson?lessonID=" + lessonID + "&messageSuccess=" + message + "");
                    } else {
                        String message = "PDF " + pdfName + " was added Fail!";
                        response.sendRedirect("ManageLesson?lessonID=" + lessonID + "&messageError=" + message + "");
                    }
                }
            }

            if (service.equals("updatePDF")) {
                int lessonID = Integer.parseInt(request.getParameter("lessonID"));
                String pdfName = request.getParameter("PDFName");
                String filePDF = request.getParameter("filePDF");
                int pdfid = Integer.parseInt(request.getParameter("pdfid"));
                if (dao.CheckPDFNameExsit(pdfName, lessonID)) {
                    String message = "PDF " + pdfName + " was exsited in lesson";
                    response.sendRedirect("ManageLesson?lessonID=" + lessonID + "&messageError=" + message + "");
                } else if (dao.CheckPDFFileExsit(filePDF, lessonID)) {
                    String message = "File PDF " + filePDF + " was exsited in lesson";
                    response.sendRedirect("ManageLesson&lessonID=" + lessonID + "&messageError=" + message + "");
                } else {
                    if (filePDF == null || filePDF.equals("")) {
                        filePDF = request.getParameter("oldFilePDF");
                    }
                    dao.updatePDF(new LessonPDF(pdfid, pdfName, filePDF, lessonID));
                    String message = "PDF " + pdfName + " was updated successfully!";
                    response.sendRedirect("ManageLesson?lessonID=" + lessonID + "&messageSuccess=" + message + "");
                }
            }

            if (service.equals("removePDF")) {
                int id = Integer.parseInt(request.getParameter("pdfID"));
                int lessonID = dao.getLessonIDByPDFID(id);
                int n = dao.deletePDF(id);
                if (n > 0) {
                    String message = "This PDF was removed successfully!";
                    response.sendRedirect("ManageLesson?lessonID=" + lessonID + "&messageSuccess=" + message + "");
                } else {
                    String message = "Can't remove this pdf";
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
