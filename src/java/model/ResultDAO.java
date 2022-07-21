/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Result;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Windows
 */
public class ResultDAO extends DBConnect {

    public int insert(Result result) {
        int n = -1;
        try {
            String sql = "INSERT INTO [dbo].[Result]\n"
                    + "           ([LessonID]\n"
                    + "           ,[UserName]\n"
                    + "           ,[DateRecord]\n"
                    + "           ,[score]\n"
                    + "           ,[status])\n"
                    + "     VALUES\n"
                    + "           (?,?,GETDATE(),?,?)";

            //Đưa câu lệnh sql vào prepare để chuẩn bị thực thi
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, result.getLessonId());
            ps.setString(2, result.getUserName());
            ps.setFloat(3, result.getScore());
            ps.setString(4, result.getStatus());

            //Thực thi và trả về kết quả
            n = ps.executeUpdate();

        } catch (Exception ex) {
            Logger.getLogger(ResultDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public List<Result> getAllResult(int lessonId, String user) {
        List<Result> list = new ArrayList<>();
        try {
            String sql = "select top 1 r.*, l.LessonName, s.FullName from Lesson l, Result r, Student s\n"
                    + "where r.LessonID = l.LessonID and r.UserName = s.username and l.LessonID = "+lessonId+" and r.UserName = '"+user+"'\n"
                    + "order by r.ResultID DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Result result = new Result();
                result.setResultId(rs.getInt(1));
                result.setLessonId(rs.getInt(2));
                result.setUserName(rs.getString(3));
                result.setDate(rs.getDate(4));
                result.setScore(rs.getFloat(5));
                result.setStatus(rs.getString(6));
                result.setLessonName(rs.getString(7));
                result.setFullName(rs.getString(8));

                list.add(result);
            }
        } catch (Exception ex) {
            Logger.getLogger(ResultDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
  

}
