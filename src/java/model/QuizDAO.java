/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Quiz;
import java.io.IOException;
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
 * @author Windows
 */
public class QuizDAO extends DBConnect {

    public Quiz getQuizByID(int id) {
        try {
            String sql = "select * from Quiz\n"
                    + "where QuestionID = ?";

            //Đưa câu lệnh sql vào prepare để chuẩn bị thực thi
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            //Thực thi và trả về kết quả
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Quiz quiz = new Quiz();
                quiz.setId(rs.getInt(1));
                quiz.setQues((rs.getString(2)));
                quiz.setLessonId(rs.getInt(3));
                quiz.setAns1(rs.getString(4));
                quiz.setAns2(rs.getString(5));
                quiz.setAns3(rs.getString(6));
                quiz.setAns4(rs.getString(7));
                quiz.setCorrectAns(rs.getInt(8));
                return quiz;
            }
        } catch (Exception ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Vector<Quiz> listQuiz(String sql) {
        Vector<Quiz> list = new Vector<>();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Quiz quiz = new Quiz();
                quiz.setId(rs.getInt(1));
                quiz.setQues(rs.getString(2));
                quiz.setLessonId(rs.getInt(3));
                quiz.setAns1(rs.getString(4));
                quiz.setAns2(rs.getString(5));
                quiz.setAns3(rs.getString(6));
                quiz.setAns4(rs.getString(7));
                quiz.setCorrectAns(rs.getInt(8));
                list.add(quiz);
            }
        } catch (Exception ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public void insertQuiz(Quiz quiz) {
        try {
            String sql = "INSERT INTO [dbo].[Quiz]\n"
                    + "           ([Question]\n"
                    + "           ,[LessonID]\n"
                    + "           ,[Answer1]\n"
                    + "           ,[Answer2]\n"
                    + "           ,[Answer3]\n"
                    + "           ,[Answer4]\n"
                    + "           ,[AnswerCorrect])\n"
                    + "     VALUES\n"
                    + "           (?,?,?,?,?,?,?)";

            //Đưa câu lệnh sql vào prepare để chuẩn bị thực thi
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, quiz.getQues());
            ps.setInt(2, quiz.getLessonId());
            ps.setString(3, quiz.getAns1());
            ps.setString(4, quiz.getAns2());
            ps.setString(5, quiz.getAns3());
            ps.setString(6, quiz.getAns4());
            ps.setInt(7, quiz.getCorrectAns());

            //Thực thi và trả về kết quả
            ps.executeUpdate();

        } catch (Exception ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateQuiz(Quiz quiz) {
        try {
            String sql = "UPDATE [dbo].[Quiz]\n"
                    + "   SET [Question] = ?\n"
                    + "      ,[LessonID] = ?\n"
                    + "      ,[Answer1] = ?\n"
                    + "      ,[Answer2] = ?\n"
                    + "      ,[Answer3] = ?\n"
                    + "      ,[Answer4] = ?\n"
                    + "      ,[AnswerCorrect] = ?\n"
                    + " WHERE QuestionID = ?";

            //Đưa câu lệnh sql vào prepare để chuẩn bị thực thi
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, quiz.getQues());
            ps.setInt(2, quiz.getLessonId());
            ps.setString(3, quiz.getAns1());
            ps.setString(4, quiz.getAns2());
            ps.setString(5, quiz.getAns3());
            ps.setString(6, quiz.getAns4());
            ps.setInt(7, quiz.getCorrectAns());
            ps.setInt(8, quiz.getId());

            //Thực thi và trả về kết quả
            ps.executeUpdate();

        } catch (Exception ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteQuiz(int id) {
        try {
            String sql = "DELETE FROM [dbo].[Quiz]\n"
                    + "      WHERE QuestionID = ?";

            //Đưa câu lệnh sql vào prepare để chuẩn bị thực thi
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            //Thực thi và trả về kết quả
            ps.executeUpdate();

        } catch (Exception ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<Quiz> getAllQuizzes(int lessonId) {
        List<Quiz> list = new ArrayList<>();
        try {
            String sql = "select* from Quiz\n"
                    + "where LessonID = " + lessonId + "";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Quiz quiz = new Quiz();
                quiz.setId(rs.getInt(1));
                quiz.setQues(rs.getString(2));
                quiz.setLessonId(rs.getInt(3));
                quiz.setAns1(rs.getString(4));
                quiz.setAns2(rs.getString(5));
                quiz.setAns3(rs.getString(6));
                quiz.setAns4(rs.getString(7));
                quiz.setCorrectAns(rs.getInt(8));
                list.add(quiz);
            }
        } catch (Exception ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public Vector<Quiz> getAllLessonOfQuiz() {
        Vector<Quiz> list = new Vector<>();
        try {
            PreparedStatement ps = conn.prepareStatement("select distinct lessonID from Quiz");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Quiz(rs.getInt(1)));
            }
        } catch (Exception ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public static String getInt(String ans, int min, int max) {
        while (true) {
            try {
                int num;
                num = Integer.parseInt(ans);
                if (min <= num && num <= max) {
                    return "";
                } else {
                    return "Your fill is not correct";
                }
            } catch (NumberFormatException ex) {
                if (ans.trim().equals("")) {
                    return "You must be fill in the blank";
                }
                return "You must be fill";
            }
        }
    }
    
    // delete quiz based on lesson id
    public int DeleteQuiz(int LessonID) {
        int number = 0; // number of row affected
        String sql = "DELETE FROM [dbo].[Quiz]\n"
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