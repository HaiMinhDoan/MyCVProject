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
import root.entities.main.Course;
import root.jdbc.RowMapper;
import root.jdbc.SQLServerConnection;

/**
 *
 * @author admin
 */
public class CourseDAO implements RowMapper<Course> {

    @Override
    public Course mapRow(ResultSet rs) throws SQLException {
        return Course.builder()
                .courseId(rs.getLong("course_id"))
                .courseName(rs.getString("course_name"))
                .courseCode(rs.getString("course_code"))
                .isActive(rs.getBoolean("is_active"))
                .build();
    }

    @Override
    public boolean addNew(Course t) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO [course] (course_name, course_code, is_active) VALUES (?, ?, ?)";
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, t.getCourseName());
            ps.setString(2, t.getCourseCode());
            ps.setBoolean(3, t.isActive());
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            throw e;
        }
    }

    @Override
    public List<Course> getAll() throws SQLException, ClassNotFoundException {
        List<Course> list = new ArrayList<>();
        String sql = """
                     select * from [course]
                     """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
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

    @Override
    public Course getById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean updateById(String id, Course t) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE [course] SET course_name = ?, course_code = ?, is_active = ? WHERE course_id = ?";
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, t.getCourseName());
            ps.setString(2, t.getCourseCode());
            ps.setBoolean(3, t.isActive());
            ps.setLong(4, Long.parseLong(id));
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            throw e;
        }
    }

    @Override
    public boolean deleteById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public boolean deleteCourseAndReferencesByCourseId(String id) throws SQLException, ClassNotFoundException {
        String sql = """
                     BEGIN TRANSACTION;
    
                     DELETE FROM item WHERE subject_id IN (SELECT subject_id FROM [subject] WHERE course_id = ?);
                     DELETE FROM comment WHERE lesson_id IN (SELECT lesson_id FROM lesson WHERE subject_id IN (SELECT subject_id FROM [subject] WHERE course_id = ?));
                     DELETE FROM vote WHERE lesson_id IN (SELECT lesson_id FROM lesson WHERE subject_id IN (SELECT subject_id FROM [subject] WHERE course_id = ?));
                     DELETE FROM subject_statistic WHERE subject_id IN (SELECT subject_id FROM [subject] WHERE course_id = ?);
                     DELETE FROM exam_question WHERE question_id IN (SELECT question_id FROM question WHERE subject_id IN (SELECT subject_id FROM [subject] WHERE course_id = ?));
                     DELETE FROM quiz_bank WHERE question_id IN (SELECT question_id FROM question WHERE subject_id IN (SELECT subject_id FROM [subject] WHERE course_id = ?));
                     DELETE FROM answer WHERE question_id IN (SELECT question_id FROM question WHERE subject_id IN (SELECT subject_id FROM [subject] WHERE course_id = ?));
                     DELETE FROM question WHERE subject_id IN (SELECT subject_id FROM [subject] WHERE course_id = ?);
                     DELETE FROM exam WHERE quiz_id IN (SELECT quiz_id FROM quiz WHERE lesson_id IN (SELECT lesson_id FROM lesson WHERE subject_id IN (SELECT subject_id FROM [subject] WHERE course_id = ?)));
                     DELETE FROM quiz WHERE lesson_id IN (SELECT lesson_id FROM lesson WHERE subject_id IN (SELECT subject_id FROM [subject] WHERE course_id = ?));
                     DELETE FROM lesson WHERE subject_id IN (SELECT subject_id FROM [subject] WHERE course_id = ?);
                     DELETE FROM [subject] WHERE course_id = ?;
                     DELETE FROM course WHERE course_id = ?;
    
                     COMMIT TRANSACTION;
                     """;
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            Long idLong = parseLong(id);
            for (int i = 1; i <= 13; i++) {
                ps.setObject(i, idLong);
            }
            check = ps.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
        }
        return check > 0;
    }

}
