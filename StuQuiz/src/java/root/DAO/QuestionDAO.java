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
import root.entities.main.User;
import root.jdbc.RowMapper;
import root.jdbc.SQLServerConnection;

/**
 *
 * @author admin
 */
public class QuestionDAO implements RowMapper<Question> {

    @Override
    public Question mapRow(ResultSet rs) throws SQLException {
        return Question.builder()
                .questionId(rs.getLong("question_id"))
                .subjectId(rs.getLong("subject_id"))
                .questionContent(rs.getString("question_content"))
                .questionImage(rs.getString("question_image"))
                .questionLevel(rs.getLong("question_level"))
                .isActive(rs.getBoolean("is_active"))
                .build();
    }

    @Override
    public boolean addNew(Question t) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO question (subject_id, question_image, question_content, question_level, is_active)"
                + " VALUES (?, ?, ?, ?, ?)";
        int check = 0;
        try ( Connection con = SQLServerConnection.getConnection();  PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setLong(1, t.getSubjectId());
            ps.setString(2, t.getQuestionImage());
            ps.setString(3, t.getQuestionContent());
            ps.setLong(4, t.getQuestionLevel());
            ps.setBoolean(5, true);
            int affectedRow = ps.executeUpdate();
            return affectedRow > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }


    @Override
    public List<Question> getAll() throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Question getById(String id) throws SQLException, ClassNotFoundException {
       Question question = null;
        String sql = """
              select * from [question] where [question_id]=?
              """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(id));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                question = mapRow(rs);
            }
            if(question==null){
                question = Question.builder().questionId(0L).build();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return question;
    }

    @Override
    public boolean updateById(String id, Question t) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean deleteById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public List<Question> getListQuestionByQuizId(String quizId) throws SQLException, ClassNotFoundException{
        List<Question> list = new ArrayList<>();
        String sql = """
                     SELECT q.*
                     FROM question q
                     JOIN quiz_bank qb ON q.question_id = qb.question_id
                     WHERE qb.quiz_id = ?;
                     """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(quizId));
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
    
    public Long addNewQuestionAndGetId(Question t) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO question (subject_id, question_image, question_content, question_level, is_active)"
                + " VALUES (?, ?, ?, ?, ?)";
        int check = 0;
        long id = 0L;
        try ( Connection con = SQLServerConnection.getConnection();  PreparedStatement ps = con.prepareStatement(sql,PreparedStatement.RETURN_GENERATED_KEYS);) {
            ps.setLong(1, t.getSubjectId());
            ps.setString(2, t.getQuestionImage());
            ps.setString(3, t.getQuestionContent());
            ps.setLong(4, t.getQuestionLevel());
            ps.setBoolean(5, true);
            check = ps.executeUpdate();
            if(check>0){
                ResultSet rs = ps.getGeneratedKeys();
                if(rs.next()){
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
    
    public long getIdQuestionWasAdded() throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM question ORDER BY question_id DESC";
        int check = 0;
        try ( Connection con = SQLServerConnection.getConnection();  PreparedStatement ps = con.prepareStatement(sql);) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getLong(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public boolean edit(Question t, List<Answer> answers) throws SQLException, ClassNotFoundException {
        String updateQuestionSql = "UPDATE question SET subject_id = ?, question_image = ?, question_content = ?, question_level = ?, is_active = ? WHERE question_id = ?";
        String updateAnswerSql = "UPDATE answer SET answer_content = ?, is_true = ? WHERE answer_id = ?";

        try ( Connection con = SQLServerConnection.getConnection();  PreparedStatement psQuestion = con.prepareStatement(updateQuestionSql);  PreparedStatement psAnswer = con.prepareStatement(updateAnswerSql)) {

            // Update the question
            psQuestion.setLong(1, t.getSubjectId());
            psQuestion.setString(2, t.getQuestionImage());
            psQuestion.setString(3, t.getQuestionContent());
            psQuestion.setLong(4, t.getQuestionLevel());
            psQuestion.setBoolean(5, t.isActive());
            psQuestion.setLong(6, t.getQuestionId());
            int affectedRowsQuestion = psQuestion.executeUpdate();

            // Update the answers
            for (Answer answer : answers) {
                psAnswer.setString(1, answer.getAnswerContent());
                psAnswer.setBoolean(2, answer.isTrue());
                psAnswer.setLong(3, answer.getAnswerId());
                psAnswer.addBatch();
            }
            int[] affectedRowsAnswers = psAnswer.executeBatch();

            // Check if both the question and answers were updated
            return affectedRowsQuestion > 0 && affectedRowsAnswers.length == answers.size();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Question> getAllBySubject(int subjectId) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM question where subject_id=?";
        List<Question> questions = new ArrayList<>();
        try ( Connection con = SQLServerConnection.getConnection();  PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setInt(1, subjectId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                questions.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("Get question by subject: " + e);
        } catch (ClassNotFoundException e) {
            System.out.println("Get question by subject: " + e);
        }
        return questions;
    }
    
    public boolean deleteQuestion(long questionId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = SQLServerConnection.getConnection();
            con.setAutoCommit(false); 
            String deleteAnswersSql = "DELETE FROM answer WHERE question_id = ?";
            ps = con.prepareStatement(deleteAnswersSql);
            ps.setLong(1, questionId);
            ps.executeUpdate();
            ps.close();
            String deleteQuestionSql = "DELETE FROM question WHERE question_id = ?";
            ps = con.prepareStatement(deleteQuestionSql);
            ps.setLong(1, questionId);
            int affectedRows = ps.executeUpdate();
            con.commit();
            return affectedRows > 0;
        } catch (SQLException e) {
            if (con != null) {
                con.rollback();
            }
            System.out.println("Delete question: " + e);
            e.printStackTrace();
            return false;
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
    
        public List<Question> getListQuestionBySubjectId(String id) throws SQLException, ClassNotFoundException {
        List<Question> list = new ArrayList<>();
        String sql = """
                    SELECT * FROM question WHERE subject_id = ?
                     """;
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
