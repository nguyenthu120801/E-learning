/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Category;
import entity.Courses;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DAOCategory;
import model.DAOCourses;

/**
 *
 * @author nanht
 */
public class CategoryController extends HttpServlet {

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
        DAOCategory daoCategory = new DAOCategory();
        DAOCourses daoCourse = new DAOCourses();
        String categoryID = request.getParameter("category");
        int numberOfPage = daoCourse.numberOfPageWithCategory(categoryID);

        try (PrintWriter out = response.getWriter()) {
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
            Vector<Courses> vectorCoursesPage = daoCourse.getCoursesInPageWithCategory(Integer.parseInt(categoryID), page);

            System.out.println(directLink);
            System.out.println(pageChosen);
            request.setAttribute("directLink", directLink);
            request.setAttribute("categorySelected", categoryID);
            request.setAttribute("pageSelected", String.valueOf(page));
            request.setAttribute("numberOfPage", String.valueOf(numberOfPage));

            request.setAttribute("displayAllCourses", vectorCoursesPage);
            Dispatcher.dispatch(request, response, "displayCourses.jsp");

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
