package controller;

import entity.Account;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.DAOAccount;

public class StudentChangePassword extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            dispatch(request, response, "StudentChangePassword.jsp");
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
        HttpSession session = request.getSession();
        DAOAccount daoAccount = new DAOAccount();
        Account account = (Account) session.getAttribute("account");
        String username = account.getUsername();
        String OldPassword = request.getParameter("old");
        String NewPassword = request.getParameter("new");
        String ComfirmPassword = request.getParameter("confirm");
        // if account invalid
        if (!daoAccount.CheckAccountValid(username, OldPassword)) {
            // set attribute 
            request.setAttribute("error", "Your old password not correct");
            dispatch(request, response, "StudentChangePassword.jsp");
        } else {
            // if new not same confirm
            if (!NewPassword.equals(ComfirmPassword)) {
                // set attribute 
                request.setAttribute("error", "Your confirm password not the same new password");
                dispatch(request, response, "StudentChangePassword.jsp");
            } else {
                // update account
                int number = daoAccount.UpdatePassword(username, NewPassword);
                // if update successful
                if (number > 0) {
                    // set attribute 
                    request.setAttribute("successful", "Change successful!");
                    dispatch(request, response, "StudentChangePassword.jsp");
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
