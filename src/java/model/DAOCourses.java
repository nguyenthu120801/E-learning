/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Courses;
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
 * @author nanht
 */
public class DAOCourses extends DBConnect {

   final static  private int numberOfCoursesInPage = 6;

    public Vector<Courses> getAllCourses() {
        Vector<Courses> vector = new Vector<Courses>();
        String sql = "select c.*, t.FullName from Course c, Teacher t\n"
                + "where c.TeacherID = t.ID";
        vector = addToVector(sql);
        return vector;
    }

    public Vector<Courses> getCoursesInPage(int page) {
        Vector<Courses> vector = new Vector<Courses>();
        String sql = "select c.*, t.FullName from Course c, Teacher t\n"
                + "               where c.TeacherID = t.ID \n"
                + "	order by c.CourseID\n"
                + "	offset (" + numberOfCoursesInPage + "*" + (page - 1) + ") row fetch next " + numberOfCoursesInPage + " row only";
        vector = addToVector(sql);
        return vector;
    }

    public Vector<Courses> getCoursesInPageWithCategory(int categoryID, int page) {
        Vector<Courses> vector = new Vector<Courses>();
        String sql = "select c.*, t.FullName from Course c, Teacher t\n"
                + "               where c.TeacherID = t.ID  and c.CategoryID = " + categoryID + "  \n"
                + "		order by c.CourseID\n"
                + "		offset (" + numberOfCoursesInPage + "*" + (page - 1) + ") row fetch next " + numberOfCoursesInPage + " row only";
        vector = addToVector(sql);
        return vector;
    }

    public Vector<Courses> getCourseByID(int id) {
        Vector<Courses> vector = new Vector<Courses>();
        String sql = "select c.*, t.FullName from Course c, Teacher t\n"
                + "where c.TeacherID = t.ID and CourseID = " + id + "";
        vector = addToVector(sql);
        return vector;
    }

    public Vector<Courses> getCourseByName(String name) {
        String sql = "select c.*, t.FullName from Course c, Teacher t"
                + " where c.TeacherID = t.ID and c.CourseName like '%" + name + "%'";
        return addToVector(sql);
    }

    public Vector<Courses> getCourseByTeacherID(int TeacherID) {
        String sql = "select c.*, t.FullName from Course c, Teacher t\n"
                + "where c.TeacherID = t.ID and TeacherID = " + TeacherID + "";
        return addToVector(sql);
    }

    public Vector<Courses> getCoursesByCategory(String id) {
        Vector<Courses> vector = null;
        String sql = "select c.*, t.FullName from Course c, Teacher t\n"
                + "where c.TeacherID = t.ID and CategoryID = " + id + "";
        vector = addToVector(sql);
        return vector;
    }

