package model;

import entity.Courses;
import entity.Pay_Courses;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

public class DAOPayCourse extends DBConnect {

    // delete pay course based on  id
    public int DeletePayCourse(String ID, int value) {
        int number = 0; // number of row affected
        String sql = "DELETE FROM [dbo].[Pay_Course]\n"
                + "      WHERE [" + ID + "] = " + value;
        try {
            // create statement
            Statement statement = conn.createStatement();
            // execute sql
            number = statement.executeUpdate(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return number;
    }

    // get number of row
    public int GetNumberOfRow() {
        int row = 0;
        String sql = "SELECT * FROM [dbo].[Pay_Course]";
        ResultSet result = getData(sql);
        try {
            // loop for traverse all courses 
            while (result.next()) {
                row++;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return row;
    }

    // get course id
    public int[] getCourseID(int StudentID) {
        int row = GetNumberOfRow();
        int ID[] = new int[row];
        int i = 0;
        String sql = "SELECT [CourseID]\n"
                + "FROM [dbo].[Pay_Course]\n"
                + "where [StudentID] = " + StudentID;
        // get data
        ResultSet result = getData(sql);
        try {
            // loop for traverse all row
            if (result.next()) {
                ID[i] = result.getInt(1);
                i++;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return ID;
    }
    // get list pay course
    public List<Pay_Courses> GetListPayCourse(List<Courses> listCourse) {
        List<Pay_Courses> list = new ArrayList<>();
        // loop for traverse all list course
        for (Courses course : listCourse) {
            String sql = "SELECT * FROM [dbo].[Pay_Course] where [CourseID] = " + course.getCourseID();
            // get data
            ResultSet result = getData(sql);
            try {
                // loop for traverse all row
                while (result.next()) {
                    String PayID = result.getString(1);
                    String date = result.getString(2);
                    String type = result.getString(3);
                    String StudentID = result.getString(5);
                    Pay_Courses pay = new Pay_Courses(PayID, date, type, String.valueOf(course.getCourseID()), StudentID);
                    list.add(pay);
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return list;
    }

}
