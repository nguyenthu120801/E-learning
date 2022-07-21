package controller;

import entity.Account;
import entity.Student;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.DAOAccount;
import model.DAOStudent;

public class ProfileStudent extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAOAccount daoAccount = new DAOAccount();
        DAOStudent daoStudent = new DAOStudent();
        HttpSession session = request.getSession();
        try (PrintWriter out = response.getWriter()) {
            Account account = (Account) session.getAttribute("account");
            String username = account.getUsername();
            // get profile
            Student student = daoStudent.getProfile(username);
            // set attribute
            request.setAttribute("student", student);
            // dispatch
            dispatch(request, response, "UpdateStudentProfile.jsp");
        }
    }
    // dispatch request to another resource

    public void dispatch(HttpServletRequest request, HttpServletResponse response, String resource) throws ServletException, IOException {
        RequestDispatcher dispatch = request.getRequestDispatcher(resource);
        dispatch.forward(request, response);
    }
    // check DOB

    public boolean CheckDOB(String DOB) {
        //use class SimpleDateFormat to initialize format date is yyyy-MM-dd
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date DateCurrent = new Date();
        try {
            //convert string to date
            Date date = sdf.parse(DOB);
            // if date in the future
            if (date.after(DateCurrent)) {
                return false;
            }
        } catch (ParseException e) {
            return false;
        }
        return true;
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
        DAOStudent daoStudent = new DAOStudent();
        String username = request.getParameter("username");
        String FullName = request.getParameter("FullName").trim();
        String phone = request.getParameter("phone").trim();
        String address = request.getParameter("address").trim();
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
        // if  not set value address
        if (address.isEmpty()) {
            address = null;
        }
        // if phone empty 
        if (phone.isEmpty()) {
            phone = null;
        }
        String email = request.getParameter("email").trim();
        String gender = request.getParameter("gender");
        String DOB = request.getParameter("DOB").trim();
        // if not set DOB
        if (DOB.isEmpty()) {
            DOB = null;
        }
        Student student = new Student(FullName, phone, address, image, email, gender, username, DOB);
        // if phone invalid
        if (phone != null && !phone.matches("^[0-9]{10}+$")) {           
            // set attribute
            request.setAttribute("error", "Phone only number and length is 10");
            request.setAttribute("student", student);
            // dispatch
            dispatch(request, response, "UpdateStudentProfile.jsp");
            // if DOB in the future
        } else if (DOB != null && !CheckDOB(DOB)) {
            // set attribute
            request.setAttribute("error", "Date of birth not in the future");
            request.setAttribute("student", student);
            // dispatch
            dispatch(request, response, "UpdateStudentProfile.jsp");         
        }else {
            int number = daoStudent.UpdateStudent(student);
            // if update successful
            if (number > 0) {
                // set attribute
                request.setAttribute("successful", "Update successful");
                request.setAttribute("student", student);
                // dispatch
                dispatch(request, response, "UpdateStudentProfile.jsp");
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