    public int maxCurrentCourseID() {
        String sql = "select max(courseID) from Course";
        ResultSet rs = getData(sql);
        int maxCurrentCourseID = 0;
        try {
            if (rs.next()) {
                maxCurrentCourseID = rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return maxCurrentCourseID;
    }

    public static Vector<Courses> addToVector(String sql) {
        Vector<Courses> vector = new Vector<Courses>();
        ResultSet rs = getData(sql);
        try {
            while (rs.next()) {
                int courseID = rs.getInt(1);
                String courseName = rs.getString(2);
                String image = rs.getString(3);
                double price = rs.getDouble(4);
                int categoryID = rs.getInt(5);
                int teacherID = rs.getInt(6);
                String description = rs.getString(7);
                String teacherName = rs.getString(8);
                Courses course = new Courses(courseID, courseName, image, price, categoryID, teacherID, description, teacherName);
                vector.add(course);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return vector;
    }

    public void addCourse(Courses c) {
        String sql = "INSERT INTO [dbo].[Course]\n"
                + "           ([CourseName]\n"
                + "           ,[image]\n"
                + "           ,[price]\n"
                + "           ,[CategoryID]\n"
                + "           ,[TeacherID]\n"
                + "           ,[description])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?)";
        addQuery(c, sql);
        System.out.println("Add Course Successful!");
    }

    public void updateCourse(Courses c) {
        String sql = "UPDATE [dbo].[Course]\n"
                + "   SET [CourseName] = ?\n"
                + "      ,[image] = ?\n"
                + "      ,[price] = ?\n"
                + "      ,[CategoryID] = ?\n"
                + "      ,[TeacherID] = ?\n"
                + "      ,[description] = ?\n"
                + " WHERE [CourseID] = ?";

        updateQuery(c, sql);
    }

    public int deleteCourse(int CourseID) {
        int n = 0;
        String sql = "DELETE FROM [dbo].[Course]\n"
                + "      WHERE [CourseID] = " + CourseID + "";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
          n =   pre.executeUpdate();
          
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
          return n;
    }

    public static Vector<Courses> getAllCoursesByName(String flow, int page) {
        Vector<Courses> vector = new Vector<Courses>();
        String sql = "select c.*, t.FullName from Course c, Teacher t where c.TeacherID = t.ID\n"
                + "order by c.CourseName " + flow + "\n"
                + "		offset (" + numberOfCoursesInPage + "*" + (page - 1) + ") row fetch next " + numberOfCoursesInPage + " row only";
        vector = addToVector(sql);
        return vector;
    }
    
     public static Vector<Courses> getCoursesByUsername(String username) {
                Vector<Courses> vector = new Vector<Courses>();
        String sql = "select c.*, s.ID studentid from Course c, student s, Pay_Course pc  where s.username = '" + username + "'\n"
                + "and c.CourseID = pc.CourseID and pc.StudentID = s.ID";
                ResultSet rs = getData(sql);

         try {
            while (rs.next()) {
                int courseID = rs.getInt(1);
                String courseName = rs.getString(2);
                String image = rs.getString(3);
                double price = rs.getDouble(4);
                int categoryID = rs.getInt(5);
                int teacherID = rs.getInt(6);
                String description = rs.getString(7);
                int studentID = rs.getInt(8);
                Courses course = new Courses(courseID, courseName, image, price, categoryID, teacherID, description, studentID);
                vector.add(course);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return vector;
    }


    // sort all course by price then add to vector
    public static Vector<Courses> getAllCoursesByPrice(String flow, int page) {

        Vector<Courses> vector = new Vector<Courses>();
        String sql = "select c.*, t.FullName from Course c, Teacher t where c.TeacherID = t.ID\n"
                + "order by c.price " + flow + "\n"
                + "		offset (" + numberOfCoursesInPage + "*" + (page - 1) + ") row fetch next " + numberOfCoursesInPage + " row only";

        vector = addToVector(sql);
        return vector;
    }

    public static Vector<Courses> get3CoursesByPrice(String flow) {
        Vector<Courses> vector = new Vector<Courses>();
        String sql = "select top 3 c.*, t.FullName from Course c, Teacher t where c.TeacherID = t.ID\n"
                + "order by c.price " + flow;

        vector = addToVector(sql);
        return vector;
    }

    public int updateQuery(Courses c, String sql) {
        int n = -1;
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, c.getCourseName());
            pre.setString(2, c.getImage());
            pre.setDouble(3, c.getPrice());
            pre.setInt(4, c.getCategoryID());
            pre.setInt(5, c.getTeacherID());
            pre.setString(6, c.getDescription());
            pre.setInt(7, c.getCourseID());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int addQuery(Courses c, String sql) {
        int n = -1;
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, c.getCourseName());
            pre.setString(2, c.getImage());
            pre.setDouble(3, c.getPrice());
            pre.setInt(4, c.getCategoryID());
            pre.setInt(5, c.getTeacherID());
            pre.setString(6, c.getDescription());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public Vector<Courses> getCourseByIDstudent(int id) {
        Vector<Courses> vector = new Vector<Courses>();
        DAOTeacher dao = new DAOTeacher();
        String sql = "select distinct  c.CourseID,c.CourseName,c.image,c.price,c.CategoryID,c.TeacherID,c.description from Course c, Pay_Course t\n"
                + "  where c.CourseID = t.CourseID and StudentID =" + id;

        ResultSet rs = getData(sql);
        try {
            while (rs.next()) {
                int courseID = rs.getInt(1);
                String courseName = rs.getString(2);
                String image = rs.getString(3);
                double price = rs.getDouble(4);
                int categoryID = rs.getInt(5);
                int teacherID = rs.getInt(6);
                String description = rs.getString(7);
                String teacher = dao.getname(teacherID);

                Courses course = new Courses(courseID, courseName, image, price, categoryID, teacherID, description, teacher);
                vector.add(course);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return vector;

    }

    // get course based on course id
    public Courses getCourse(int CourseID) {
        String sql = "SELECT * FROM [dbo].[Course]\n"
                + "WHERE [CourseID]= " + CourseID;
        ResultSet result = getData(sql);
        try {
            // if get data successful
            if (result.next()) {
                String CourseName = result.getString(2);
                String image = result.getString(3);
                double price = result.getDouble(4);
                int CategoryID = result.getInt(5);
                int TeacherID = result.getInt(6);
                String description = result.getString(7);
                Courses course = new Courses(CourseName, image, price, CategoryID, TeacherID, description);
                return course;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public List<Courses> GetListCourse(int[] CourseID) {
        List<Courses> list = new ArrayList<>();
        // loop for traverse all course id
        for (int ID : CourseID) {
            Courses course = getCourse(ID);
            list.add(course);
        }
        return list;
    }
    public int numberOfPageInTeacherCourses(int teacherID) {
        String sql = "select count(c.CourseID) from Course c where c.TeacherID = "+teacherID+"";
        return countNumberOfPage(sql);
    }
    public Vector<Courses> getTeacherCoursesInPage(int page, int teacherID) {
        Vector<Courses> vector = new Vector<Courses>();
        String sql = "select c.*, t.FullName from Course c, Teacher t\n"
                + "               where c.TeacherID = t.ID and TeacherID = "+teacherID+" \n"
                + "	order by c.CourseID\n"
                + "	offset (" + numberOfCoursesInPage + "*" + (page - 1) + ") row fetch next " + numberOfCoursesInPage + " row only";
        vector = addToVector(sql);
        return vector;
    }
    // get list course based on teacher id

    public List<Courses> GetListCourse(int TeacherID) {
        List<Courses> list = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[Course]\n"
                + "where [TeacherID] = " + TeacherID;
        ResultSet result = getData(sql);
        try {
            // loop for traverse all courses 
            while (result.next()) {
                int CourseID = result.getInt(1);
                String CourseName = result.getString(2);
                String image = result.getString(3);
                double price = result.getDouble(4);
                int CategoryID = result.getInt(5);
                String description = result.getString(7);
                Courses course = new Courses(CourseID, CourseName, image, price, CategoryID, TeacherID, description);
                list.add(course);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // delete course based on teacher id
    public int DeleteCourse(int TeacherID) {
        int number = 0; // number of row affected
        String sql = "DELETE FROM [dbo].[Course]\n"
                + "      WHERE [TeacherID] = " + TeacherID;
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

    public int numberOfPage() {
        String sql = "select count(c.CourseID) from Course c";
        return countNumberOfPage(sql);
    }

    public int numberOfPageWithCategory(String categoryID) {
        String sql = "select count(*) from course c\n"
                + "where c.CategoryID = " + categoryID + "";
        return countNumberOfPage(sql);
    }

    private static int countNumberOfPage(String sql) {
        double numberOfCourses = 0;

        ResultSet rs = getData(sql);
        try {
            if (rs.next()) {
                numberOfCourses = rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        if (numberOfCourses <= numberOfCoursesInPage) {
            return 1;
        } else if ((numberOfCourses / numberOfCoursesInPage) > (Math.round(numberOfCourses / numberOfCoursesInPage))) {
            numberOfCourses = Math.floor(numberOfCourses / numberOfCoursesInPage) + 1;
        } else {
            numberOfCourses = Math.round(numberOfCourses / numberOfCoursesInPage);

        }

        return (int) numberOfCourses;
    }

    public static void main(String[] args) {
        DAOCourses dao = new DAOCourses();
//        Vector<Courses> vectorCourse = dao.getAllCoursesByPrice("desc");
//        for(Courses course : vectorCourse){
//            System.out.println(course);
//        }
//         dao.addCourse(new Courses("Change No thing in leg", "https://media.istockphoto.com/vectors/light-bulb-world-map-eco-friendly-concept-vector-illustration-vector-id1155073585?k=20&m=1155073585&s=612x612&w=0&h=YpeBtKcqiG5AnFSuxs2NCBjdE5liH2EKY6TT-jLXP24=", 
//                  50, 3, 1, "Fortune’s Change the World list honors companies that use the creative tools of capitalism—including the profit motive—to address society’s unmet needs."));
        //   System.out.println(dao.getAllCourses());
        System.out.println(dao.numberOfPageWithCategory("3"));
    }
}
