/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package root.DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import root.entities.main.Post;
import root.jdbc.RowMapper;
import java.sql.Connection;
import root.jdbc.SQLServerConnection;
import java.sql.PreparedStatement;
import java.util.Date;

/**
 *
 * @author admin
 */
public class PostDAO implements RowMapper<Post> {

    @Override
    public Post mapRow(ResultSet rs) throws SQLException {
        return Post.builder()
                .postId(rs.getLong("post_id"))
                .creator(rs.getLong("creator"))
                .postContent(rs.getString("post_content"))
                .postImage(rs.getString("post_image"))
                .hashTag(rs.getString("hashTag"))
                .createdDate(rs.getDate("created_date"))
                .build();
    }

    @Override
    public boolean addNew(Post t) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Post> getAll() throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Post getById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean updateById(String id, Post post) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE post SET  post_content = ?, post_image = ?, hashTag = ?, created_date = ? WHERE post_id = ?";
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setObject(1, post.getPostContent());
            ps.setObject(2, post.getPostImage());
            ps.setObject(3, post.getHashTag());
            ps.setObject(4, new Date());
            ps.setObject(5, parseLong(id));
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            throw e;
        }
    }

    @Override
    public boolean deleteById(String id) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM post WHERE post_id = ?";
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            throw e;
        }
    }

    public List<Post> getPostList(String content, String hashTag, String fromDate, String toDate, int page, int pageSize) {
        List<Post> posts = new ArrayList<>();
        String sql = """
            SELECT * FROM post
            WHERE (post_content LIKE ? OR hashTag LIKE ?)
            AND created_date BETWEEN ? AND ?
            ORDER BY created_date DESC
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
            """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + content + "%");
            ps.setString(2, "%" + hashTag + "%");
            ps.setString(3, fromDate);
            ps.setString(4, toDate);
            ps.setInt(5, (page - 1) * pageSize);
            ps.setInt(6, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                posts.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return posts;
    }

    public int countPosts(String content, String hashTag, String fromDate, String toDate) {
        String sql = """
        SELECT COUNT(*) FROM post
        WHERE (post_content LIKE ? OR hashTag LIKE ?)
        AND created_date BETWEEN ? AND ?
        """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + content + "%");
            ps.setString(2, "%" + hashTag + "%");
            ps.setString(3, fromDate);
            ps.setString(4, toDate);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Post getPostById(String postId) {
        String sql = "SELECT * FROM post WHERE post_id = ?";
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, postId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Post p = mapRow(rs);
                p.setAuthor(new UserDAO().getById(rs.getString("creator")));
                return p;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Long addNewPostAndGetId(Post post) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO post (creator, post_content, post_image, hashTag, created_date) VALUES (?, ?, ?, ?, ?)";
        long id = 0L;
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setLong(1, post.getCreator());
            ps.setString(2, post.getPostContent());
            ps.setString(3, post.getPostImage());
            ps.setString(4, post.getHashTag());
            ps.setDate(5, new java.sql.Date(post.getCreatedDate().getTime()));
            check = ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (check > 0) {
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

}
