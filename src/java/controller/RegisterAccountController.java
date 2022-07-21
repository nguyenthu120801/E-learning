/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Account;
import entity.Student;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DAOAccount;
import model.DAOStudent;
import model.DAOTeacher;

/**
 *
 * @author PC
 */
public class RegisterAccountController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

        }
    }
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
         DAOAccount daoAccount = new DAOAccount();
        DAOStudent daoStudent = new DAOStudent();
        DAOTeacher daoTeacher = new DAOTeacher();
        String fullname = request.getParameter("name").trim();
        String phone = request.getParameter("phone");
        String email = request.getParameter("email").trim();
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String username = request.getParameter("username").trim();
        String password = request.getParameter("password");
        // if not choose gender
        if (gender == null) {
            // set attribute
            request.setAttribute("message", "Please choose your gender");
            // dispatch
            dispatch(request, response, "RegisterAccount.jsp");
            // iff phone invalid
        } else if (!phone.isEmpty() && !phone.matches("^[0-9]{10}+$")) {
            // set attribute
            request.setAttribute("message", "Phone only number and length is 10");
            // dispatch
            dispatch(request, response, "RegisterAccount.jsp");
        } else {
            // if username exist
            if (daoAccount.CheckUsernameExist(username)) {
                // set attribute
                request.setAttribute("message", "Your account has existed");
                // dispatch
                dispatch(request, response, "RegisterAccount.jsp");
            } else {
                if (phone.isEmpty()) {
                    phone = null;
                }
                if (address.isEmpty()) {
                    address = null;
                }
                Account account = new Account(username, password, "Student");
                int numberAccount = daoAccount.AddAccount(account);
                Student student = new Student(fullname, phone, address, "https://i.pinimg.com/736x/75/ae/6e/75ae6eeeeb590c066ec53b277b614ce3.jpg", email, gender, username, null);
                int numberStudent = daoStudent.AddStudent(student);
                // if add successful
                if (numberStudent > 0) {
                    //out.println("Successful");
                    request.setAttribute("mess", "congratulation! Register Account Successful");
                    dispatch(request, response, "RegisterAccount.jsp");
                }

            }
        }
        //processRequest(request, response);
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
