package model;

import entity.Teacher;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

public class DAOTeacher extends DBConnect {

    // add teacher
    public int AddTeacher(Teacher teacher) {
        int number = 0; // number of row affected
        String sql = "INSERT INTO [dbo].[Teacher]\n"
                + "           ([FullName]\n"
                + "           ,[phone]\n"
                + "           ,[image]\n"
                + "           ,[email]\n"
                + "           ,[gender]\n"
                + "           ,[username])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?)";
        try {
            // create prepare statement
            PreparedStatement prepare = conn.prepareStatement(sql);
            // set value for ?
            prepare.setString(1, teacher.getFullName());
            prepare.setString(2, teacher.getPhone());
            prepare.setString(3, teacher.getImage());
            prepare.setString(4, teacher.getEmail());
            prepare.setString(5, teacher.getGender());
            prepare.setString(6, teacher.getUsername());
            // execute sql
            number = prepare.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return number;
    }

    // delete teacher
    public int DeleteTeacher(String username) {
        int number = 0; // number of row affected
        String sql = "DELETE FROM [dbo].[Teacher]\n"
                + "      WHERE [username]='" + username + "'";
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

    public String getname(int id) {
        String ID = null;
        String sql = "SELECT [FullName] FROM [dbo].[Teacher]\n"
                + "where [ID] = " + id;
        // get data
        ResultSet result = getData(sql);
        try {
            // if get data successful
            if (result.next()) {
                ID = result.getString(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return ID;
    }

    // get id from username
    public int getID(String username) {
        int ID = 0;
        String sql = "SELECT [ID] FROM [dbo].[Teacher]\n"
                + "where [username] = '" + username + "'";
        // get data
        ResultSet result = getData(sql);
        try {
            // if get data successful
            if (result.next()) {
                ID = result.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return ID;
    }

    // get profile
    public Teacher getProfile(String username) {
        String sql = "SELECT * FROM [dbo].[Teacher]\n"
                + "WHERE [username] ='" + username + "'";
        // get data
        ResultSet result = getData(sql);
        try {
            // if get data successful
            if (result.next()) {
                String FullName = result.getString(2);
                String phone = result.getString(3);
                String image = result.getString(4);
                String email = result.getString(5);
                String gender = result.getString(6);
                Teacher teacher = new Teacher(FullName, phone, image, email, gender, username);
                return teacher;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public Teacher getTeacherInfoByUsername(String username) {

        String sql = "select t.*, a.RoleName from Teacher t, Account a\n"
                + "where a.username = t.username and t.username = '" + username + "'";
        // get data
        ResultSet result = getData(sql);
        try {
            // if get data successful
            if (result.next()) {
                int ID = result.getInt(1);
                String FullName = result.getString(2);
                String phone = result.getString(3);
                String image = result.getString(4);
                String email = result.getString(5);
                String gender = result.getString(6);
                String roleName = result.getString(7);
                Teacher teacher = new Teacher(ID, FullName, phone, image, email, gender, username, roleName);
                return teacher;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    // get all teacher
    public List<Teacher> GetAllTeacher() {
        List<Teacher> list = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[Teacher]";
        // get data
        ResultSet result = getData(sql);
        try {
            // loop for traverse all row
            while (result.next()) {
                String FullName = result.getString(2);
                String phone = result.getString(3);
                String image = result.getString(4);
                String email = result.getString(5);
                String gender = result.getString(6);
                String username = result.getString(7);
                Teacher teacher = new Teacher(FullName, phone, image, email, gender, username);
                list.add(teacher);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }
    // get top 4 teacher

    public List<Teacher> GetTop4Teacher() {
        List<Teacher> list = new ArrayList<>();
        String sql = "SELECT TOP 4* FROM [dbo].[Teacher]";
        // get data
        ResultSet result = getData(sql);
        try {
            // loop for traverse all row
            while (result.next()) {
                String FullName = result.getString(2);
                String phone = result.getString(3);
                String image = result.getString(4);
                String email = result.getString(5);
                String gender = result.getString(6);
                String username = result.getString(7);
                Teacher teacher = new Teacher(FullName, phone, image, email, gender, username);
                list.add(teacher);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }
    // update teacher

    public int UpdateTeacher(Teacher teacher) {
        int number = 0;// number of row affected
        String sql = "UPDATE [dbo].[Teacher]\n"
                + "   SET [FullName] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[image] = ?\n"
                + "      ,[email] = ?\n"
                + "      ,[gender] = ?\n"
                + " WHERE [username] = ?";
        try {
            // create prepare statement
            PreparedStatement prepare = conn.prepareStatement(sql);
            // set value for ?
            prepare.setString(1, teacher.getFullName());
            prepare.setString(2, teacher.getPhone());
            prepare.setString(3, teacher.getImage());
            prepare.setString(4, teacher.getEmail());
            prepare.setString(5, teacher.getGender());
            prepare.setString(6, teacher.getUsername());
            // execute sql
            number = prepare.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return number;
    }

    public static void main(String[] args) {
        Teacher teacher = new DAOTeacher().getTeacherInfoByUsername("");
    }

}
