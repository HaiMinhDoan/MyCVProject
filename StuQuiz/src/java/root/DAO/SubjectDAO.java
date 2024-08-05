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
import java.util.Collections;
import java.util.List;
import root.entities.main.Item;
import root.entities.main.Lesson;
import root.entities.main.Subject;
import root.entities.main.User;
import root.entities.sub.SubjectEnrolledAndStatus;
import root.entities.sub.SubjectWithListItemAndLesson;
import root.entities.sub.VotesInSubject;
import root.jdbc.RowMapper;
import root.jdbc.SQLServerConnection;

/**
 *
 * @author admin
 */
public class SubjectDAO implements RowMapper<Subject> {

    @Override
    public Subject mapRow(ResultSet rs) throws SQLException {
        return Subject.builder()
                .subjectId(rs.getLong("subject_id"))
                .ownerId(rs.getLong("owner_id"))
                .courseId(rs.getLong("course_id"))
                .subjectCode(rs.getString("subject_code"))
                .subjectName(rs.getString("subject_name"))
                .subjectDescription(rs.getString("subject_description"))
                .subjectImage(rs.getString("subject_image"))
                .subjectPrice(rs.getDouble("subject_price"))
                .salePrice(rs.getDouble("sale_price"))
                .createdDate(rs.getDate("created_date"))
                .isActive(rs.getBoolean("is_active"))
                .build();
    }

