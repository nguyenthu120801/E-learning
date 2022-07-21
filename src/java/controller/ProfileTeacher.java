/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Account;
import entity.Teacher;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.DAOAccount;
import model.DAOTeacher;

public class ProfileTeacher extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAOAccount daoAccount = new DAOAccount();
        DAOTeacher daoTeacher = new DAOTeacher();
        HttpSession session = request.getSession();
        try (PrintWriter out = response.getWriter()) {
            Account account = (Account) session.getAttribute("account");
            String username = account.getUsername();
            Teacher teacher = daoTeacher.getProfile(username);
            // set attribute
            request.setAttribute("teacher", teacher);
            // dispatch
            dispatch(request, response, "UpdateTeacherProfile.jsp");
        }
    }
    // dispatch request to another resource

    public void dispatch(HttpServletRequest request, HttpServletResponse response, String resource) throws ServletException, IOException {
        RequestDispatcher dispatch = request.getRequestDispatcher(resource);
        dispatch.forward(request, response);
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
        DAOTeacher daoTeacher = new DAOTeacher();
        String username = request.getParameter("username");
        String FullName = request.getParameter("FullName").trim();
        String phone = request.getParameter("phone").trim();
        String image = request.getParameter("image");
        // if can not get value from parameter image
        if (image == null || image.isEmpty()) {
            image = request.getParameter("valueImg");
        } else {
            // if image end with .jpg or .png
            if (image.endsWith(".jpg") || image.endsWith(".png")) {
                // if image address not start with ./img/
                if (!image.startsWith("./img/")) {
                    image = "./img/" + image;
                }
            }
        }
        // if phone empty 
        if (phone.isEmpty()) {
            phone = null;
        }
        String email = request.getParameter("email").trim();
        String gender = request.getParameter("gender");
        Teacher teacher = new Teacher(FullName, phone, image, email, gender, username);
        // if phone invalid
        if (phone != null && !phone.matches("^[0-9]{10}+$")) {
            // set attribute
            request.setAttribute("error", "Phone only number and length is 10");
            request.setAttribute("teacher", teacher);
            // dispatch
            dispatch(request, response, "UpdateTeacherProfile.jsp");
        } else {
            int number = daoTeacher.UpdateTeacher(teacher);
            // if update successful
            if (number > 0) {
                // set attribute
                request.setAttribute("successful", "Update successful");
                request.setAttribute("teacher", teacher);
                // dispatch
                dispatch(request, response, "UpdateTeacherProfile.jsp");
            }
        }
        // processRequest(request, response);
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
