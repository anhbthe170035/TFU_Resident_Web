/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Customer;
import context.DBContext;
import entity.Customer;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class CustomerDAO {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public Customer checkLogin(String username, String password) throws SQLException, Exception {
        String sql = "select * from [dbo].[Customers] where [Username] = ? and [PasswordHash] = ?;";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);

            // Đặt giá trị cho các tham số
            ps.setString(1, username);
            ps.setString(2, password);

            // Thực thi câu lệnh SQL
            rs = ps.executeQuery();

            // Xử lý kết quả
            while (rs.next()) {
                return new Customer(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getTimestamp(10).toLocalDateTime(),
                        rs.getTimestamp(11).toLocalDateTime(),
                        rs.getInt(12)
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            // Đóng tài nguyên
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }

    public List<Customer> getCustomers() throws Exception {
        List<Customer> list = new ArrayList<>();
        String sql = "select * from [Customers]";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Customer customer = new Customer(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getTimestamp(10).toLocalDateTime(),
                        rs.getTimestamp(11).toLocalDateTime(),
                        rs.getInt(12)
                );
                list.add(customer);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean checkUsernameExist(String username) {
        String query = "select * from [dbo].[Customers] where [Username] = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
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
        String query = "SELECT * FROM [dbo].[Customers] WHERE [Email] = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
        }
        return false;
    }
    
    public boolean addCustomer(Customer customer) throws Exception {
        if (customer == null || customer.getUsername() == null) {
            throw new IllegalArgumentException("User hoặc username không thể null");
        }

        String query = "INSERT INTO [dbo].[Customers]\n"
                + "           ([FirstName]\n"
                + "           ,[LastName]\n"
                + "           ,[Username]\n"
                + "           ,[DateOfBirth]\n"
                + "           ,[Gender]\n"
                + "           ,[Phone]\n"
                + "           ,[Email]\n"
                + "           ,[PasswordHash])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?,?,?)";

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);

            // Set giá trị cho các tham số
            ps.setString(1, customer.getFirstName());
            ps.setString(2, customer.getLastName());
            ps.setString(3, customer.getUsername());
            ps.setString(4, customer.getDob());
            ps.setInt(5, customer.getGender());
            ps.setString(6, customer.getPhone());
            ps.setString(7, customer.getEmail());
            ps.setString(8, customer.getPassword());

            // Sử dụng executeUpdate cho các câu lệnh INSERT
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            // Đảm bảo đóng PreparedStatement và Connection sau khi sử dụng
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
