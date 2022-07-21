/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Lesson;
import entity.LessonPDF;
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
public class DAOLessonPDF extends DBConnect {

    public int addPDF(LessonPDF pdf) {
        int n = 0;
        String sql = "INSERT INTO [dbo].[LessonPDF]\n"
                + "           ([PDFName]\n"
                + "           ,[FilePDF]\n"
                + "           ,[LessonID])\n"
                + "     VALUES\n"
                + "           (?,?,?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            //set value for ?
            // index start 1
            pre.setString(1, pdf.getPdfName());
            pre.setString(2, pdf.getFilePDF());
            pre.setInt(3, pdf.getLessonID());
            // run
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int deletePDF(int pdfID) {
        int n = 0;
        String sql = "delete from LessonPDF where [PDFID]= '" + pdfID + "'";
        // check foreign key costain
        try {
            Statement state = conn.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int updatePDF(LessonPDF pdf) {
        int n = 0;
        String sql = "UPDATE [dbo].[LessonPDF]\n"
                + "   SET [PDFName] = ?\n"
                + "      ,[FilePDF] = ?\n"
                + " WHERE [PDFID] = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, pdf.getPdfName());
            pre.setString(2, pdf.getFilePDF());
            pre.setInt(3, pdf.getPdfID());

            n = pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public Vector<LessonPDF> ListAll(String sql) {
        Vector<LessonPDF> vector = new Vector();
        try {
            ResultSet rs = getData(sql);
            while (rs.next()) {
                int PDFID = rs.getInt(1);
                String pdfName = rs.getString(2);
                String filePDF = rs.getString(3);
                int lessonID = rs.getInt(4);
//                String videoName = rs.getString(4);
//                String pdfName = rs.getString(5);
                LessonPDF lesson = new LessonPDF(PDFID, pdfName, filePDF, lessonID);
                vector.add(lesson);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOLesson.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public boolean CheckPDFNameExsit(String pdfName, int id) {
        ResultSet rs = getData("select * from lessonPDF where pdfName = '" + pdfName + "' and lessonID =" + id);
        try {
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean CheckPDFFileExsit(String videoFile, int id) {
        ResultSet rs = getData("select * from lessonPDF where filePDF = '" + videoFile + "' and lessonID =" + id);
        try {
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getMinPDFIDByLessonID(int lessonID) {
        ResultSet rs = getData("select min(pdfID) from lessonPDF where lessonID =" + lessonID);
        int pdfID = 0;
        try {
            if (rs.next()) {
                pdfID = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pdfID;
    }

    public int getMaxPDFIDByLessonID(int lessonID) {
        ResultSet rs = getData("select max(pdfID) from lessonPDF where lessonID =" + lessonID);
        int pdfID = 0;
        try {
            if (rs.next()) {
                pdfID = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pdfID;
    }

    public int getMaxPdfIDInCourse(int courseID) {
        ResultSet rs = getData("select max(pdfID) from lessonPDF where lessonID = (select max(lessonID) from Lesson where CourseID = " + courseID + ")");
        int pdfID = 0;
        try {
            if (rs.next()) {
                pdfID = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOLessonVideo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return pdfID;
    }

    public int getLessonIDByPDFID(int pdfID) {
        ResultSet rs = getData("Select lessonID from LessonPDF where pdfID =" + pdfID);
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
    
    // delete lesson pdf based on lesson id

    public int DeleteLessonPDF(int LessonID) {
        int number = 0; // number of row affected
        String sql = "DELETE FROM [dbo].[LessonPDF]\n"
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
