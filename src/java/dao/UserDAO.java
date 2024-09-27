/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import context.DBContext;
import controller.Encryption;
import entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author Admin
 */
public class UserDAO extends DBContext {
    Connection connection = null;
    
    public User checkLogin(String username, String password) {
        String sql = "select * from [dbo].[Users] where [Username] = ? and [PasswordHash] = ?;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, Encryption.MD5Encryption(password));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new User(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getInt(8),
                        rs.getInt(9)
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean checkAccoutExist(String username) {
        String query = "select * from [dbo].[Users] where username = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
        }

        return false;
    }

    public boolean checkEmailExist(String email) {
        String query = "select * from [dbo].[Users] where email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            ps.setString(1, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
        }

        return false;
    }

    public boolean addUser(User user) {
        if (user == null || user.getUsername() == null) {
            throw new IllegalArgumentException("User hoặc username không thể null");
        }

        String query = "INSERT INTO [dbo].[Users]\n"
                + "           ([Username]\n"
                + "           ,[Fullname]\n"
                + "           ,[Email]\n"
                + "           ,[PhoneNumber]\n"
                + "           ,[PasswordHash])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?)"
                + "GO";

        try (PreparedStatement st = connection.prepareStatement(query)) {

            st.setString(1, user.getUsername());
            st.setString(2, user.getFullname());
            st.setString(3, user.getEmail());
            st.setString(4, user.getPhone());
            st.setString(5, Encryption.MD5Encryption(user.getPassword()));

            int rowsAffected = st.executeUpdate();
            System.out.println(1);
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(5);
            return false;
        }
    }

    public String getUsernamebyEmail(String email) {
        String username = null;
        String query = "SELECT username FROM Users WHERE email = ?";

        try (PreparedStatement st = connection.prepareStatement(query)) {
            st.setString(1, email);

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    username = rs.getString("username");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return username;
    }

    public List<User> getUser() {
        String sql = "select * from [Users]";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getInt(8),
                        rs.getInt(9)
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public User getUserByEmail(String email) {
        String sql = "select * from [Users] where [email] = ?;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getInt(8),
                        rs.getInt(9)
                );
                return user;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public boolean checkEmail(List<User> list, String email) {
        for (User user : list) {
            if (user.getEmail().equals(email)) {
               return true;
            }
        }
        return false;
    }
}
