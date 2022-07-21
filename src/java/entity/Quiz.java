/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author Windows
 */
public class Quiz {

    private int id;
    private String ques;
    private int lessonId;
    private String ans1;
    private String ans2;
    private String ans3;
    private String ans4;
    private int correctAns;
    private String correctAnsStr;

    public Quiz() {
    }

    public Quiz(int id) {
        this.id = id;
    }
    
    public Quiz(int id, String ques, int lessonId, String ans1, String ans2, String ans3, String ans4, int correctAns, String correctAnsStr) {
        this.id = id;
        this.ques = ques;
        this.lessonId = lessonId;
        this.ans1 = ans1;
        this.ans2 = ans2;
        this.ans3 = ans3;
        this.ans4 = ans4;
        this.correctAns = correctAns;
        this.correctAnsStr = correctAnsStr;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getQues() {
        return ques;
    }

    public void setQues(String ques) {
        this.ques = ques;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public String getAns1() {
        return ans1;
    }

    public void setAns1(String ans1) {
        this.ans1 = ans1;
    }

    public String getAns2() {
        return ans2;
    }

    public void setAns2(String ans2) {
        this.ans2 = ans2;
    }

    public String getAns3() {
        return ans3;
    }

    public void setAns3(String ans3) {
        this.ans3 = ans3;
    }

    public String getAns4() {
        return ans4;
    }

    public void setAns4(String ans4) {
        this.ans4 = ans4;
    }

    public int getCorrectAns() {
        return correctAns;
    }

    public void setCorrectAns(int correctAns) {
        this.correctAns = correctAns;
    }

    public String getCorrectAnsStr() {
        switch (correctAns) {
            case 1:
                correctAnsStr = "Option 1";
                return correctAnsStr;
            case 2:
                correctAnsStr = "Option 2";
                return correctAnsStr;
            case 3:
                correctAnsStr = "Option 3";
                return correctAnsStr;
            case 4:
                correctAnsStr = "Option 4";
                return correctAnsStr;
        }
        return null;
    }

    public String getCorrectAnsIsStr(int correctAns) {
        switch (correctAns) {
            case 1:
                return ans1;
            case 2:
                return ans2;
            case 3:
                return ans3;
            case 4:
                return ans4;
        }
        return null;
    }

    @Override
    public String toString() {
        return "Quiz{" + "id=" + id + ", ques=" + ques + ", lessonId=" + lessonId + ", ans1=" + ans1 + ", ans2=" + ans2 + ", ans3=" + ans3 + ", ans4=" + ans4 + ", correctAns=" + correctAns + ", correctAnsStr=" + correctAnsStr + '}';
    }

}
