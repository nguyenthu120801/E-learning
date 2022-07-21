package controller;

import entity.Account;
import entity.Courses;
import entity.Lesson;
import entity.Pay_Courses;
import entity.Student;
import entity.Teacher;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DAOAccount;
import model.DAOCourses;
import model.DAOLesson;
import model.DAOLessonPDF;
import model.DAOLessonVideo;
import model.DAOPayCourse;
import model.DAOResult;
import model.DAOStudent;
import model.DAOTeacher;
import model.QuizDAO;

public class AdminController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAOAccount daoAccount = new DAOAccount();
        DAOStudent daoStudent = new DAOStudent();
        DAOTeacher daoTeacher = new DAOTeacher();
        DAOCourses daoCourse = new DAOCourses();
        DAOResult daoResult = new DAOResult();
        DAOPayCourse daoPayCourse = new DAOPayCourse();
        DAOLesson daoLesson = new DAOLesson();
        DAOLessonPDF daoPDF = new DAOLessonPDF();
        DAOLessonVideo daoVideo = new DAOLessonVideo();
        QuizDAO daoQuiz = new QuizDAO();
        String service = request.getParameter("service");
        // default service this page is view account
        if (service == null) {
            service = "ViewAccount";
        }
        try (PrintWriter out = response.getWriter()) {
            // if service is view
            if (service.equals("ViewAccount")) {
                List<Account> list = daoAccount.GetAllAccount();
                // set attribute
                request.setAttribute("list", list);
                // dispatch
                dispatch(request, response, "Admin.jsp");
            }
            // if service is remove
            if (service.equals("RemoveAccount")) {
                String username = request.getParameter("username");
                String role = request.getParameter("role");
                // if role student
                if (role.equals("Student")) {
                    int numberResult = daoResult.DeleteResult(username);
                    // get student id
                    int StudentID = daoStudent.getID(username);
                    // delete pay course
                    int numberPayCourse = daoPayCourse.DeletePayCourse("StudentID", StudentID);
                    // delete student
                    int numberStudent = daoStudent.DeleteStudent(username);
                    // delete account
                    int numberAccount = daoAccount.DeleteAccount(username);
                    // if delete successful
                    if (numberAccount > 0) {
                        List<Account> list = daoAccount.GetAllAccount();
                        // set attribute
                        request.setAttribute("list", list);
                        request.setAttribute("message", "Remove successful");
                        // dispatch
                        dispatch(request, response, "Admin.jsp");
                    }
                } else {
                    // get teacher ID
                    int TeacherID = daoTeacher.getID(username);
                    // get list course
                    List<Courses> listCourse = daoCourse.GetListCourse(TeacherID);
                    // get list pay course
                    List<Pay_Courses> listPay = new DAOPayCourse().GetListPayCourse(listCourse);
                    // if list pay course not empty
                    if (!listPay.isEmpty()) {
                        List<Account> list = daoAccount.GetAllAccount();
                        // set attribute
                        request.setAttribute("list", list);
                        request.setAttribute("message", "You can't remove this teacher because of existing student registering this teacher's course");
                        // dispatch
                        dispatch(request, response, "Admin.jsp");
                    } else {
                        // get list lesson
                        List<Lesson> listLesson = daoLesson.GetListLesson(listCourse);
                        // loop traverse through list lesson
                        for (Lesson lesson : listLesson) {
                            int numberResult = daoResult.DeleteResult("LessonID", lesson.getLessonID());
                            int numberQuiz = daoQuiz.DeleteQuiz(lesson.getLessonID());
                            int numberPDF = daoPDF.DeleteLessonPDF(lesson.getLessonID());
                            int numberVideo = daoVideo.DeleteLessonVideo(lesson.getLessonID());
                            int numberLesson = daoLesson.DeleteLesson(lesson.getLessonID());
                        }
                        // loop for traverse through list course
                        for (Courses course : listCourse) {
                            // delete pay course
                            int numberPayCourse = daoPayCourse.DeletePayCourse("CourseID", course.getCourseID());
                        }
                        // delete course
                        int numberCourse = daoCourse.DeleteCourse(TeacherID);
                        // delete teacher
                        int numberTeacher = daoTeacher.DeleteTeacher(username);
                        // delete account
                        int numberAccount = daoAccount.DeleteAccount(username);
                        // if delete successful
                        if (numberAccount > 0) {
                            List<Account> list = daoAccount.GetAllAccount();
                            // set attribute
                            request.setAttribute("list", list);
                            request.setAttribute("message", "Remove successful");
                            // dispatch
                            dispatch(request, response, "Admin.jsp");
                        }
                    }

                }
            }
            // if service is edit 
            if (service.equals("EditAccount")) {
                String username = request.getParameter("username");
                String role = request.getParameter("role");
                String STT = request.getParameter("STT");
                // set attribute
                request.setAttribute("username", username);
                request.setAttribute("role", role);
                request.setAttribute("STT", STT);
                // dispatch
                dispatch(request, response, "EditAccount.jsp");
            }
            // if service is profile
            if (service.equals("Profile")) {
                String username = request.getParameter("username");
                String STT = request.getParameter("STT");
                // get role name
                String RoleName = daoAccount.getRoleName(username);
                // set attribute
                request.setAttribute("username", username);
                request.setAttribute("STT", STT);
                // if role student
                if (RoleName.equals("Student")) {
                    Student student = daoStudent.getProfile(username);
                    // set attribute 
                    request.setAttribute("student", student);
                    // dispatch
                    dispatch(request, response, "StudentProfile.jsp");
                } else {
                    Teacher teacher = daoTeacher.getProfile(username);
                    // set attribute 
                    request.setAttribute("teacher", teacher);
                    // dispatch
                    dispatch(request, response, "TeacherProfile.jsp");
                }
            }

            // if service is search account
            if (service.equals("SearchAccount")) {
                String name = request.getParameter("name").trim();
                List<Account> list = daoAccount.GetListAccount(name);
                // set attribute
                request.setAttribute("name", name);
                // if list empty
                if (list.isEmpty()) {
                    // set attribute
                    request.setAttribute("message", "not found");
                } else {
                    // set attribute
                    request.setAttribute("list", list);
                }
                // dispatch
                dispatch(request, response, "Admin.jsp");
            }
            // if service is add account
            if (service.equals("AddAccount")) {
                // dispatch
                dispatch(request, response, "AddAccount.jsp");
            }
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
        DAOAccount daoAccount = new DAOAccount();
        DAOStudent daoStudent = new DAOStudent();
        DAOTeacher daoTeacher = new DAOTeacher();
        DAOCourses daoCourse = new DAOCourses();
        DAOResult daoResult = new DAOResult();
        DAOPayCourse daoPayCourse = new DAOPayCourse();
        DAOLesson daoLesson = new DAOLesson();
        DAOLessonPDF daoPDF = new DAOLessonPDF();
        DAOLessonVideo daoVideo = new DAOLessonVideo();
        QuizDAO daoQuiz = new QuizDAO();
        String service = request.getParameter("service");
        // if service is edit account
        if (service.equals("EditAccount")) {
            String username = request.getParameter("username");
            String role = request.getParameter("role");
            String roleEdit = request.getParameter("roleEdit");
            String STT = request.getParameter("STT");
            // if change student to teacher
            if (roleEdit.equals("Teacher") && role.equals("Student")) {
                int numberResult = daoResult.DeleteResult(username);
                // get student id
                int StudentID = daoStudent.getID(username);
                // delete pay course
                int numberPayCourse = daoPayCourse.DeletePayCourse("StudentID", StudentID);
                // get student profile
                Student student = daoStudent.getProfile(username);
                // delete student
                int numberStudent = daoStudent.DeleteStudent(username);
                // update account
                int numberAccount = daoAccount.UpdateAccount(roleEdit, username);
                // add teacher
                Teacher teacher = new Teacher(student.getFullName(), student.getPhone(), student.getImage(), student.getEmail(), student.getGender(), username);
                int numberTeacher = daoTeacher.AddTeacher(teacher);
                // if add successful
                if (numberTeacher > 0) {
                    List<Account> list = daoAccount.GetAllAccount();
                    // set attribute
                    request.setAttribute("list", list);
                    request.setAttribute("message", "Update successful");
                    // dispatch
                    dispatch(request, response, "Admin.jsp");
                }

            } else {
                List<Account> list = daoAccount.GetAllAccount();
                // set attribute
                request.setAttribute("list", list);
                request.setAttribute("message", "Update successful");
                // dispatch
                dispatch(request, response, "Admin.jsp");
            }
        } else {
            String fullname = request.getParameter("FullName").trim();
            String phone = request.getParameter("phone");
            String email = request.getParameter("email").trim();
            String gender = request.getParameter("gender");
            String username = request.getParameter("username").trim();
            String password = request.getParameter("password");
            // if invalid phone
            if (!phone.isEmpty() && !phone.matches("^[0-9]{10}+$")) {
                // set attribute
                request.setAttribute("message", "Phone only number and length is 10");
                // dispatch
                dispatch(request, response, "AddAccount.jsp");
            } else {
                // if username exist
                if (daoAccount.CheckUsernameExist(username)) {
                    // set attribute
                    request.setAttribute("message", "Your account has existed");
                    // dispatch
                    dispatch(request, response, "AddAccount.jsp");
                } else {
                    if (phone.isEmpty()) {
                        phone = null;
                    }
                    Account account = new Account(username, password, "Teacher");
                    int numberAccount = daoAccount.AddAccount(account); 
                        Teacher teacher = new Teacher(fullname, phone, "https://i.pinimg.com/736x/75/ae/6e/75ae6eeeeb590c066ec53b277b614ce3.jpg", email, gender, username);
                        int numberTeacher = daoTeacher.AddTeacher(teacher);
                        // if add successful
                        if (numberTeacher > 0) {
                            request.setAttribute("mess", "Add Successful");
                            dispatch(request, response, "AddAccount.jsp");
                        }
                    
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
