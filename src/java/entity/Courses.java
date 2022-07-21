/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author nanht
 */
public class Courses {

    int courseID;
    String courseName;
    String image;
    double price;
    int categoryID;
    int teacherID;
    String description;
    String teacherName;
    int studentID;

    public Courses() {
    }

    public Courses(String courseName, String image, double price, int categoryID, int teacherID, String description) {
        this.courseName = courseName;
        this.image = image;
        this.price = price;
        this.categoryID = categoryID;
        this.teacherID = teacherID;
        this.description = description;

    }

    public Courses(int courseID, String courseName, String image, double price, int categoryID, int teacherID, String description, int studentID) {
        this.courseID = courseID;
        this.courseName = courseName;
        this.image = image;
        this.price = price;
        this.categoryID = categoryID;
        this.teacherID = teacherID;
        this.description = description;
        this.studentID = studentID;

    }

    public Courses(int courseID, String courseName, String image, double price, int categoryID, int teacherID, String description, String teacherName) {
        this.courseID = courseID;
        this.courseName = courseName;
        this.image = image;
        this.price = price;
        this.categoryID = categoryID;
        this.teacherID = teacherID;
        this.description = description;
        this.teacherName = teacherName;

    }

    public Courses(int courseID, String courseName, String image, double price, int categoryID, int teacherID, String description) {
        this.courseID = courseID;
        this.courseName = courseName;
        this.image = image;
        this.price = price;
        this.categoryID = categoryID;
        this.teacherID = teacherID;
        this.description = description;
    }

    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public int getTeacherID() {
        return teacherID;
    }

    public void setTeacherID(int teacherID) {
        this.teacherID = teacherID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    @Override
    public String toString() {
        return "Courses{" + "courseID=" + courseID + ", courseName=" + courseName + ", image=" + image + ", price=" + price + ", categoryID=" + categoryID + ", teacherID=" + teacherID + ", description=" + description + ", teacherName=" + teacherName + '}';
    }

}
