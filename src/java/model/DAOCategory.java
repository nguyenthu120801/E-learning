/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Category;
import entity.Courses;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

/**
 *
 * @author nanht
 */
public class DAOCategory extends DBConnect {

    public Vector<Category> getAllCategory() {
        String sql = "select * from Category";
        ResultSet rs = getData(sql);
        return addToVector(rs);
    }


    public Vector<Category> addToVector(ResultSet rs) {
        Vector<Category> vector = new Vector<Category>();
        try {
            while (rs.next()) {
                int categoryID = rs.getInt(1);
                String categoryName = rs.getString(2);
                Category ca = new Category(categoryID, categoryName);
                vector.add(ca);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return vector;
    }
    
    public static void main(String[] args) {
            DAOCategory dao = new DAOCategory();
            dao.getAllCategory();
    }
}
