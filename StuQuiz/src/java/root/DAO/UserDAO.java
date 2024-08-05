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
import root.entities.main.User;
import root.jdbc.RowMapper;
import root.jdbc.SQLServerConnection;

/**
 *
 * @author admin
 */
public class UserDAO implements RowMapper<User> {

    @Override
    public User mapRow(ResultSet rs) throws SQLException {
        Long longDate = parseLong(rs.getString("created_time"));
        Date createdTime = new Date(longDate);
        return User.builder()
                .userId(rs.getLong("user_id"))
                .userName(rs.getString("user_name"))
                .userEmail(rs.getString("user_email"))
                .userPassword(rs.getString("user_password"))
                .roleLevel(rs.getLong("role_level"))
                .userAvatar(rs.getString("user_avatar"))
                .userBank(rs.getString("user_bank"))
                .userBankCode(rs.getString("user_bank_code"))
                .createdTime(createdTime)
                .activeCode(rs.getString("active_code"))
                .isActive(rs.getBoolean("is_active"))
                .build();
    }

    @Override
    public boolean addNew(User t) throws SQLException, ClassNotFoundException {
        String sql = """
                     insert into [user](
                     [user_name],
                     user_email,
                     user_password,
                     role_level,
                     user_avatar,
                     user_bank,
                     user_bank_code,
                     created_time,
                     active_code,
                     is_active) values(?,?,?,?,?,?,?,?,?,?)
                     """;
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, t.getUserName());
            ps.setObject(2, t.getUserEmail());
            ps.setObject(3, t.getUserPassword());
            ps.setObject(4, t.getRoleLevel());
            ps.setObject(5, t.getUserAvatar());
            ps.setObject(6, t.getUserBank());
            ps.setObject(7, t.getUserBankCode());
            ps.setObject(8, t.getCreatedTime().getTime());
            ps.setObject(9, t.getActiveCode());
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
    public List<User> getAll() throws SQLException, ClassNotFoundException {
        List<User> list = new ArrayList<>();
        String sql = """
              select * from [user]
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
    public User getById(String id) throws SQLException, ClassNotFoundException {
        User user = null;
        String sql = """
              select * from [user] where [user_id]=?
              """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(id));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = mapRow(rs);
            }
            if (user == null) {
                user = User.builder().userId(0L).build();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public boolean updateById(String id, User t) throws SQLException, ClassNotFoundException {
        String sql = """
                     update [user]
                     set
                     [user_name] = ?,
                     user_password  = ?,
                     role_level = ?,
                     user_avatar = ?,
                     user_bank  = ?,
                     user_bank_code = ?,
                     created_time = ?,
                     active_code = ?,
                     is_active = ? where [user_id] = ?
                     """;
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, t.getUserName());
            ps.setObject(2, t.getUserPassword());
            ps.setObject(3, t.getRoleLevel());
            ps.setObject(4, t.getUserAvatar());
            ps.setObject(5, t.getUserBank());
            ps.setObject(6, t.getUserBankCode());
            ps.setObject(7, t.getCreatedTime().getTime());
            ps.setObject(8, t.getActiveCode());
            ps.setObject(9, t.isActive());
            ps.setObject(10, parseLong(id));
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
        String sql = """
                     delete from [user] where [user_id] = ?
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

    public User getByEmail(String email) throws SQLException, ClassNotFoundException {
        User user = new User();
        user.setUserId(0L);
        String sql = """
              select * from [user] where [user_email]=?
              """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return user;
    }

    public List<User> getListUserChatWith(String userId) throws SQLException, ClassNotFoundException {
        List<User> list = new ArrayList<>();
        String sql = """
              SELECT DISTINCT u.*
              FROM [user] u
              JOIN boxchat b ON u.user_id = b.sender_id OR u.user_id = b.receiver_id
              WHERE b.sender_id = ? OR b.receiver_id = ?;
              """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(userId));
            ps.setObject(2, parseLong(userId));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = mapRow(rs);
                if (!userId.equals(user.getUserId() + "")) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<User> getAllContainWithEmailAndName(String searchString) {
        List<User> list = new ArrayList<>();
        String sql = """
              select * from [user]
              """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = mapRow(rs);
                if (user.getUserEmail().trim().toLowerCase().contains(searchString.trim().toLowerCase()) || user.getUserName().trim().toLowerCase().contains(searchString.trim().toLowerCase())) {
                    list.add(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    public String checkExistByEmail(String email) {
        String sql = """
                  select user_email from [user] where user_email = ? 
                     """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean setKeyByEmail(String email, String code) {
        String sql = """
                     update [user]
                     set  active_code = ? where user_email = ?
                     """;
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, code);
            ps.setObject(2, email);
            check = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return check > 0;
    }

    public String getKeyByEmail(String email) {
        String sql = """
                  select active_code from [user] where user_email = ? 
                     """;
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean setKeyPassEmail(String email, String pass) {
        String sql = """
                     update [user]
                     set  user_password = ? where user_email = ?
                     """;
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, pass);
            ps.setObject(2, email);
            check = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return check > 0;
    }

    public User getByIdStaff(String id) throws SQLException, ClassNotFoundException {
        User user = new User();
        String sql = "select * from [user] where [user_id]=? and role_level >= 3";
        try {
            Connection con = SQLServerConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = mapRow(rs);
            }
        } catch (SQLException e) {
            System.out.println("Get user by id: " + e);
        } catch (ClassNotFoundException e) {
            System.out.println("Get user by id: " + e);
        }
        return user;
    }

    public List<User> getAllByStatusStaff(String status, String sortTime, String sortName, String search) {
        List<User> list = new ArrayList<>();
        String sql = "select * from [user] where role_level >= 3";
        if (!status.equals("all") || !search.trim().equals("")) {
            sql += " and ";
        }
        if (!status.equals("all")) {
            sql += "is_active=?";
        }
        if (!status.equals("all") && !search.trim().equals("")) {
            sql += " and";
        }
        if (!search.trim().equals("")) {
            sql += " (user_name like ? or user_email like ?)";
        }
        sql += (" order by user_name " + sortName + ", user_id " + sortTime);
        try {
            Connection con = SQLServerConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            int index = 1;
            if (!status.equals("all")) {
                ps.setBoolean(index++, Boolean.parseBoolean(status));
            }
            if (!search.trim().equals("")) {
                ps.setString(index++, "%" + search + "%");
                ps.setString(index++, "%" + search + "%");
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("Get all user: " + e);
        } catch (ClassNotFoundException e) {
            System.out.println("Get all user: " + e);
        }
        return list;
    }

    public List<User> getAllByStaff() {
        List<User> list = new ArrayList<>();
        String sql = "select * from [user] where role_level >=3";
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("Get all user: " + e);
        } catch (ClassNotFoundException e) {
            System.out.println("Get all user: " + e);
        }
        return list;
    }

    public int deleteAccount(int id) {
        String sql = """
                     update [user]
                     set
                     is_active = 0 where [user_id] = ?
                     """;
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, id);
            return check = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Delete account: " + e);
        }
        return 0;
    }
    public int restoreAccount(int id) {
        String sql = """
                     update [user]
                     set
                     is_active = 1 where [user_id] = ?
                     """;
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, id);
            return check = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Delete account: " + e);
        }
        return 0;
    }

    public List<User> getAllByStatus(String status, String sortTime, String sortName, String search) {
        List<User> list = new ArrayList<>();
        String sql = "select * from [user] where 1=1";
        if (!status.equals("all") || !search.trim().equals("")) {
            sql += " and ";
        }
        if (!status.equals("all")) {
            sql += "is_active=?";
        }
        if (!status.equals("all") && !search.trim().equals("")) {
            sql += " and";
        }
        if (!search.trim().equals("")) {
            sql += " (user_name like ? or user_email like ?)";
        }
        sql += (" order by user_name " + sortName + ", user_id " + sortTime);
        try {
            Connection con = SQLServerConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            int index = 1;
            if (!status.equals("all")) {
                ps.setBoolean(index++, Boolean.parseBoolean(status));
            }
            if (!search.trim().equals("")) {
                ps.setString(index++, "%" + search + "%");
                ps.setString(index++, "%" + search + "%");
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("Get all user: " + e);
        } catch (ClassNotFoundException e) {
            System.out.println("Get all user: " + e);
        }
        return list;
    }

    public int updateUserAccount(String id, User t) {
        String sql = """
                     update [user]
                     set
                     [user_name] = ?,
                     role_level = ?,
                     user_avatar = ?,
                     user_bank  = ?,
                     user_bank_code = ?,
                     active_code = ?,
                     is_active = ? where [user_id] = ?
                     """;
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            int index = 1;
            ps.setObject(index++, t.getUserName());
            ps.setObject(index++, t.getRoleLevel());
            ps.setObject(index++, t.getUserAvatar());
            ps.setObject(index++, t.getUserBank());
            ps.setObject(index++, t.getUserBankCode());
            ps.setObject(index++, t.getActiveCode());
            ps.setObject(index++, t.isActive());
            ps.setObject(index++, parseLong(id));
            return check = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Update account: " + e);
        }
        return 0;
    }

    public int updateEoleUserAccount(String id, int role) {
        String sql = "update [user] set role_level = ?, where [user_id] = ?";
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            int index = 1;
            ps.setObject(index++, role);
            ps.setObject(index++, parseLong(id));
            return check = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Update account: " + e);
        }
        return 0;
    }

}
