/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author chuqu
 */
public class LessonPDF {
    public int pdfID;
    public String pdfName;
    public String filePDF;
    public int lessonID;

    public LessonPDF() {
    }

    public LessonPDF(int pdfID, String pdfName, String filePDF, int lessonID) {
        this.pdfID = pdfID;
        this.pdfName = pdfName;
        this.filePDF = filePDF;
        this.lessonID = lessonID;
    }

    public LessonPDF(int pdfID, String pdfName, String filePDF) {
        this.pdfID = pdfID;
        this.pdfName = pdfName;
        this.filePDF = filePDF;
    }

    public int getPdfID() {
        return pdfID;
    }

    public void setPdfID(int pdfID) {
        this.pdfID = pdfID;
    }

    public String getPdfName() {
        return pdfName;
    }

    public void setPdfName(String pdfName) {
        this.pdfName = pdfName;
    }

    public String getFilePDF() {
        return filePDF;
    }

    public void setFilePDF(String filePDF) {
        this.filePDF = filePDF;
    }

    public int getLessonID() {
        return lessonID;
    }

    public void setLessonID(int lessonID) {
        this.lessonID = lessonID;
    }

    
    
    
}
