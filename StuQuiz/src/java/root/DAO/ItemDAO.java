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
import root.entities.main.Item;
import root.jdbc.RowMapper;
import root.jdbc.SQLServerConnection;
import java.sql.Statement;

/**
 *
 * @author admin
 */
public class ItemDAO implements RowMapper<Item> {

    @Override
    public Item mapRow(ResultSet rs) throws SQLException {
        return Item.builder()
                .itemId(rs.getLong("item_id"))
                .buyerId(rs.getLong("buyer_id"))
                .subjectId(rs.getLong("subject_id"))
                .itemPrice(rs.getDouble("item_price"))
                .qrCode(rs.getString("qr_code"))
                .transactionCode(rs.getString("transaction_code"))
                .startDate(rs.getDate("start_date"))
                .endDate(rs.getDate("end_date"))
                .build();
    }

    @Override
    public boolean addNew(Item t) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Item> getAll() throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Item getById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean updateById(String id, Item t) throws SQLException, ClassNotFoundException {
        String sql = """
                     update [item]
                     set
                     [buyer_id ] = ?,
                     subject_id  = ?,
                     item_price = ?,
                     qr_code = ?,
                     transaction_code = ?,
                     [start_date] = ?,
                     end_date = ? where [item_id] = ?
                     """;
        int check = 0;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, t.getBuyerId());
            ps.setObject(2, t.getSubjectId());
            ps.setObject(3, t.getItemPrice());
            ps.setObject(4, t.getQrCode());
            ps.setObject(5, t.getTransactionCode());
            ps.setObject(6, t.getStartDate());
            ps.setObject(7, t.getEndDate());
            ps.setObject(8, t.getItemId());
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

    public List<Item> getListItemsBySubjectId(String subjectId) {
        List<Item> list = new ArrayList<>();
        String sql = """
                     select * from [item] where subject_id = ?
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

    public List<Item> getListItemsBySubjectIdAndUserId(String subjectId, String userId) {
        List<Item> list = new ArrayList<>();
        String sql = """
                     select * from [item] where subject_id = ? and buyer_id = ?
                     """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(subjectId));
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

    public Long addNewItemAndGetId(Item t) {
        String sql = """
                     insert into [item](
                     [buyer_id ],
                     subject_id,
                     item_price,
                     qr_code,
                     transaction_code,
                     [start_date],
                     end_date) values(?,?,?,?,?,?,?)
                     """;
        int check = 0;
        Long id = 0L;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);) {
            ps.setObject(1, t.getBuyerId());
            ps.setObject(2, t.getSubjectId());
            ps.setObject(3, t.getItemPrice());
            ps.setObject(4, t.getQrCode());
            ps.setObject(5, t.getTransactionCode());
            ps.setObject(6, t.getStartDate());
            ps.setObject(7, t.getEndDate());

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

    public Item getItemByTransactionCode(String transactionCode) throws SQLException, ClassNotFoundException {
        Item item = null;
        String sql = """
                     select * from [item] where transaction_code = ?
                     """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, transactionCode);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                item = mapRow(rs);
            } else {
                item = Item.builder()
                        .itemId(0L)
                        .build();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return item;
    }

    public double getMonthlySales() throws SQLException, ClassNotFoundException {
        double revenue = 0;
        String sql = """
                   SELECT SUM(item_price) AS total_price
                   FROM [stuquiz].[dbo].[item]
                   WHERE MONTH(start_date) = MONTH(GETDATE())
                         AND YEAR(start_date) = YEAR(GETDATE());
                   """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                revenue = rs.getDouble(1);
            }
        }
        return revenue;
    }

    public Item getItemByBuyerIdAndSubjectId(String buyerId, String subjectId) throws SQLException, ClassNotFoundException {
        String sql = """
                     select * from item where buyer_id = ? and subject_id = ?
              """;
        Item item = null;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(buyerId));
            ps.setObject(2, parseLong(subjectId));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                item = mapRow(rs);
            } else {
                item = Item.builder()
                        .itemId(0L)
                        .build();
            }
        } catch (SQLException | ClassNotFoundException e) {
            item = Item.builder()
                    .itemId(0L)
                    .build();
        }
        return item;
    }

    public double getTeacherMonthlySales(String userId) throws SQLException, ClassNotFoundException {
        double revenue = 0;
        String sql = """
                SELECT SUM(i.item_price) AS total_price
                   FROM [stuquiz].[dbo].[item] i
                   JOIN [stuquiz].[dbo].[subject] s
                   ON i.subject_id = s.subject_id
                   WHERE MONTH(i.start_date) = MONTH(GETDATE())
                   AND YEAR(i.start_date) = YEAR(GETDATE())
                   AND s.owner_id = ?;
                   """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setObject(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                revenue = rs.getDouble(1);
            }
        }
        return revenue;
    }
    
    public Item getBuyerId(String userId, String subjectId) throws SQLException, ClassNotFoundException {
        Item item = null;
        String sql = "SELECT * FROM [item] WHERE [buyer_id] = ? AND [subject_id] = ?";
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, userId);
            ps.setString(2, subjectId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    item = mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw e;
        }
        return item;
    }
}
