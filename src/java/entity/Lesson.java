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
public class Lesson {
    int lessonID;
    String lessonName;
    int courseID;
    int lessonNo;

    public Lesson() {
    }

    public Lesson(int lessonID, String lessonName, int courseID, int lessonNo) {
        this.lessonID = lessonID;
        this.lessonName = lessonName;
        this.courseID = courseID;
        this.lessonNo = lessonNo;
    }    

    public int getLessonID() {
        return lessonID;
    }

    public void setLessonID(int lessonID) {
        this.lessonID = lessonID;
    }

    public String getLessonName() {
        return lessonName;
    }

    public void setLessonName(String lessonName) {
        this.lessonName = lessonName;
    }

    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public int getLessonNo() {
        return lessonNo;
    }

    public void setLessonNo(int lessonNo) {
        this.lessonNo = lessonNo;
    }

    @Override
    public String toString() {
        return "Lesson{" + "lessonID=" + lessonID + ", lessonName=" + lessonName + ", courseID=" + courseID + ", lessonNo=" + lessonNo + '}';
    }
    
    
    
    
}
