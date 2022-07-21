/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Account;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.DAOAccount;

/**
 *
 * @author PC
 */
public class LoginController extends HttpServlet {

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
        request.getRequestDispatcher("login.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        //get all cookie
        Cookie[] cookies = request.getCookies();
        String username = null;
        String password = null;
        // if cookie exist
        if (cookies != null) {
            // loop for traverse all cookie
            for (Cookie cook : cookies) {
                // if cook name is username
                if (cook.getName().equals("username")) {
                    username = cook.getValue();
                }
                // if cook name is password
                if (cook.getName().equals("password")) {
                    password = cook.getValue();
                }
                if (username != null && password != null) {
                    break;
                }
            }
        }
        // if get username and password successful
        if (username != null && password != null) {
            // get account
            Account account = new DAOAccount().Login(username, password);
            session.setAttribute("account", account);
            // if admin
            if (account.getRoleName().equals("Admin")) {
                response.sendRedirect("Admin");
            } else {
                response.sendRedirect("Home");
            }
        } else {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }        

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
        HttpSession session = request.getSession();
        //check login
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean remember = Boolean.parseBoolean(request.getParameter("remember"));
        //check username, Password
        Account account = new DAOAccount().Login(username, password);
        if (account != null && account.getRoleName().equals(Account.ADMIN)) {// hop le -> luu len session
            if (remember) {
                Cookie usercookie = new Cookie("username", username);
                usercookie.setMaxAge(24 * 3600 * 2);
                Cookie passcookie = new Cookie("password", password);
                passcookie.setMaxAge(24 * 3600 * 2);
                response.addCookie(usercookie);
                response.addCookie(passcookie);
            }
            request.getSession().setAttribute("account", account);
            response.sendRedirect("Admin");
        } else if (account != null && account.getRoleName().equals(Account.STUDENT)) {// hop le -> luu len session
            //remember
            if (remember) {
                Cookie usercookie = new Cookie("username", username);
                usercookie.setMaxAge(24 * 3600 * 2);
                Cookie passcookie = new Cookie("password", password);
                passcookie.setMaxAge(24 * 3600 * 2);
                response.addCookie(usercookie);
                response.addCookie(passcookie);
            }

            request.getSession().setAttribute("account", account);
            response.sendRedirect("Home");
        } else if (account != null && account.getRoleName().equals(Account.TEACHER)) {// hop le -> luu len session
            //remember
            if (remember) {
                Cookie usercookie = new Cookie("username", username);
                usercookie.setMaxAge(24 * 3600 * 2);
                Cookie passcookie = new Cookie("password", password);
                passcookie.setMaxAge(24 * 3600 * 2);
                response.addCookie(usercookie);
                response.addCookie(passcookie);
            }
            request.getSession().setAttribute("account", account);
            response.sendRedirect("Home");
        } else {// khong hop le -> tra ve loi
            request.setAttribute("error", "Username or password incorrect!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
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
