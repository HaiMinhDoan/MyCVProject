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
import java.util.logging.Level;
import java.util.logging.Logger;
import root.entities.main.Subject;
import root.entities.main.SubjectStatistic;
import root.jdbc.RowMapper;
import root.jdbc.SQLServerConnection;

/**
 *
 * @author admin
 */
public class SubjectStatisticDAO implements RowMapper<SubjectStatistic> {

    @Override
    public SubjectStatistic mapRow(ResultSet rs) throws SQLException {
        return SubjectStatistic.builder()
                .subjectStatisticId(rs.getLong("subject_statistic_id"))
                .subjectId(rs.getLong("subject_id"))
                .revenue(rs.getDouble("revenue"))
                .purchases(rs.getLong("purchases"))
                .views(rs.getLong("views"))
                .build();
    }

    @Override
    public boolean addNew(SubjectStatistic t) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO [subject_statistic] ([revenue], [purchases], [views]) VALUES (?, ?, ?)";
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setObject(1, t.getRevenue());
            ps.setObject(2, t.getPurchases());
            ps.setObject(3, t.getViews());
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<SubjectStatistic> getAll() throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public SubjectStatistic getById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean updateById(String id, SubjectStatistic t) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE [subject_statistic] SET [subject_id] = ?, [revenue] = ?, [purchases] = ?, [views] = ? WHERE subject_statistic_id = ?";
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setObject(1, t.getSubjectId());
            ps.setObject(2, t.getRevenue());
            ps.setObject(3, t.getPurchases());
            ps.setObject(4, t.getViews());
            ps.setObject(5, Long.parseLong(id));
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            return false;
        }
    }

    @Override
    public boolean deleteById(String id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public List<SubjectStatistic> getTopRevenue() {
        List<SubjectStatistic> list = new ArrayList<>();
        String sql = """
                     SELECT TOP 5
                         [subject_statistic_id],
                         [subject_id],
                         [revenue],
                         [purchases],
                         [views]
                     FROM
                         [stuquiz].[dbo].[subject_statistic]
                     ORDER BY
                         [revenue] DESC;
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

    public List<SubjectStatistic> getAllStatistic() {
        List<SubjectStatistic> list = new ArrayList<>();
        String sql = """
                     SELECT
                         *
                     FROM
                         [stuquiz].[dbo].[subject_statistic]
                     ORDER BY
                         [revenue] DESC;
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

    public void updateView(String id) throws SQLException, ClassNotFoundException {
        String sql = """
                UPDATE [stuquiz].[dbo].[subject_statistic]
                SET [views] = [views] + 1
                WHERE [subject_id] = ?;
                """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setObject(1, id);
            ps.executeUpdate();
        }
    }

    public int totalView() throws ClassNotFoundException, SQLException {
        int views = 0;
        String sql = """
                 SELECT SUM([views]) AS total_views
                 FROM [stuquiz].[dbo].[subject_statistic];
                 """;

        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                views = rs.getInt("total_views");
            }
        }
        return views;
    }

    public double totalRevenue() throws ClassNotFoundException, SQLException {
        double revenue = 0;
        String sql = """
            SELECT SUM([revenue]) AS total_revenue
            FROM [stuquiz].[dbo].[subject_statistic];
            """;

        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                revenue = rs.getDouble(1);
            }
        }
        revenue = Math.round(revenue * 100.0) / 100.0;
        return revenue;
    }

    public List<SubjectStatistic> getListStatisticBySubjectName(String searchText) throws SQLException, ClassNotFoundException {
        List<SubjectStatistic> list = new ArrayList<>();
        SubjectDAO subjectDAO = new SubjectDAO();
        List<SubjectStatistic> listAll = new ArrayList<>();
        listAll = getAllStatistic();
        for (SubjectStatistic subjectStatistic : listAll) {
            Subject subject = subjectDAO.getById(subjectStatistic.getSubjectId() + "");
            if (subject.getSubjectName().toLowerCase().trim().contains(searchText.toLowerCase().trim())
                    || subject.getSubjectCode().toLowerCase().trim().contains(searchText.toLowerCase().trim())) {
                list.add(subjectStatistic);
            }
        }
        return list;
    }

    public List<SubjectStatistic> getTeacherStatisticBySubjectName(String searchText, String userId) throws SQLException, ClassNotFoundException {
        List<SubjectStatistic> list = new ArrayList<>();
        SubjectDAO subjectDAO = new SubjectDAO();
        List<SubjectStatistic> listAll = new ArrayList<>();
        listAll = getAllSubjectsOfOwner(userId);
        for (SubjectStatistic subjectStatistic : listAll) {
            Subject subject = subjectDAO.getById(subjectStatistic.getSubjectId() + "");
            if (subject.getSubjectName().toLowerCase().trim().contains(searchText.toLowerCase().trim())
                    || subject.getSubjectCode().toLowerCase().trim().contains(searchText.toLowerCase().trim())) {
                list.add(subjectStatistic);
            }
        }
        return list;
    }

    public List<SubjectStatistic> getAllSubjectsOfOwner(String userId) throws SQLException, ClassNotFoundException {
        List<SubjectStatistic> list = new ArrayList<>();
        String sql = """
             SELECT ss.subject_statistic_id,
                    ss.subject_id,
                    ss.revenue,
                    ss.purchases,
                    ss.views
             FROM [stuquiz].[dbo].[subject] s
             JOIN [stuquiz].[dbo].[subject_statistic] ss
             ON s.subject_id = ss.subject_id
             WHERE s.owner_id = ?
             """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setObject(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public int teacherTotalView(String userId) throws ClassNotFoundException, SQLException {
        int views = 0;
        String sql = """
                 SELECT SUM(ss.views) AS total_views
                 FROM [stuquiz].[dbo].[subject] s
                 JOIN [stuquiz].[dbo].[subject_statistic] ss
                 ON s.subject_id = ss.subject_id
                 WHERE s.owner_id = ?;
                 """;

        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setObject(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                views = rs.getInt("total_views");
            }
        }
        return views;
    }

    public double teacherTotalRevenue(String userId) throws ClassNotFoundException, SQLException {
        double revenue = 0;
        String sql = """
            SELECT SUM(ss.revenue) AS total_revenue
            FROM [stuquiz].[dbo].[subject] s
            JOIN [stuquiz].[dbo].[subject_statistic] ss
            ON s.subject_id = ss.subject_id
            WHERE s.owner_id = ?;
            """;

        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setObject(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                revenue = rs.getDouble(1);
            }
        }
        revenue = Math.round(revenue * 100.0) / 100.0;
        return revenue;
    }

    public List<SubjectStatistic> getTeacherTopRevenue(String userId) throws SQLException, ClassNotFoundException {
        List<SubjectStatistic> list = new ArrayList<>();
        String sql = """
                     SELECT TOP 5 ss.subject_statistic_id,
                                            ss.subject_id,
                                            ss.revenue,
                                            ss.purchases,
                                            ss.views
                              FROM [stuquiz].[dbo].[subject] s
                              JOIN [stuquiz].[dbo].[subject_statistic] ss
                              ON s.subject_id = ss.subject_id
                              WHERE s.owner_id = ?
                              ORDER BY ss.revenue DESC
                     """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public SubjectStatistic getStatisticBySubjectId(String id) throws SQLException, ClassNotFoundException {
        SubjectStatistic subjectStatistic = SubjectStatistic.builder()
                .subjectId(0L)
                .build();
        String sql = """
                     SELECT
                         *
                     FROM
                         [stuquiz].[dbo].[subject_statistic] where subject_id = ?
                     """;
        try (Connection con = SQLServerConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setObject(1, parseLong(id));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                subjectStatistic = mapRow(rs);
            }
        } catch (SQLException e) {
            subjectStatistic = SubjectStatistic.builder()
                    .subjectId(0L)
                    .build();
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            subjectStatistic = SubjectStatistic.builder()
                    .subjectId(0L)
                    .build();
            e.printStackTrace();
        }
        return subjectStatistic;
    }

}
