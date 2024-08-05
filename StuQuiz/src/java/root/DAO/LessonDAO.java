/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package root.DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import root.entities.main.Lesson;
import root.jdbc.RowMapper;
import root.jdbc.SQLServerConnection;

/**
 *
 * @author admin
 */
public class LessonDAO implements RowMapper<Lesson> {

    @Override
    public Lesson mapRow(ResultSet rs) throws SQLException {
        return Lesson.builder()
                .lessonId(rs.getLong("lesson_id"))
                .lessonName(rs.getString("lesson_name"))
                .subjectId(rs.getLong("subject_id"))
                .videoLink(rs.getString("video_link"))
                .lessonDescription(rs.getString("lesson_description"))
                .createdDate(rs.getDate("created_date"))
                .isActive(rs.getBoolean("is_active"))
                .build();
    }

    @Override
    public boolean addNew(Lesson t) throws SQLException, ClassNotFoundException {
        String sql = """
                     INSERT INTO [lesson]
                                ([lesson_name]
                                ,[subject_id]
                                ,[video_link]
                                ,[lesson_description]
                                ,[created_date]
                                ,[is_active])
                          VALUES
                                (?, ?, ?, ?, ?, ?)""";
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, t.getLessonName());
            ps.setObject(2, t.getSubjectId());
            ps.setObject(3, t.getVideoLink());
            ps.setObject(4, t.getLessonDescription());
            ps.setObject(5, t.getCreatedDate());
            ps.setObject(6, t.isActive());
            check = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return check > 0;
    }

    @Override
    public List<Lesson> getAll() throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Lesson getById(String id) throws SQLException, ClassNotFoundException {
        Lesson lesson = Lesson.builder().lessonId(0L).build();
        String sql = """
                     select * from lesson where lesson_id = ? 
                     """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(id));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lesson = mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return lesson;
    }

    @Override
    public boolean updateById(String id, Lesson lesson) throws SQLException, ClassNotFoundException {
        String sql = """
                 UPDATE lesson 
                 SET lesson_name = ?, 
                     subject_id = ?, 
                     video_link = ?, 
                     lesson_description = ?, 
                     created_date = ?, 
                     is_active = ? 
                 WHERE lesson_id = ?
                 """;

        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, lesson.getLessonName());
            ps.setLong(2, lesson.getSubjectId());
            ps.setString(3, lesson.getVideoLink());
            ps.setString(4, lesson.getLessonDescription());
            ps.setDate(5, (Date) lesson.getCreatedDate());
            ps.setBoolean(6, lesson.isActive());
            ps.setLong(7, Long.parseLong(id));

            int rowsUpdated = ps.executeUpdate();
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
        String sql = "DELETE FROM lesson WHERE lesson_id = ?";
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setObject(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public List<Lesson> getListLessonBySubjectId(String subjectId) {
        List<Lesson> list = new ArrayList<>();
        String sql = """
                     select * from lesson where subject_id = ? and is_active = 1
                     """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(subjectId));
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
    
        public List<Lesson> getListLessonBySubjectIdForTeacher(String subjectId) {
        List<Lesson> list = new ArrayList<>();
        String sql = """
                     select * from lesson where subject_id =?
                     """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(subjectId));
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

    public boolean setInactive(String id) throws SQLException, ClassNotFoundException {
        String sql = """
                 UPDATE lesson 
                 SET is_active = 0 
                 WHERE lesson_id = ?
                 """;

        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setObject(1, id);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean setActive(String id) throws SQLException, ClassNotFoundException {
        String sql = """
                 UPDATE lesson 
                 SET is_active = 1  
                 WHERE lesson_id = ?
                 """;

        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setObject(1, id);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean lessonUpdateByTeacher(String lessonId, String lessonName, String videoLink, String lessonDescription) throws SQLException {
        String sql = """
            UPDATE lesson 
            SET lesson_name = ?, 
                video_link = ?, 
                lesson_description = ?
            WHERE lesson_id = ?
            """;

        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setObject(1, lessonName);
            ps.setObject(2, videoLink);
            ps.setObject(3, lessonDescription);
            ps.setObject(4, lessonId);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        LessonDAO l = new LessonDAO();
        List<Lesson> a = new ArrayList<>();
        a = l.getListLessonBySubjectId(1 + "");
        System.out.println(a);
    }
}
