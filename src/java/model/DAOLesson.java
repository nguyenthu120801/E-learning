/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Courses;
import entity.Lesson;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author chuqu
 */
public class DAOLesson extends DBConnect {

    public int AddLesson(Lesson lesson) {
        int n = 0;
        String sql = "INSERT INTO [dbo].[Lesson]\n"
                + "           ([LessonName]\n"
                + "           ,[CourseID]\n"
                + "           ,[LessonNo])\n"
                + "     VALUES\n"
                + "           (?,?,?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);

            pre.setString(1, lesson.getLessonName());
            pre.setInt(2, lesson.getCourseID());
            pre.setInt(3, lesson.getLessonNo());
            // run
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int removeLesson(int lessonID) {
        int n = 0;
        String sql = "delete from Lesson where LessonID= " + lessonID + "";
        // check foreign key costain
        try {
            Statement state = conn.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int updateLesson(Lesson lesson) {
        int n = 0;
        String sql = "UPDATE [dbo].[Lesson]\n"
                + "   SET [LessonName] = ?,\n"
                + " [LessonNo] = ?\n"
                + " WHERE [LessonID] = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            //set value for ?
            // index start 1
            pre.setString(1, lesson.getLessonName());
            pre.setInt(2, lesson.getLessonNo());
            pre.setInt(3, lesson.getLessonID());
            // run
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public Vector<Lesson> getLessonByCourseID(int id) {
        String sql = "select * from Lesson where CourseID = " + id + "";
        return addToVector(sql);

    }

    public Vector<Lesson> addToVector(String sql) {
        Vector<Lesson> vector = new Vector<Lesson>();
        ResultSet rs = getData(sql);
        try {
            while (rs.next()) {
                int lessonID = rs.getInt(1);
                String lessonName = rs.getString(2);
                int courseID = rs.getInt(3);
                int lessonNo = rs.getInt(4);
                Lesson lesson = new Lesson(lessonID, lessonName, courseID, lessonNo);
                vector.add(lesson);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return vector;
    }

    public boolean CheckLessonNameExsit(String lessonName, int id) {
        ResultSet rs = getData("select * from lesson where lessonName = '" + lessonName + "' and CourseID =" + id);
        try {
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean CheckLessonExistInCourse(int courseID) {
        String sql = "SELECT * FROM [dbo].[Lesson] \n"
                + "where [CourseID] = " + courseID;
        // get data
        ResultSet result = getData(sql);
        try {
            // loop for traverse all lessons
            if (result.next()) {
                return true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public boolean CheckLessonNoExsit(int lessonNo, int id, int oldLessonNo) {
        ResultSet rs = getData("select * from lesson where lessonNo = " + lessonNo + " and CourseID =" + id + " and LessonNo != " + oldLessonNo + "");
        try {
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getLessonIDByVideoID(int videoID) {
        ResultSet rs = getData("Select lessonID from LessonVideo where videoID =" + videoID);
        int lessonID = 0;
        try {
            if (rs.next()) {
                lessonID = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOLesson.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lessonID;
    }

    public int getMaxVideoIDByLessonID(int lessonID) {
        ResultSet rs = getData("Select max(videoID) from LessonVideo where lessonID =" + lessonID);
        int maxVideoID = 0;
        try {
            if (rs.next()) {
                maxVideoID = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOLesson.class.getName()).log(Level.SEVERE, null, ex);
        }
        return maxVideoID;
    }

    public boolean checkLessonIDExist(int lessonID) {
        ResultSet rs = getData("select * from lessonPDF where lessonID = " + lessonID + "");
        try {
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {

    }

    public int getMinVideoIDByLessonID(int lessonID) {
        ResultSet rs = getData("Select min(videoID) from LessonVideo where lessonID =" + lessonID);
        int minVideoID = 0;
        try {
            if (rs.next()) {
                minVideoID = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOLesson.class.getName()).log(Level.SEVERE, null, ex);
        }
        return minVideoID;
    }

    // get list lesson based on list course
    public List<Lesson> GetListLesson(List<Courses> listCourse) {
        List<Lesson> listLesson = new ArrayList<>();
        // loop for traverse through all course
        for (Courses course : listCourse) {
            String sql = "SELECT * FROM [dbo].[Lesson] \n"
                    + "where [CourseID] = " + course.getCourseID();
            // get data
            ResultSet result = getData(sql);
            try {
                // loop for traverse all lessons
                while (result.next()) {
                    int LessonID = result.getInt(1);
                    String LessonName = result.getString(2);
                    int LessonNo = result.getInt(4);
                    Lesson lesson = new Lesson(LessonID, LessonName, course.getCourseID(), LessonNo);
                    listLesson.add(lesson);
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return listLesson;
    }

    // delete lesson based on lesson id
    public int DeleteLesson(int LessonID) {
        int number = 0; // number of row affected
        String sql = "DELETE FROM [dbo].[Lesson]\n"
                + "      WHERE [LessonID] = " + LessonID;
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
}
