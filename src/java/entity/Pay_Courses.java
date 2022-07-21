/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author Vuong
 */
import java.sql.Date;

public class Pay_Courses {
    private String PayID;
    private String  date;
    private String type;
    private String CourseID;
    private String StudentID;

    public Pay_Courses() {
    }

    public String getPayID() {
        return PayID;
    }

    public void setPayID(String PayID) {
        this.PayID = PayID;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCourseID() {
        return CourseID;
    }

    public void setCourseID(String CourseID) {
        this.CourseID = CourseID;
    }

    public String getStudentID() {
        return StudentID;
    }

    public void setStudentID(String StudentID) {
        this.StudentID = StudentID;
    }

    public Pay_Courses(String PayID, String date, String type, String CourseID, String StudentID) {
        this.PayID = PayID;
        this.date = date;
        this.type = type;
        this.CourseID = CourseID;
        this.StudentID = StudentID;
    }

    @Override
    public String toString() {
        return "Pay_Courses{" + "PayID=" + PayID + ", date=" + date + ", type=" + type + ", CourseID=" + CourseID + ", StudentID=" + StudentID + '}';
    }
     
    
}
