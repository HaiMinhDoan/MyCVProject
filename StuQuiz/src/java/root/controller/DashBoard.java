/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package root.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import root.DAO.CommentDAO;
import root.DAO.ItemDAO;
import root.DAO.SubjectDAO;
import root.DAO.SubjectStatisticDAO;
import root.DAO.VoteDAO;
import root.entities.main.Subject;
import root.entities.main.SubjectStatistic;
import root.entities.main.User;
import root.entities.sub.SubSubjectStatistic;
import root.entities.sub.VotesInSubject;

/**
 *
 * @author admin
 */
public class DashBoard extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("userAuthorization");
        if (user != null && user.getRoleLevel() == 1) {
            try {
                VoteDAO voteDao = new VoteDAO();
                CommentDAO commentDao = new CommentDAO();
                SubjectStatisticDAO statisticDao = new SubjectStatisticDAO();
                SubjectDAO subjectDao = new SubjectDAO();
                ItemDAO itemDao = new ItemDAO();

                List<SubjectStatistic> listSubject = statisticDao.getTopRevenue();
                Map<Long, Float> avgVote = new HashMap<>();
                List<SubSubjectStatistic> subStatistic = new ArrayList<>();

                String actionCheck = request.getParameter("actionCheck");
                String sortBy = request.getParameter("sortBy");
                String orderBy = request.getParameter("orderBy");
                String searchText = request.getParameter("searchText");

                for (SubjectStatistic s : listSubject) {
                    Subject subjectTemp = subjectDao.getById(String.valueOf(s.getSubjectId()));
                    if (subjectTemp != null) {
                        SubSubjectStatistic subStat = SubSubjectStatistic.builder()
                                .subject(subjectTemp)
                                .subjectStatistic(s)
                                .build();
                        subStatistic.add(subStat);
                    }

                    List<VotesInSubject> votes = subjectDao.getVotesInSubject(String.valueOf(s.getSubjectId()));
                    float totalVote = votes.isEmpty() ? 0f : votes.get(0).getTotalVote();
                    avgVote.put(s.getSubjectId(), totalVote);
                }

                double totalRevenue = statisticDao.totalRevenue();
                int totalView = statisticDao.totalView();
                String formattedTotalView = ViewFormatter.formatViews(totalView);
                double monthlySales = itemDao.getMonthlySales();

                if (actionCheck != null && (actionCheck.equals("sort") || actionCheck.equals("viewAll"))) {
                    listSubject = statisticDao.getAllStatistic();
                    subStatistic = new ArrayList<>();
                    System.out.println(listSubject);
                    for (SubjectStatistic s : listSubject) {
                        Subject subjectTemp = subjectDao.getById(String.valueOf(s.getSubjectId()));
                        if (subjectTemp != null) {
                            SubSubjectStatistic subStat = SubSubjectStatistic.builder()
                                    .subject(subjectTemp)
                                    .subjectStatistic(s)
                                    .build();
                            subStatistic.add(subStat);
                        }
                        List<VotesInSubject> votes = subjectDao.getVotesInSubject(String.valueOf(s.getSubjectId()));
                        float totalVote = votes.isEmpty() ? 0f : votes.get(0).getTotalVote();
                        avgVote.put(s.getSubjectId(), totalVote);
                    }
                    if (actionCheck.equals("sort") && sortBy != null) {
                        bubbleSort(subStatistic, sortBy, orderBy, avgVote);
                    }
                } else if (actionCheck != null && actionCheck.equals("searching")) {
                    request.setAttribute("searchText", searchText);
                    listSubject = statisticDao.getListStatisticBySubjectName(searchText.toLowerCase().trim());
                    subStatistic = new ArrayList<>();
                    System.out.println("Di qua day");
                    for (SubjectStatistic s : listSubject) {
                        Subject subjectTemp = subjectDao.getById(String.valueOf(s.getSubjectId()));
                        if (subjectTemp != null) {
                            SubSubjectStatistic subStat = SubSubjectStatistic.builder()
                                    .subject(subjectTemp)
                                    .subjectStatistic(s)
                                    .build();
                            subStatistic.add(subStat);
                        }
                        List<VotesInSubject> votes = subjectDao.getVotesInSubject(String.valueOf(s.getSubjectId()));
                        float totalVote = votes.isEmpty() ? 0f : votes.get(0).getTotalVote();
                        avgVote.put(s.getSubjectId(), totalVote);
                    }
                }

                request.setAttribute("sortBy", sortBy);
                request.setAttribute("actionCheck", actionCheck);
                request.setAttribute("orderBy", orderBy);
                request.setAttribute("monthlySales", monthlySales);
                request.setAttribute("totalView", formattedTotalView);
                request.setAttribute("totalRevenue", totalRevenue);
                request.setAttribute("avgVote", avgVote);
                request.setAttribute("listSubject", listSubject);
                request.setAttribute("subStatistic", subStatistic);

                request.getRequestDispatcher("DashBoard.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("ErrorPage");
            }
        } else {
            response.sendRedirect("ErrorPage");
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    public class ViewFormatter {

        public static String formatViews(int views) {
            if (views < 1100) {
                return String.format("%d", views);
            } else {
                double formattedViews = views / 1000.0;
                return String.format("%.1fk", formattedViews);
            }
        }
    }

    private void bubbleSort(List<SubSubjectStatistic> list, String sortBy, String orderBy, Map<Long, Float> avgVote) {
        int n = list.size();
        boolean swapped;

        for (int i = 0; i < n - 1; i++) {
            swapped = false;
            for (int j = 0; j < n - 1 - i; j++) {
                boolean condition = false;
                switch (sortBy) {
                    case "subject":
                        condition = list.get(j).getSubject().getSubjectName()
                                .compareTo(list.get(j + 1).getSubject().getSubjectName()) > 0;
                        break;
                    case "view":
                        condition = list.get(j).getSubjectStatistic().getViews()
                                > list.get(j + 1).getSubjectStatistic().getViews();
                        break;
                    case "vote":
                        condition = avgVote.get(list.get(j).getSubjectStatistic().getSubjectId())
                                > avgVote.get(list.get(j + 1).getSubjectStatistic().getSubjectId());
                        break;
                    case "purchase":
                        condition = list.get(j).getSubjectStatistic().getPurchases()
                                > list.get(j + 1).getSubjectStatistic().getPurchases();
                        break;
                    case "sale":
                        condition = list.get(j).getSubjectStatistic().getRevenue()
                                > list.get(j + 1).getSubjectStatistic().getRevenue();
                        break;
                    default:
                        condition = list.get(j).getSubjectStatistic().getRevenue()
                                > list.get(j + 1).getSubjectStatistic().getRevenue();
                        break;
                }
                if (orderBy != null && orderBy.equals("low")) {
                    condition = !condition;
                }
                if (condition) {
                    SubSubjectStatistic temp = list.get(j);
                    list.set(j, list.get(j + 1));
                    list.set(j + 1, temp);
                    swapped = true;
                }
            }
            if (!swapped) {
                break;
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
