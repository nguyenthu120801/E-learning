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
public class LessonVideo {
    public int videoID;
    public String videoName;
    public String fileVideo;
    public int lessonID;

    public LessonVideo() {
    }

    public LessonVideo(String videoName, String fileVideo, int lessonID) {
        this.videoName = videoName;
        this.fileVideo = fileVideo;
        this.lessonID = lessonID;
    }

    public LessonVideo(int videoID, String videoName, String fileVideo, int lessonID) {
        this.videoID = videoID;
        this.videoName = videoName;
        this.fileVideo = fileVideo;
        this.lessonID = lessonID;
    }

    public int getVideoID() {
        return videoID;
    }

    public void setVideoID(int videoID) {
        this.videoID = videoID;
    }

    public String getVideoName() {
        return videoName;
    }

    public void setVideoName(String videoName) {
        this.videoName = videoName;
    }

    public String getFileVideo() {
        return fileVideo;
    }

    public void setFileVideo(String fileVideo) {
        this.fileVideo = fileVideo;
    }

    public int getLessonID() {
        return lessonID;
    }

    public void setLessonID(int lessonID) {
        this.lessonID = lessonID;
    }

    
    
    
}