    @Override
    public boolean addNew(Subject t) throws SQLException, ClassNotFoundException {
        String sql = """
                     insert into [subject](
                     [owner_id],
                     course_id,
                     subject_code,
                     subject_name,
                     subject_description,
                     subject_image,
                     subject_price,
                     sale_price,
                     created_date,
                     is_active) values(?,?,?,?,?,?,?,?,?,?)
                     """;
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, t.getOwnerId());
            ps.setObject(2, t.getCourseId());
            ps.setObject(3, t.getSubjectCode());
            ps.setObject(4, t.getSubjectName());
            ps.setObject(5, t.getSubjectDescription());
            ps.setObject(6, t.getSubjectImage());
            ps.setObject(7, t.getSubjectPrice());
            ps.setObject(8, t.getSalePrice());
            ps.setObject(9, t.getCreatedDate());
            ps.setObject(10, t.isActive());
            check = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return check > 0;
    }

    @Override
    public List<Subject> getAll() throws SQLException, ClassNotFoundException {
        List<Subject> list = new ArrayList<>();
        String sql = """
              select * from [subject]
              """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Subject s = new SubjectDAO().mapRow(rs);
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Subject getById(String id) throws SQLException, ClassNotFoundException {
        Subject subject = null;
        String sql = """
              select * from [subject] where [subject_id]=?
              """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(id));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                subject = mapRow(rs);
            }
            if (subject == null) {
                subject = Subject.builder().subjectId(0L).build();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return subject;
    }

    @Override
    public boolean updateById(String id, Subject t) throws SQLException, ClassNotFoundException {
        String sql = """
                     update [subject]
                     set
                     [owner_id] = ?,
                     course_id = ?,
                     subject_code = ?,
                     subject_name = ?,
                     subject_description = ?,
                     subject_image = ?,
                     subject_price = ?,
                     sale_price = ?,
                     created_date = ?,
                     is_active = ? where [subject_id] = ?
                     """;
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, t.getOwnerId());
            ps.setObject(2, t.getCourseId());
            ps.setObject(3, t.getSubjectCode());
            ps.setObject(4, t.getSubjectName());
            ps.setObject(5, t.getSubjectDescription());
            ps.setObject(6, t.getSubjectImage());
            ps.setObject(7, t.getSubjectPrice());
            ps.setObject(8, t.getSalePrice());
            ps.setObject(9, t.getCreatedDate());
            ps.setObject(10, t.isActive());
            ps.setObject(11, parseLong(id));
            check = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return check > 0;
    }

    @Override
    public boolean deleteById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public boolean softDeleteById(String id) throws SQLException, ClassNotFoundException {

        String sql = """
                     update [subject]
                     set
                     is_active = 0 where [subject_id] = ?
                     """;
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(id));
            check = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return check > 0;
    }
    public boolean softRestoreById(String id) throws SQLException, ClassNotFoundException {

        String sql = """
                     update [subject]
                     set
                     is_active = 1 where [subject_id] = ?
                     """;
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(id));
            check = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return check > 0;
    }

    public List<SubjectWithListItemAndLesson> getNewSubjectWithListItemAndLesson(String numberOfSubject) {
        List<SubjectWithListItemAndLesson> list = new ArrayList<>();
        String sql = """
                    SELECT TOP (?) *
                    FROM [subject]
                    ORDER BY [created_date] DESC;                 
                    """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            List<Subject> listSubjects = new ArrayList<>();
            ps.setObject(1, parseLong(numberOfSubject));
            ResultSet rs = ps.executeQuery();
            ItemDAO itemDAO = new ItemDAO();
            LessonDAO lessonDAO = new LessonDAO();
            while (rs.next()) {
                listSubjects.add(mapRow(rs));
            }
            for (Subject subject : listSubjects) {
                List<Lesson> listLessons = new ArrayList<>();
                listLessons = lessonDAO.getListLessonBySubjectId(subject.getSubjectId() + "");
                List<Item> listItems = new ArrayList<>();
                listItems = itemDAO.getListItemsBySubjectId(subject.getSubjectId() + "");
                list.add(SubjectWithListItemAndLesson.builder().subject(subject).listItems(listItems).listLessons(listLessons).build());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<SubjectWithListItemAndLesson> getFeatureSubjectWithListItemAndLesson(String numberOfSubject, String numberOfMonths) {
        List<SubjectWithListItemAndLesson> list = new ArrayList<>();
        String sql = """
                    SELECT TOP (?)
                        s.*
                    FROM
                        [subject] s
                    JOIN
                        item i ON s.subject_id = i.subject_id
                    WHERE
                        i.[start_date] >= DATEADD(MONTH, -(?), GETDATE())
                    GROUP BY
                        s.subject_id, s.owner_id, s.course_id, s.subject_code, s.subject_name, s.subject_description, s.subject_image, s.subject_price, s.sale_price, s.created_date, s.is_active
                    ORDER BY
                        COUNT(i.item_id) DESC;              
                    """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            List<Subject> listSubjects = new ArrayList<>();
            ps.setObject(1, parseLong(numberOfSubject));
            ps.setObject(2, parseLong(numberOfMonths));
            ResultSet rs = ps.executeQuery();
            ItemDAO itemDAO = new ItemDAO();
            LessonDAO lessonDAO = new LessonDAO();
            while (rs.next()) {
                listSubjects.add(mapRow(rs));
            }
            for (Subject subject : listSubjects) {
                List<Lesson> listLessons = new ArrayList<>();
                listLessons = lessonDAO.getListLessonBySubjectId(subject.getSubjectId() + "");
                List<Item> listItems = new ArrayList<>();
                listItems = itemDAO.getListItemsBySubjectId(subject.getSubjectId() + "");
                list.add(SubjectWithListItemAndLesson.builder().subject(subject).listItems(listItems).listLessons(listLessons).build());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<SubjectWithListItemAndLesson> getListSubjectWithListItemAndLessonByCourseId(String courseId, String searchText, boolean isOldest) {
        List<SubjectWithListItemAndLesson> list = new ArrayList<>();
        String sql = """
                    select * from [subject]
                     """
                + (courseId.equals("0") ? "" : " where course_id = ?")
                + """           
                    ORDER BY created_date DESC
                     """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            List<Subject> listSubjects = new ArrayList<>();
            if (!courseId.equals("0")) {
                ps.setObject(1, parseLong(courseId));
            }
            ResultSet rs = ps.executeQuery();
            ItemDAO itemDAO = new ItemDAO();
            LessonDAO lessonDAO = new LessonDAO();
            while (rs.next()) {
                listSubjects.add(mapRow(rs));
            }
            for (Subject subject : listSubjects) {
                if (subject.getSubjectName().toLowerCase().trim().contains(searchText.toLowerCase().trim())
                        || subject.getSubjectCode().toLowerCase().trim().contains(searchText.toLowerCase().trim())) {
                    List<Lesson> listLessons = new ArrayList<>();
                    listLessons = lessonDAO.getListLessonBySubjectId(subject.getSubjectId() + "");
                    List<Item> listItems = new ArrayList<>();
                    listItems = itemDAO.getListItemsBySubjectId(subject.getSubjectId() + "");
                    list.add(SubjectWithListItemAndLesson.builder().subject(subject).listItems(listItems).listLessons(listLessons).build());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        if (isOldest) {
            Collections.reverse(list);
        }
        return list;
    }

    public List<Subject> getRelatedSubject(Long courseId) throws SQLException, ClassNotFoundException {
        List<Subject> list = new ArrayList<>();
        String sql = "SELECT TOP 3 * FROM [subject] WHERE course_id = ? ORDER BY NEWID()";
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    public List<VotesInSubject> getVotesInSubject(String id) throws SQLException, ClassNotFoundException {
        List<VotesInSubject> list = new ArrayList<>();
        String sql = """
            SELECT l.subject_id, AVG(CAST(v.star AS float)) AS avg_rating
            FROM vote v
            JOIN lesson l ON v.lesson_id = l.lesson_id
            WHERE l.subject_id = ?
            GROUP BY l.subject_id;
            """;

        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    VotesInSubject commentsInSubject = new VotesInSubject();
                    commentsInSubject.setSubjectId(rs.getLong(1));
                    commentsInSubject.setTotalVote(rs.getFloat(2));
                    list.add(commentsInSubject);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    public Long addNewSubjectAndGetId(Subject t) throws SQLException, ClassNotFoundException {
        String sql = """
                     insert into [subject](
                     [owner_id],
                     course_id,
                     subject_code,
                     subject_name,
                     subject_description,
                     subject_image,
                     subject_price,
                     sale_price,
                     created_date,
                     is_active) values(?,?,?,?,?,?,?,?,?,?)
                     """;
        long check = 0L;
        long id = 0L;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);) {
            ps.setObject(1, t.getOwnerId());
            ps.setObject(2, t.getCourseId());
            ps.setObject(3, t.getSubjectCode());
            ps.setObject(4, t.getSubjectName());
            ps.setObject(5, t.getSubjectDescription());
            ps.setObject(6, t.getSubjectImage());
            ps.setObject(7, t.getSubjectPrice());
            ps.setObject(8, t.getSalePrice());
            ps.setObject(9, t.getCreatedDate());
            ps.setObject(10, t.isActive());
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

    public List<Subject> getListSubjectByTeacherId(String id) throws SQLException, ClassNotFoundException {
        List<Subject> list = new ArrayList<>();
        String sql = """
              select * from [subject] where owner_id = ?
              """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(id));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Subject s = new SubjectDAO().mapRow(rs);
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Subject> getEnrolledSubjectByUserId(String userId) throws SQLException, ClassNotFoundException {
        List<Subject> list = new ArrayList<>();
        String sql = """
                     SELECT s.*
                     FROM [subject] s
                     JOIN item i ON s.subject_id = i.subject_id
                     WHERE i.buyer_id = ?
                     """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setObject(1, parseLong(userId));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException | ClassNotFoundException e) {
        }

        return list;
    }

    public List<SubjectEnrolledAndStatus> getEnrollSubjectAndStatusBySubjectId(String subjectId) throws SQLException, ClassNotFoundException {
        List<SubjectEnrolledAndStatus> list = new ArrayList<>();
        String sql = """
                     SELECT 
                         s.* 
                     FROM 
                         subject s 
                     WHERE 
                         s.subject_id = ?;
                     """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setObject(1, Long.valueOf(subjectId));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Subject subject = mapRow(rs);
                Double salePrice = rs.getDouble("sale_price");

                SubjectEnrolledAndStatus subjectEnrolledAndStatus = SubjectEnrolledAndStatus.builder()
                        .subject(subject)
                        .salePrice(salePrice)
                        .build();
                list.add(subjectEnrolledAndStatus);
            }
        } catch (SQLException e) {
        }
        return list;
    }

}
