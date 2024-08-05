/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package root.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import root.entities.main.Vote;
import root.jdbc.RowMapper;
import root.jdbc.SQLServerConnection;

/**
 *
 * @author admin
 */
public class VoteDAO implements RowMapper<Vote> {

    @Override
    public Vote mapRow(ResultSet rs) throws SQLException {
        return Vote.builder()
                .voteId(rs.getLong("vote_id"))
                .makerId(rs.getLong("maker_id"))
                .lessonId(rs.getLong("lesson_id"))
                .star(rs.getLong("star"))
                .build();
    }

    @Override
    public boolean addNew(Vote t) throws SQLException, ClassNotFoundException {
        String sql = """
                     INSERT INTO vote (maker_id, lesson_id, star) VALUES (?, ?, ?)""";
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, t.getMakerId());
            ps.setObject(2, t.getLessonId());
            ps.setObject(3, t.getStar());
            check = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return check > 0;
    }

    @Override
    public List<Vote> getAll() throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Vote getById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean updateById(String id, Vote t) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE vote SET maker_id = ?, lesson_id = ?, star = ? WHERE vote_id = ?";
        try (Connection conn = SQLServerConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, t.getMakerId());
            stmt.setLong(2, t.getLessonId());
            stmt.setLong(3, t.getStar());
            stmt.setString(4, id);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public Vote getVoteLessonByUserId(String uId, String lId) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM vote WHERE maker_id = ? AND lesson_id = ?";
        try (Connection conn = SQLServerConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, parseLong(uId));
            stmt.setString(2, lId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            } else {
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // Rethrow the exception after logging it
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw e; // Rethrow the exception after logging it
        }
    }

}
