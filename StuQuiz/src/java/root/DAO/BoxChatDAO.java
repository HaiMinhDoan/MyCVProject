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
import root.entities.main.BoxChat;
import root.jdbc.RowMapper;
import root.jdbc.SQLServerConnection;

/**
 *
 * @author admin
 */
public class BoxChatDAO implements RowMapper<BoxChat> {

    @Override
    public BoxChat mapRow(ResultSet rs) throws SQLException {
        Long longDate = 0L;
        try {
            longDate = parseLong(rs.getString("send_time"));
        } catch (Exception e) {
            longDate = 0L;
        }
        return BoxChat.builder()
                .boxChatId(rs.getLong("boxchat_id"))
                .senderId(rs.getLong("sender_id"))
                .receiverId(rs.getLong("receiver_id"))
                .chatContent(rs.getString("chat_content"))
                .sendTime(new Date(Math.abs(longDate)))
                .seen(longDate > 0)
                .build();
    }

    @Override
    public boolean addNew(BoxChat t) throws SQLException, ClassNotFoundException {
        String sql = """
                     insert into [boxchat](
                     sender_id,
                     receiver_id,
                     chat_content,
                     send_time) values(?,?,?,?)
                     """;
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, t.getSenderId());
            ps.setObject(2, t.getReceiverId());
            ps.setObject(3, t.getChatContent());
            ps.setObject(4, (t.isSeen() ? t.getSendTime().getTime() : -t.getSendTime().getTime()) + "");
            check = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return check > 0;
    }

    @Override
    public List<BoxChat> getAll() throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public BoxChat getById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean updateById(String id, BoxChat t) throws SQLException, ClassNotFoundException {
        String sql = """
                     update [boxchat]
                     set
                     sender_id = ?,
                     receiver_id  = ?,
                     chat_content = ?,
                     send_time = ? where [boxchat_id] = ?
                     """;
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, t.getSenderId());
            ps.setObject(2, t.getReceiverId());
            ps.setObject(3, t.getChatContent());
            ps.setObject(4, (t.isSeen() ? t.getSendTime().getTime() : -t.getSendTime().getTime()) + "");
            ps.setObject(5, parseLong(id));
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

    public List<BoxChat> getListAllBoxChatByMembers(String user1, String user2) throws SQLException, ClassNotFoundException {
        List<BoxChat> list = new ArrayList<>();
        String sql = """
              select * from [boxchat] where (sender_id = ? and receiver_id = ?) or (receiver_id = ? and sender_id = ?)
              """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(user1));
            ps.setObject(2, parseLong(user2));
            ps.setObject(3, parseLong(user1));
            ps.setObject(4, parseLong(user2));
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

    public List<BoxChat> getListAllBoxChatByMembers(String userId) throws SQLException, ClassNotFoundException {
        List<BoxChat> list = new ArrayList<>();
        String sql = """
              select * from [boxchat] where sender_id = ? or receiver_id = ?
              """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(userId));
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

    public BoxChat getLastestBoxChatByUserId(String id) throws SQLException, ClassNotFoundException {
        BoxChat boxChat = new BoxChat();
        String sql = """
              WITH LastMessages AS (
                  SELECT *,
                         ROW_NUMBER() OVER (PARTITION BY CASE
                                                            WHEN sender_id = ? THEN receiver_id
                                                            ELSE sender_id
                                                        END
                                            ORDER BY chat_id DESC) AS rn
                  FROM boxchat
                  WHERE sender_id = ? OR receiver_id = ?
              )
              SELECT boxchat_id, sender_id, receiver_id, chat_content, send_time
              FROM LastMessages
              WHERE rn = 1;
              """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(id));
            ps.setObject(2, parseLong(id));
            ps.setObject(3, parseLong(id));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                boxChat = mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return boxChat;
    }
    public BoxChat getLastestBoxChatBySenderAndReceiverId(String senderId, String receiverId) throws SQLException, ClassNotFoundException {
        BoxChat boxChat = new BoxChat();
        String sql = """
              select top 1 * from boxchat where sender_id= ? and receiver_id = ?
                     order by boxchat_id desc
              """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(senderId));
            ps.setObject(2, parseLong(receiverId));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                boxChat = mapRow(rs);
            } else {
                boxChat.setBoxChatId(0L);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return boxChat;
    }

}
