package model;

import entity.Account;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DAOAccount extends DBConnect {

    // add account
    public int AddAccount(Account account) {
        int number = 0; // number of row affected
        String sql = "INSERT INTO [dbo].[Account]\n"
                + "           ([username]\n"
                + "           ,[password]\n"
                + "           ,[RoleName])\n"
                + "     VALUES\n"
                + "   (?,?,?)";
        try {
            // create prepare statement
            PreparedStatement prepare = conn.prepareStatement(sql);
            // set value for ?
            prepare.setString(1, account.getUsername());
            prepare.setString(2, account.getPassword());
            prepare.setString(3, account.getRoleName());
            // execute sql
            number = prepare.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return number;
    }

    // update account
    public int UpdateAccount(String role, String username) {
        int number = 0; // number of row affected
        String sql = "UPDATE [dbo].[Account]\n"
                + "SET [RoleName] = ?\n"
                + "WHERE [username] = ?\n";
        try {
            // create prepare statement
            PreparedStatement prepare = conn.prepareStatement(sql);
            // set value for ?
            prepare.setString(1, role);
            prepare.setString(2, username);
            // execute sql
            number = prepare.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return number;
    }

    // update account
    public int UpdatePassword(String username, String password) {
        int number = 0; // number of row affected
        String sql = "UPDATE [dbo].[Account]\n"
                + "SET [password] = ?\n"
                + "WHERE [username] = ?\n";
        try {
            // create prepare statement
            PreparedStatement prepare = conn.prepareStatement(sql);
            // set value for ?
            prepare.setString(1, password);
            prepare.setString(2, username);
            // execute sql
            number = prepare.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return number;
    }

    // get all account
    public List<Account> GetAllAccount() {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[Account]";
        ResultSet result = getData(sql);
        try {
            // loop for traverse through all account
            while (result.next()) {
                int ID = result.getInt(1);
                String username = result.getString(2);
                String password = result.getString(3);
                String RoleName = result.getString(4);
                Account account = new Account(ID, username, password, RoleName);
                list.add(account);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // delete account
    public int DeleteAccount(String username) {
        int number = 0; // number of row affected
        String sql = "DELETE FROM [dbo].[Account]\n"
                + "      WHERE [username]='" + username + "'";
        try {
            // create statement
            Statement statement = conn.createStatement();
            // execute sql
            number = statement.executeUpdate(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return number;
    }

    // get role name
    public String getRoleName(String username) {
        String sql = "SELECT [RoleName] FROM [dbo].[Account]\n"
                + "WHERE [username] = '" + username + "'";
        ResultSet result = getData(sql);
        try {
            // if get data suceesful
            if (result.next()) {
                return result.getString(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public boolean CheckUsernameExist(String username) {
        String sql = "SELECT * FROM [dbo].[Account]";
        // get data
        ResultSet result = getData(sql);
        try {
            // loop for traverse through all account
            while (result.next()) {
                // if account exist
                if (username.equalsIgnoreCase(result.getString(2))) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public Account Login(String username, String password) {
        try {
            String sql = "select * from Account where username = ? and password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Account account = new Account(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
                return account;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOAccount.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    // get list account based on name

    public List<Account> GetListAccount(String name) {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[Account]\n"
                + "  where [username] LIKE '%" + name + "%'";
        ResultSet result = getData(sql);
        try {
            // loop for traverse through all account
            while (result.next()) {
                int ID = result.getInt(1);
                String username = result.getString(2);
                String password = result.getString(3);
                String RoleName = result.getString(4);
                Account account = new Account(ID, username, password, RoleName);
                list.add(account);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // check account valid
    public boolean CheckAccountValid(String username, String password) {
        String sql = "SELECT * FROM [dbo].[Account]";
        // get data
        ResultSet result = getData(sql);
        try {
            // loop for traverse through all account
            while (result.next()) {
                // if account exist
                if (username.equalsIgnoreCase(result.getString(2)) && password.equals(result.getString(3))) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
//        List<Account> list = new DAOAccount().GetListAccount("   ".trim());
//        System.out.println(list.isEmpty());
//           System.out.println("     ".trim().isEmpty()); 
    }

}
