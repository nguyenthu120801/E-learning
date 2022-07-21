
package entity;

public class Account {
    public static final String ADMIN = "Admin";
    public static final String STUDENT = "Student";
    public static final String TEACHER = "Teacher";
    private int ID;
    private String username;
    private String password;
    private String RoleName;

    public Account() {
    }

    public Account(String username, String password) {
        this.username = username;
        this.password = password;
    }
    
    public Account(String username, String password, String RoleName) {
        this.username = username;
        this.password = password;
        this.RoleName = RoleName;
    }

    public Account(int ID, String username, String password, String RoleName) {
        this.ID = ID;
        this.username = username;
        this.password = password;
        this.RoleName = RoleName;
    }
    
    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRoleName() {
        return RoleName;
    }

    public void setRoleName(String RoleName) {
        this.RoleName = RoleName;
    }

    @Override
    public String toString() {
        return "Account{" + "ID=" + ID + ", username=" + username + ", password=" + password + ", RoleName=" + RoleName + '}';
    }
    
    
}
