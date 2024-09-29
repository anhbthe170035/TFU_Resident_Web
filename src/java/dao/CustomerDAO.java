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
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getString(8),
                        rs.getTimestamp(9).toLocalDateTime(),
                        rs.getTimestamp(10).toLocalDateTime(),
                        rs.getInt(11)
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
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getString(8),
                        rs.getTimestamp(9).toLocalDateTime(),
                        rs.getTimestamp(10).toLocalDateTime(),
                        rs.getInt(11)
                );
                list.add(customer);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean checkUsernameExist(String username) {
        String query = "select * from [dbo].[Customers] where Username = ?";
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
        String query = "SELECT * FROM [dbo].[CustomerContacts] WHERE Email = ?";
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
    
    public void saveCustomerWithEmail(Customer customer, String email, String password) {
        String customerSql = "INSERT INTO Customers (FirstName, LastName, Username, DateOfBirth, Gender, PasswordHash, CreatedAt, UpdatedAt) VALUES (?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        String contactSql = "INSERT INTO CustomerContacts (CustomerID, Email, IsPrimary) VALUES (?, ?, 1)";

        try {
            // Bắt đầu transaction
            conn.setAutoCommit(false);

            // Thêm thông tin vào bảng Customers
            ps = conn.prepareStatement(customerSql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, customer.getFirstName());
            ps.setString(2, customer.getLastName());
            ps.setString(3, customer.getUsername());
            ps.setString(4, customer.getDob());
            ps.setInt(5, customer.getGender());
            ps.setString(6, customer.getPassword());
            ps.executeUpdate();

            // Lấy CustomerID vừa tạo để thêm vào CustomerContacts
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int customerId = rs.getInt(1);

                // Thêm thông tin vào bảng CustomerContacts
                PreparedStatement psContact = conn.prepareStatement(contactSql);
                psContact.setInt(1, customerId);
                psContact.setString(2, email);
                psContact.executeUpdate();
            }

            // Commit transaction
            conn.commit();

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                conn.rollback();  // Rollback nếu có lỗi
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                conn.setAutoCommit(true);  // Reset trạng thái auto-commit
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
