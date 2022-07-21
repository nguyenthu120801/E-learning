/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Lesson;
import entity.LessonVideo;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author chuqu
 */
public class DAOLessonVideo extends DBConnect {

    public int addVideo(LessonVideo video) {
        int n = 0;
        String sql = "INSERT INTO [dbo].[LessonVideo]\n"
                + "           ([VideoName]\n"
                + "           ,[FileVideo]\n"
                + "           ,[LessonID])\n"
                + "     VALUES\n"
                + "           (?,?,?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            //set value for ?
            // index start 1
            //pre.setInt(1, video.getVideoID());
            pre.setString(1, video.getVideoName());
            pre.setString(2, video.getFileVideo());
            pre.setInt(3, video.getLessonID());
            // run
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int deleteVideo(int videoID) {
        int n = 0;
        String sql = "delete from LessonVideo where [VideoID]= " + videoID + "";
        // check foreign key costain
        try {
            Statement state = conn.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int updateVideo(LessonVideo video) {
        int n = 0;
        String sql = "UPDATE [dbo].[LessonVideo]\n"
                + "   SET [VideoName] = ?\n"
                + "      ,[FileVideo] = ?\n"
                + " WHERE [VideoID] = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, video.getVideoName());
            pre.setString(2, video.getFileVideo());
            pre.setInt(3, video.getVideoID());

            n = pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public Vector<LessonVideo> ListAll(String sql) {
        Vector<LessonVideo> vector = new Vector();
        try {
            ResultSet rs = getData(sql);
            while (rs.next()) {
                int videoID = rs.getInt(1);
                String videoName = rs.getString(2);
                String videoFile = rs.getString(3);
                int lessonID = rs.getInt(4);
                LessonVideo video = new LessonVideo(videoID, videoName, videoFile, lessonID);
                vector.add(video);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOLesson.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public boolean CheckVideoNameExsit(String videoName, int id) {
        ResultSet rs = getData("select * from lessonVideo where videoName = '" + videoName + "' and lessonID =" + id);
        try {
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean CheckVideoFileExsit(String videoFile, int id) {
        ResultSet rs = getData("select * from lessonVideo where fileVideo = '" + videoFile + "' and lessonID =" + id);
        try {
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getMinVideoIDByCourseID(int courseID) {
        ResultSet rs = getData("select min(videoID) from lessonVideo where lessonID = (select min(lessonID) from Lesson where CourseID = " + courseID + ")");
        int videoID = 0;
        try {
            if (rs.next()) {
                videoID = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return videoID;
    }

    public int getMaxVideoIDByCourseID(int courseID) {
        ResultSet rs = getData("select max(videoID) from lessonVideo where lessonID = (select max(lessonID) from Lesson where CourseID = " + courseID + ")");
        int videoID = 0;
        try {
            if (rs.next()) {
                videoID = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return videoID;
    }

    public boolean checkMaxPdfIDInCourse(int courseID) {
        ResultSet rs = getData("select max(pdfID) from lessonPDF where lessonID = (select max(lessonID) from Lesson where CourseID = " + courseID + ")");
        try {
            if (rs.next()) {
                if(rs.getString(1) != null){
                    return true;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOLessonVideo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    // delete lesson video based on lesson id
    public int DeleteLessonVideo(int LessonID) {
        int number = 0; // number of row affected
        String sql = "DELETE FROM [dbo].[LessonVideo]\n"
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
    
    public String getVideoByID(int videoID) {
        ResultSet rs = getData("select fileVideo from lessonVideo where videoID =" + videoID);
        String fileVideo = null;
        try {
            if (rs.next()) {
                fileVideo = rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fileVideo;
    }

//    public static void main(String[] args) {
//        DAOLessonVideo dao = new DAOLessonVideo();
//        dao.deleteVideo(79);
//    }
}
