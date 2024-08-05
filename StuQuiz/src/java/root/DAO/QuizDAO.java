/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package root.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import root.entities.main.Quiz;
import root.entities.main.User;
import root.jdbc.RowMapper;
import root.jdbc.SQLServerConnection;

/**
 *
 * @author admin
 */
public class QuizDAO implements RowMapper<Quiz> {

    @Override
    public Quiz mapRow(ResultSet rs) throws SQLException {
        return Quiz.builder()
                .quizId(rs.getLong("quiz_id"))
                .lessonId(rs.getLong("lesson_id"))
                .quizName(rs.getString("quiz_name"))
                .quizLevel(rs.getLong("quiz_level"))
                .quizDuration(rs.getLong("quiz_duration"))
                .passRate(rs.getDouble("pass_rate"))
                .quizType(rs.getLong("quiz_type"))
                .quizDescription(rs.getString("quiz_description"))
                .eQuestion(rs.getLong("e_question"))
                .mQuestion(rs.getLong("m_question"))
                .hQuestion(rs.getLong("h_question"))
                .isActive(rs.getBoolean("is_active"))
                .build();
    }

    @Override
    public boolean addNew(Quiz t) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Quiz> getAll() throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Quiz getById(String id) throws SQLException, ClassNotFoundException {
        String sql = """
                     select * from quiz where quiz_id=?
                     """;
        Quiz quiz = null;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(id));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                quiz = mapRow(rs);
            }
            if (quiz == null) {
                quiz = Quiz.builder().quizId(0L).build();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return quiz;
    }

    @Override
    public boolean updateById(String id, Quiz t) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean deleteById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public Long addNewQuizAndGetId(Quiz t) throws SQLException, ClassNotFoundException {
        String sql = """
                     INSERT INTO [dbo].[quiz]
                                ([lesson_id]
                                ,[quiz_name]
                                ,[quiz_level]
                                ,[quiz_duration]
                                ,[pass_rate]
                                ,[quiz_type]
                                ,[quiz_description]
                                ,[e_question]
                                ,[m_question]
                                ,[h_question]
                                ,[is_active])
                          VALUES
                     	 (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                     """;
        long check = 0L;
        long id = 0L;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);) {
            ps.setObject(1, t.getLessonId());
            ps.setObject(2, t.getQuizName());
            ps.setObject(3, t.getQuizLevel());
            ps.setObject(4, t.getQuizDuration());
            ps.setObject(5, t.getPassRate());
            ps.setObject(6, t.getQuizType());
            ps.setObject(7, t.getQuizDescription());
            ps.setObject(8, t.getEQuestion());
            ps.setObject(9, t.getMQuestion());
            ps.setObject(10, t.getHQuestion());
            ps.setObject(11, t.isActive());
            check = ps.executeUpdate();
            if (check > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    id = rs.getLong(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return id;
    }

    public List<Quiz> getListQuizByLessonId(String id) throws SQLException, ClassNotFoundException {
        String sql = """
                     select * from quiz where [lesson_id]=?
                     """;
        List<Quiz> list = new ArrayList<>();
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(id));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

}
