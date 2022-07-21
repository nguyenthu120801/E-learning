/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Account;
import entity.Courses;
import entity.Student;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
//import java.util.Date;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Vector;

/**
 *
 * @author Vuong
 */

public class DAOup extends DBConnect {

    public int Addpay(int c, int b) {
        Date date = new Date();

        LocalDate date2 = java.time.LocalDate.now();
        String d = date2.toString();
        int n = 0;
        String sql = "INSERT INTO [dbo].[Pay_Course]\n"
                + "("
                + "           [Date]\n"
                + "           ,[type]\n"
                + "           ,[CourseID]\n"
                + "           ,[StudentID])\n"
                + "     VALUES"
                + "           (?,?,?,?)";
     

        try {
            // create prepare statement
            PreparedStatement prepare = conn.prepareStatement(sql);
            // set value for ?

            prepare.setString(1, d);
            prepare.setString(2, "card");
            prepare.setInt(3, b);
            prepare.setInt(4, c);
            // execute sql
            n = prepare.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public static void main(String[] args) {
        DAOup o = new DAOup();
        DAOStudent o2 = new DAOStudent();
//        Courses s=o.GetCourse(1);
//          System.out.println(s);
        DAOCourses dao = new DAOCourses();
        Vector<Courses> a = dao.getCourseByID(2);
        for (Courses courses : a) {
            System.out.println(courses);
        }

        int w = o2.getAccountID("VuongDepTrai");
        int q = o.Addpay(w, 1);
        if (q > 0) {
            System.out.println("ok");
        }

    }

}
