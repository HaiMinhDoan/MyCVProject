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
import root.entities.main.ExamQuestion;
import root.jdbc.RowMapper;
import root.jdbc.SQLServerConnection;

/**
 *
 * @author admin
 */
public class ExamQuestionDAO implements RowMapper<ExamQuestion> {

    @Override
    public ExamQuestion mapRow(ResultSet rs) throws SQLException {
        return ExamQuestion.builder()
                .examQuestionId(rs.getLong("exam_question_id"))
                .examId(rs.getLong("exam_id"))
                .questionId(rs.getLong("question_id"))
                .selectedAnswer(rs.getLong("selected_answer"))
                .build();
    }

    @Override
    public boolean addNew(ExamQuestion t) throws SQLException, ClassNotFoundException {
        String sql = """
                     insert into [exam_question](
                     [exam_id],
                     question_id,
                     selected_answer
                     ) values(?,?,?)
                     """;
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, t.getExamId());
            ps.setObject(2, t.getQuestionId());
            ps.setObject(3, t.getSelectedAnswer());
            check = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return check > 0;
    }

    @Override
    public List<ExamQuestion> getAll() throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ExamQuestion getById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean updateById(String id, ExamQuestion t) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean deleteById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    
    public List<ExamQuestion> getListExamQuestionByExamId(String examId) {
        List<ExamQuestion> list = new ArrayList<>();
        String sql = """
                     select * from exam_question where exam_id = ?;
                     """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setObject(1, parseLong(examId));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException | ClassNotFoundException e) {
        }
        return list;
    }



}
