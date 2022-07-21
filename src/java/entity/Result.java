/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.sql.Date;

/**
 *
 * @author Windows
 */
public class Result {
    private int resultId;
    private int lessonId;
    private String lessonName;
    private String userName;
    private String fullName;
    private String status;
    private float score;
    private Date date;
    

    public Result() {
    }

    public Result(int resultId, int lessonId, String lessonName, String userName, String fullName, String status, float score, Date date) {
        this.resultId = resultId;
        this.lessonId = lessonId;
        this.lessonName = lessonName;
        this.userName = userName;
        this.fullName = fullName;
        this.status = status;
        this.score = score;
        this.date = date;
    }

    public int getResultId() {
        return resultId;
    }

    public void setResultId(int resultId) {
        this.resultId = resultId;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public String getLessonName() {
        return lessonName;
    }

    public void setLessonName(String lessonName) {
        this.lessonName = lessonName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public float getScore() {
        return score;
    }

    public void setScore(float score) {
        this.score = score;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return "Result{" + "resultId=" + resultId + ", lessonId=" + lessonId + ", lessonName=" + lessonName + ", userName=" + userName + ", fullName=" + fullName + ", status=" + status + ", score=" + score + ", date=" + date + '}';
    }
}
