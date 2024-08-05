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
import root.entities.main.QuizBank;
import root.jdbc.RowMapper;
import root.jdbc.SQLServerConnection;

/**
 *
 * @author admin
 */
public class QuizBankDAO implements RowMapper<QuizBank> {

    @Override
    public QuizBank mapRow(ResultSet rs) throws SQLException {
        return QuizBank.builder()
                .quizBankId(rs.getLong("quiz_bank_id"))
                .quizId(rs.getLong("quiz_id"))
                .questionId(rs.getLong("question_id"))
                .build();
    }

    @Override
    public boolean addNew(QuizBank t) throws SQLException, ClassNotFoundException {
        String sql = """
                     INSERT INTO [dbo].[quiz_bank]
                                ([quiz_id]
                                ,[question_id])
                          VALUES
                                (?, ?)""";
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, t.getQuizId());
            ps.setObject(2, t.getQuestionId());
            check = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return check > 0;
    }

    @Override
    public List<QuizBank> getAll() throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public QuizBank getById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean updateById(String id, QuizBank t) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean deleteById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    

}
