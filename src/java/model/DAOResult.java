package model;

import java.sql.SQLException;
import java.sql.Statement;

public class DAOResult extends DBConnect {
    // delete result based on ID

    public int DeleteResult(String ID, int value) {
        int number = 0; // number of row affected
        String sql = "DELETE FROM [dbo].[Result]\n"
                + "      WHERE [" + ID + "] = " + value;
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
    // delete result based on username
    public int DeleteResult(String username) {
        int number = 0; // number of row affected
        String sql = "DELETE FROM [dbo].[Result]\n"
                + "      WHERE [username] = '" + username + "'";
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
}
