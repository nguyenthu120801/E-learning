/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Quiz;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.QuizDAO;

/**
 *
 * @author Windows
 */
public class CreateQuiz extends HttpServlet {

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
        request.getRequestDispatcher("createQuiz.jsp").forward(request, response);
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
        int lessonId = (int) session.getAttribute("lessonId");
        String ques = request.getParameter("ques");
        String ans1 = request.getParameter("ans1");
        String ans2 = request.getParameter("ans2");
        String ans3 = request.getParameter("ans3");
        String ans4 = request.getParameter("ans4");
        String crAns = request.getParameter("correctAns");
        String msg = new QuizDAO().getInt(crAns, 1, 4);
	request.setAttribute("lessonId", lessonId);
       
        if (ques.equals("") || ans1.equals("") || ans2.equals("") || ans3.equals("") || ans4.equals("") || !msg.equals("")) {
            request.setAttribute("mess", msg);
            request.getRequestDispatcher("createQuiz.jsp").forward(request, response);
        } else {
            int correctAns = Integer.parseInt(crAns);
            Quiz quiz = new Quiz(-1, ques, lessonId, ans1, ans2, ans3, ans4, correctAns, "");
            QuizDAO quizDAO = new QuizDAO();
            quizDAO.insertQuiz(quiz);

            request.setAttribute("mess", "Create Successfull");
            request.getRequestDispatcher("list?lessonId=" + lessonId + "").forward(request, response);
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
