package model;

import entity.Student;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;
import model.DBConnect;

public class DAOStudent extends DBConnect {

    // add student
    public int AddStudent(Student student) {
        int number = 0;
        String sql = "INSERT INTO [dbo].[Student]\n"
                + "           ([FullName]\n"
                + "           ,[phone]\n"
                + "           ,[address]\n"
                + "           ,[image]\n"
                + "           ,[email]\n"
                + "           ,[gender]\n"
                + "           ,[username]\n"
                + "           ,[DateOfBirth])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?,?,?)";
        try {
            // create prepare statement
            PreparedStatement prepare = conn.prepareStatement(sql);
            // set value for ?
            prepare.setString(1, student.getFullName());
            prepare.setString(2, student.getPhone());
            prepare.setString(3, student.getAddress());
            prepare.setString(4, student.getImage());
            prepare.setString(5, student.getEmail());
            prepare.setString(6, student.getGender());
            prepare.setString(7, student.getUsername());
            prepare.setString(8, student.getDOB());
            // execute sql
            number = prepare.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return number;
    }

    public Vector<Student> GetStudentByID(int id) {
        Vector<Student> es = new Vector<Student>();
        String sql = "SELECT * FROM [dbo].[Student] where ID =" + id;
        ResultSet result = getData(sql);
        try {
            // loop for traverse through all account
            while (result.next()) {
                int ID = result.getInt(1);
                String fullname = result.getString(2);
                String phone = result.getString(3);
                String address = result.getString(4);
                String img = result.getString(5);
                String email = result.getString(6);
                String gender = result.getString(7);
                String username = result.getString(8);
                String Dob = result.getString(9);

                Student a = new Student(id, fullname, phone, address, img, email, gender, username, Dob);
                es.add(a);

            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return es;
    }

    // delete student
    public int DeleteStudent(String username) {
        int number = 0; // number of row affected
        String sql = "DELETE FROM [dbo].[Student]\n"
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

    // get id
    public int getID(String username) {
        int ID = 0;
        String sql = "SELECT [ID] FROM [dbo].[Student]\n"
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

    public int getAccountID(String username) {
        int ID = 0;
        String sql = "SELECT [ID] FROM [dbo].[Account]\n"
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
    public Student getProfile(String username) {
        String sql = "SELECT * FROM [dbo].[Student]\n"
                + "WHERE [username] ='" + username + "'";
        // get data
        ResultSet result = getData(sql);
        try {
            // if get data successful
            if (result.next()) {
                String FullName = result.getString(2);
                String phone = result.getString(3);
                String address = result.getString(4);
                String image = result.getString(5);
                String email = result.getString(6);
                String gender = result.getString(7);
                String DOB = result.getString(9);
                Student student = new Student(FullName, phone, address, image, email, gender, username, DOB);
                return student;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public int updateStudent(Student a) {
        int n = -1;
        String sql = "UPDATE [dbo].[Student]\n"
                + "   SET [FullName] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[address] = ?\n"
                + "      ,[image] = ?\n"
                + "      ,[email] = ?\n"
                + "      ,[gender] = ?\n"
                + "      ,[username] = ?\n"
                + " WHERE ID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, a.getFullName());
            pre.setString(2, a.getPhone());
            pre.setString(3, a.getAddress());
            pre.setString(4, a.getImage());
            pre.setString(5, a.getEmail());
            pre.setBoolean(6, a.isGender());
            pre.setString(7, a.getUsername());
            pre.setInt(8, a.getID());

            n = pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    // update student
    public int UpdateStudent(Student student) {
        int number = 0; // number of row affected
        String sql = "UPDATE [dbo].[Student]\n"
                + "SET [FullName] = ?,\n"
                + "[phone] = ?,\n"
                + "[address] =?,\n"
                + "[image] = ?,\n"
                + "[email] = ?,\n"
                + "[gender] = ?,\n"
                + "[DateOfBirth] = ?\n"
                + "WHERE [username] = ?";
        try {
            // create prepare statement
            PreparedStatement prepare = conn.prepareStatement(sql);
            // set value for ?
            prepare.setString(1, student.getFullName());
            prepare.setString(2, student.getPhone());
            prepare.setString(3, student.getAddress());
            prepare.setString(4, student.getImage());
            prepare.setString(5, student.getEmail());
            prepare.setString(6, student.getGender());
            prepare.setString(7, student.getDOB());
            prepare.setString(8, student.getUsername());
            // execute sql
            number = prepare.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return number;
    }

    public static void main(String[] args) {
//        Student student = new DAOStudent().getProfile("MinhDuc");
//        System.out.println(student.getImage());

    }
}
