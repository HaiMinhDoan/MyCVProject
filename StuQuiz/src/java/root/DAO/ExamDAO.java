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
import root.entities.main.Exam;
import root.jdbc.RowMapper;
import root.jdbc.SQLServerConnection;
import java.sql.Statement;
import java.util.ArrayList;
import root.entities.main.User;
import root.entities.sub.ExamResult;

/**
 *
 * @author admin
 */
public class ExamDAO implements RowMapper<Exam> {

    @Override
    public Exam mapRow(ResultSet rs) throws SQLException {
        return Exam.builder()
                .examId(rs.getLong("exam_id"))
                .quizId(rs.getLong("quiz_id"))
                .studentId(rs.getLong("student_id"))
                .examRate(rs.getDouble("exam_rate"))
                .isPass(rs.getBoolean("is_pass"))
                .build();
    }

    @Override
    public boolean addNew(Exam t) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Exam> getAll() throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Exam getById(String id) throws SQLException, ClassNotFoundException {
        String sql = """
                     select * from exam where exam_id = ?
                     """;
        Exam exam = null;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(id));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                System.out.println(rs.getString("exam_id"));
                exam = mapRow(rs);
            } else {
                exam = Exam.builder()
                        .examId(0L)
                        .build();
            }
        } catch (SQLException | ClassNotFoundException e) {
            exam = Exam.builder().examId(0L).build();
        }
        return exam;
    }

    @Override
    public boolean updateById(String id, Exam t) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean deleteById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public Long addNewAndGetId(Exam t) throws SQLException, ClassNotFoundException {
        String sql = """
                     insert into [exam](
                     quiz_id,
                     student_id,
                     exam_rate,
                     is_pass) values(?,?,?,?)
                     """;
        int check = 0;
        Long id = 0L;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);) {
            ps.setObject(1, t.getQuizId());
            ps.setObject(2, t.getStudentId());
            ps.setObject(3, t.getExamRate());
            ps.setObject(4, t.isPass());
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

    public List<Exam> getListExamByQuizId(String quizId) throws SQLException, ClassNotFoundException {
        List<Exam> list = new ArrayList<>();
        String sql = """
              select * from [exam] where quiz_id =?
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

    public List<Exam> getListExamByQuizIdAndUserId(String quizId, String userId) throws SQLException, ClassNotFoundException {
        List<Exam> list = new ArrayList<>();
        String sql = """
              select * from [exam] where quiz_id =? and student_id = ?
              """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(quizId));
            ps.setObject(2, parseLong(userId));
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
    
    public List<ExamResult> getListExamResultByStudentAndQuizId(String userId, String quizId) throws SQLException, ClassNotFoundException {
        String sql = """
                     SELECT 
                         e.*,
                         (SELECT COUNT(*) 
                          FROM exam_question eq 
                          JOIN answer a ON eq.selected_answer = a.answer_id 
                          WHERE eq.exam_id = e.exam_id AND a.is_true = 1) AS total_correct_answers
                     FROM 
                         exam e
                     WHERE 
                         e.student_id = ? AND e.quiz_id = ?;
                     """;
        List<ExamResult> list = new ArrayList<>();
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {           
            ps.setObject(1, parseLong(userId));
            ps.setObject(2, parseLong(quizId));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Exam exam = mapRow(rs);
                Long totalMarks = rs.getLong("total_correct_answers");
                list.add(ExamResult.builder()
                        .exam(exam)
                        .totalMarks(totalMarks)
                        .build());
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public ExamResult getExamResultByExamIdAndStudentIdAndQuizId(String examId, String userId, String quizId) throws SQLException, ClassNotFoundException {
        String sql = """
                     SELECT 
                         e.*,
                         (SELECT COUNT(*) 
                          FROM exam_question eq 
                          JOIN answer a ON eq.selected_answer = a.answer_id 
                          WHERE eq.exam_id = e.exam_id AND a.is_true = 1) AS total_correct_answers
                     FROM 
                         exam e
                     WHERE 
                         e.exam_id = ? AND e.student_id = ? AND e.quiz_id = ?;
                     """;

        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(examId));
            ps.setObject(2, parseLong(userId));
            ps.setObject(3, parseLong(quizId));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Exam exam = mapRow(rs);
                Long totalMarks = rs.getLong("total_correct_answers");
                return ExamResult.builder()
                        .exam(exam)
                        .totalMarks(totalMarks)
                        .build();
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }




}
