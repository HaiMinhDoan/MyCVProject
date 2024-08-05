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
import java.util.Date;
import java.util.List;
import root.entities.main.Comment;
import root.jdbc.RowMapper;
import root.jdbc.SQLServerConnection;

/**
 *
 * @author admin
 */
public class CommentDAO implements RowMapper<Comment> {

    @Override
    public Comment mapRow(ResultSet rs) throws SQLException {
        Long commentTimeLong = 0L;
        try {
            commentTimeLong = parseLong(rs.getString("comment_time"));
        } catch (NumberFormatException e) {
        }
        return Comment.builder()
                .commentId(rs.getLong("comment_id"))
                .userId(rs.getLong("user_id"))
                .lessonId(rs.getLong("lesson_id"))
                .preComment(rs.getLong("pre_comment"))
                .commentContent(rs.getString("comment_content"))
                .commentTime(new Date(commentTimeLong))
                .isActive(rs.getBoolean("is_active"))
                .build();
    }

    @Override
    public boolean addNew(Comment t) throws SQLException, ClassNotFoundException {
        String sql = """
                     INSERT INTO [dbo].[comment]
                                ([user_id]
                                ,[lesson_id]
                                ,[pre_comment]
                                ,[comment_content]
                                ,[comment_time]
                                ,[is_active])
                          VALUES
                                (?, ?, ?, ?, ?, ?)""";
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, t.getUserId());
            ps.setObject(2, t.getLessonId());
            ps.setObject(3, t.getPreComment());
            ps.setObject(4, t.getCommentContent());
            ps.setObject(5, t.getCommentTime().getTime() + "");
            ps.setObject(6, t.isActive());
            check = ps.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return check > 0;

    }

    @Override
    public List<Comment> getAll() throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Comment getById(String id) throws SQLException, ClassNotFoundException {
        String sql = "select * from comment where comment_id = ?";
        Comment comment = Comment.builder().commentId(0L).build();
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                comment =mapRow(rs);
            }
        } catch (SQLException | ClassNotFoundException e) {
            comment = Comment.builder().commentId(0L).build();
            e.printStackTrace();
        }
        return comment;
    }

    @Override
    public boolean updateById(String id, Comment t) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean deleteById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public List<Comment> getHeadCommentsByLessonId(String id) {
        String sql = "select * from comment where lesson_id = ? and pre_comment = 0";
        List<Comment> comments = new ArrayList<>();
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    comments.add(mapRow(rs));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return comments;
    }

    public Long addNewCommentAndGetId(Comment t) throws SQLException, ClassNotFoundException {
        String sql = """
                     INSERT INTO [dbo].[comment]
                                ([user_id]
                                ,[lesson_id]
                                ,[pre_comment]
                                ,[comment_content]
                                ,[comment_time]
                                ,[is_active])
                          VALUES
                                (?, ?, ?, ?, ?, ?)""";
        long id = 0L;
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);) {
            ps.setObject(1, t.getUserId());
            ps.setObject(2, t.getLessonId());
            ps.setObject(3, t.getPreComment());
            ps.setObject(4, t.getCommentContent());
            ps.setObject(5, t.getCommentTime().getTime() + "");
            ps.setObject(6, t.isActive());
            check = ps.executeUpdate();
            if (check > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    id = rs.getLong(1);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            id = 0L;
            e.printStackTrace();
        }
        return id;

    }
    
    public List<Comment> getListCommentByPreComment(String id) throws SQLException, ClassNotFoundException{
        String sql = "select * from comment where pre_comment = ?";
        List<Comment> comments = new ArrayList<>();
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    comments.add(mapRow(rs));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return comments;
    }

}
