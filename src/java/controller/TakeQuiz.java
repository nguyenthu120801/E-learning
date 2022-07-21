/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Account;
import entity.Quiz;
import entity.Result;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.ResultDAO;

/**
 *
 * @author Windows
 */
public class TakeQuiz extends HttpServlet {

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
        HttpSession session = request.getSession();
        List<Quiz> list_quiz = (List<Quiz>) session.getAttribute("list_quiz");
        int order_quiz = Integer.parseInt(request.getParameter("question_no"));
        int score = Integer.parseInt(request.getParameter("mark"));
        String ansStr = request.getParameter("answer");
        int answer = 0;
        if (ansStr != null) {
            answer = Integer.parseInt(ansStr);
        }

        if (answer == list_quiz.get(order_quiz).getCorrectAns()) {
            score++;
        }

        if (order_quiz + 1 == list_quiz.size() || request.getParameter("timeOut") == "") {
            Account account = (Account) session.getAttribute("account");
            int lesson = (Integer) session.getAttribute("lesson_id");
            float final_score = ((float) score / list_quiz.size()) * 10;
            String status = "";
            if (final_score >= 5) {
                status = "PASS";
            } else {
                status = "NOT PASS";
            }

            ResultDAO result_dao = new ResultDAO();

            String user = account.getUsername();
            Result rs1 = new Result(-1, lesson, "", user, "", status, final_score, null);

            result_dao.insert(rs1);
            request.setAttribute("rs1", rs1);
            session.removeAttribute("list_quiz");
            request.setAttribute("lessonId", lesson);

            Dispatcher.dispatch(request, response, "result");

        } else {
            String minutes = request.getParameter("minutes");
            String seconds = request.getParameter("seconds");
            request.setAttribute("minutes", minutes);
            request.setAttribute("seconds", seconds);
            request.setAttribute("mark", score);
            request.setAttribute("no_quiz", order_quiz + 1);
            request.setAttribute("quiz", list_quiz.get(order_quiz + 1));
            request.setAttribute("size", list_quiz.size());

            if (order_quiz + 2 == list_quiz.size()) {
                request.setAttribute("button", "Finish");
            } else {
                request.setAttribute("button", "Next");
            }
            request.getRequestDispatcher("takequiz.jsp").forward(request, response);
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
