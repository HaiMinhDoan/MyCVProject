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
import root.entities.main.Answer;
import root.entities.main.Course;
import root.entities.main.Question;
import root.jdbc.RowMapper;
import root.jdbc.SQLServerConnection;

/**
 *
 * @author admin
 */
public class AnswerDAO implements RowMapper<Answer> {

    @Override
    public Answer mapRow(ResultSet rs) throws SQLException {
        return Answer.builder()
                .answerId(rs.getLong("answer_id"))
                .questionId(rs.getLong("question_id"))
                .answerContent(rs.getString("answer_content"))
                .isTrue(rs.getBoolean("is_true"))
                .build();
    }

    @Override
    public boolean addNew(Answer t) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO answer (question_id, answer_content, is_true)"
                 + " VALUES (?, ?, ?)";
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, t.getQuestionId());           
            ps.setObject(2, t.getAnswerContent());
            ps.setObject(3, t.isTrue());
            check = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return check > 0;
    }

    @Override
    public List<Answer> getAll() throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Answer getById(String id) throws SQLException, ClassNotFoundException {
        Answer answer = null;
        String sql = """
              select * from [answer] where [answer_id]=?
              """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(id));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                answer = mapRow(rs);
            }
            if(answer==null){
                answer = Answer.builder().answerId(0L).isTrue(false).build();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return answer;
    }

    @Override
    public boolean updateById(String id, Answer t) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean deleteById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    public List<Answer> getListAnswerByQuestionId(String questionId) throws SQLException, ClassNotFoundException {
         List<Answer> list = new ArrayList<>();
        String sql = """
                     select * from [answer] where question_id = ?
                     """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(questionId));
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
    
    public Answer getAnswerByQuestionTrue(int questionId) {
        String sql = "select * from answer where question_id=? and is_true=true";
        try {
            Connection con = SQLServerConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, questionId);
            ResultSet rs = st.executeQuery();
            if(rs.next()) {
                return mapRow(rs);
            }
        }catch(Exception e) {
            System.out.println("Get answer by question: " + e);
        }
        return null;
    }
    
    public List<Answer> getAnswerByQuestion(int questionId) {
        String sql = "select * from answer where question_id=?";
        List<Answer> answers = new ArrayList<>();
        try {
            Connection con = SQLServerConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, questionId);
            ResultSet rs = st.executeQuery();
            while(rs.next()) {
                answers.add(mapRow(rs));
            }
        }catch(Exception e) {
            System.out.println("Get answer by question: " + e);
        }
        return answers;
    }
    
    public boolean deleteAnswerByQuestion(int questionId) {
        String sql = "delete from answer where question_id=?";
        try {
            Connection con = SQLServerConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, questionId);
            int result = st.executeUpdate();
            return result > 0;
        }catch(Exception e) {
            System.out.println("Delete answer by question: " + e);
        }
        return false;
    }




    
}
