
package entity;

public class Teacher {
    private int ID;
    private String FullName;
    private String phone;
    private String image;
    private String email;
    private String gender;
    private String username;
    private String roleName;

    public Teacher() {
    }

    public Teacher(int ID, String FullName, String phone, String image, String email, String gender, String username) {
        this.ID = ID;
        this.FullName = FullName;
        this.phone = phone;
        this.image = image;
        this.email = email;
        this.gender = gender;
        this.username = username;
    }

    public Teacher(String FullName, String phone, String image, String email, String gender, String username) {
        this.FullName = FullName;
        this.phone = phone;
        this.image = image;
        this.email = email;
        this.gender = gender;
        this.username = username;
    }

    public Teacher(int ID, String FullName, String phone, String image, String email, String gender, String username, String roleName) {
        this.ID = ID;
        this.FullName = FullName;
        this.phone = phone;
        this.image = image;
        this.email = email;
        this.gender = gender;
        this.username = username;
        this.roleName = roleName;
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
    
}
