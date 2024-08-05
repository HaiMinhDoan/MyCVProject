/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package root.DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import root.entities.main.RequestTeacher;
import java.sql.PreparedStatement;
import root.entities.main.User;
import root.jdbc.RowMapper;
import root.jdbc.SQLServerConnection;

/**
 *
 * @author HP
 */
public class RequestTeacherDAO implements RowMapper<RequestTeacher> {

    @Override
    public RequestTeacher mapRow(ResultSet rs) throws SQLException {
        UserDAO userDao = new UserDAO();
        User user = null;
        try {
            user = userDao.getById(rs.getInt("maker_id") + "");
        } catch (Exception e) {

        }
        return RequestTeacher.builder()
                .reqestTeacherId(rs.getInt("reqest_teacher_id"))
                .makerId(rs.getInt("maker_id"))
                .userBank(rs.getString("user_bank"))
                .userBankCode(rs.getString("user_bank_code"))
                .reqestContent(rs.getString("reqest_content"))
                .createdTime(rs.getString("created_time"))
                .isAccept(rs.getInt("is_accept"))
                .user(user)
                .build();
    }

    @Override
    public boolean addNew(RequestTeacher t) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<RequestTeacher> getAll() throws SQLException, ClassNotFoundException {
        List<RequestTeacher> requests = new ArrayList<>();
        try {
            String sql = "SELECT * FROM reqest_teacher";
            Connection con = SQLServerConnection.getConnection();
            PreparedStatement preparedStatement = con.prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("reqest_teacher_id");
                int makerId = rs.getInt("maker_id");
                String userBank = rs.getString("user_bank");
                String userBankCode = rs.getString("user_bank_code");
                String content = rs.getString("reqest_content");
                String createdTime = rs.getString("created_time");
                boolean isAccept = rs.getBoolean("is_accept");
                requests.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }

    public int updateRequestStatus(int id, int isAccept) {
        try {
            String sql = "UPDATE reqest_teacher SET is_accept = ? WHERE reqest_teacher_id = ?";
            Connection con = SQLServerConnection.getConnection();
            PreparedStatement preparedStatement = con.prepareStatement(sql);
            preparedStatement.setInt(1, isAccept);
            preparedStatement.setInt(2, id);
            return preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int deleteRequest(int id) {
        try {
            String sql = "Delete from reqest_teacher WHERE reqest_teacher_id = ?";
            Connection con = SQLServerConnection.getConnection();
            PreparedStatement preparedStatement = con.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            return preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int insertRequestTeacher(RequestTeacher requestTeacher) throws SQLException {
        String sql = "INSERT INTO reqest_teacher (maker_id, user_bank, user_bank_code, reqest_content, created_time, is_accept)"
                + " VALUES (?, ?, ?, ?, ?, ?)";
        try {
            Connection con = SQLServerConnection.getConnection();
            PreparedStatement preparedStatement = con.prepareStatement(sql);
            preparedStatement.setInt(1, requestTeacher.getMakerId());
            preparedStatement.setString(2, requestTeacher.getUserBank());
            preparedStatement.setString(3, requestTeacher.getUserBankCode());
            preparedStatement.setString(4, requestTeacher.getReqestContent());
            preparedStatement.setString(5, requestTeacher.getCreatedTime());
            preparedStatement.setInt(6, requestTeacher.getIsAccept());
            return preparedStatement.executeUpdate();
        } catch (Exception e) {
            System.out.println("Add request: " + e);
        }
        return 0;
    }

    @Override
    public RequestTeacher getById(String id) throws SQLException, ClassNotFoundException {
        RequestTeacher requests = null;
        try {
            String sql = "SELECT * FROM reqest_teacher where reqest_teacher_id=?";
            Connection con = SQLServerConnection.getConnection();
            PreparedStatement preparedStatement = con.prepareStatement(sql);
            preparedStatement.setString(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                requests = mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }

    @Override
    public boolean updateById(String id, RequestTeacher t) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean deleteById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}



