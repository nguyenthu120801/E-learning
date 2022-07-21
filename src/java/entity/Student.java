
package entity;

public class Student {
    private int ID;
    private String FullName;
    private String phone;
    private String address;
    private String image;
    private String email;
    private String gender;
    private String username;
    private String DOB;

    public Student() {
    }

    public Student(int ID, String FullName, String phone, String address, String image, String email, String gender, String username, String DOB) {
        this.ID = ID;
        this.FullName = FullName;
        this.phone = phone;
        this.address = address;
        this.image = image;
        this.email = email;
        this.gender = gender;
        this.username = username;
        this.DOB = DOB;
    }

    public Student(String FullName, String phone, String address, String image, String email, String gender, String username, String DOB) {
        this.FullName = FullName;
        this.phone = phone;
        this.address = address;
        this.image = image;
        this.email = email;
        this.gender = gender;
        this.username = username;
        this.DOB = DOB;
    }
    

    public String getDOB() {
        return DOB;
    }

    public void setDOB(String DOB) {
        this.DOB = DOB;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getFullName() {
        return FullName;
    }

    public void setFullName(String FullName) {
        this.FullName = FullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public boolean isGender() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
