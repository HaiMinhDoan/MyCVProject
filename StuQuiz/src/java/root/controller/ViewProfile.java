/*/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import root.DAO.ItemDAO;
import root.DAO.SubjectDAO;
import root.DAO.UserDAO;
import root.entities.main.Item;
import root.entities.main.Subject;
import root.entities.main.User;
import root.entities.sub.SubjectEnrolledAndStatus;

/**
 *
 * @author vtdle
 */
@WebServlet(name = "ViewProfile", urlPatterns = {"/ViewProfile"})
public class ViewProfile extends HttpServlet {

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

        // Used 3 sql
        //String userId = request.getParameter("userId");
        User userAuthorization = (User) request.getSession().getAttribute("userAuthorization");
        if (userAuthorization != null) {
            String userId = userAuthorization.getUserId() + "";
            String isSearching = request.getParameter("isSearching");
            String searchString = request.getParameter("searchString");
            HttpSession session = request.getSession();

            User user = new User();
            try {
                UserDAO userDAO = new UserDAO();
                user = userDAO.getById(userId);
                if (user != null) {
                    request.setAttribute("user", user);
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                response.getWriter().println("Error: " + e.getMessage());
            }

            if (isSearching != null && isSearching.equals("true") && searchString != null && !searchString.isEmpty()) {
                List<SubjectEnrolledAndStatus> listData = new ArrayList<>();
                try {
                    SubjectDAO subjectDAO = new SubjectDAO();
                    ItemDAO itemDAO = new ItemDAO();
                    List<Subject> enrolledSubjects = subjectDAO.getEnrolledSubjectByUserId(userId);
                    if (user.getUserId() != 0L) {
                        Date currentDate = new Date();
                        for (Subject subject : enrolledSubjects) {
                            try {
                                if (subject.getSubjectCode().toLowerCase().contains(searchString.toLowerCase())
                                        || subject.getSubjectName().toLowerCase().contains(searchString.toLowerCase())) {

                                    Item item = itemDAO.getItemByBuyerIdAndSubjectId(userId, String.valueOf(subject.getSubjectId()));
                                    if (item != null && item.getStartDate() != null && item.getEndDate() != null) {
                                        Date sDate = item.getStartDate();
                                        Date eDate = item.getEndDate();
                                        boolean isLearning = !(sDate.before(currentDate) && eDate.before(currentDate));
                                        listData.add(SubjectEnrolledAndStatus.builder()
                                                .subject(subject)
                                                .learning(isLearning)
                                                .startDate(sDate)
                                                .endDate(eDate)
                                                .build());
                                    } else {
                                        System.out.println("Item or its dates are null for subject: " + subject.getSubjectName());
                                    }
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                                response.getWriter().println("Error: " + e.getMessage());
                            }
                        }
                    }

                    request.setAttribute("isSearching", true);
                    request.setAttribute("listData", listData);
                    transferSessionMessagesToRequest(session, request);
                    request.getRequestDispatcher("profile.jsp").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().println("Error: " + e.getMessage());
                }
            } else {

                try {
                    SubjectDAO subjectDAO = new SubjectDAO();
                    ItemDAO itemDAO = new ItemDAO();
                    List<Subject> enrolledSubjects = subjectDAO.getEnrolledSubjectByUserId(userId);
                    if (user.getUserId() != 0L) {
                        List<SubjectEnrolledAndStatus> listData = new ArrayList<>();
                        Date currentDate = new Date();
                        for (Subject subject : enrolledSubjects) {
                            try {
                                Item item = itemDAO.getItemByBuyerIdAndSubjectId(userId, String.valueOf(subject.getSubjectId()));
                                if (item != null && item.getStartDate() != null && item.getEndDate() != null) {
                                    Date sDate = item.getStartDate();
                                    Date eDate = item.getEndDate();
                                    boolean isLearning = !(sDate.before(currentDate) && eDate.before(currentDate));
                                    listData.add(SubjectEnrolledAndStatus.builder()
                                            .subject(subject)
                                            .learning(isLearning)
                                            .startDate(sDate)
                                            .endDate(eDate)
                                            .build());
                                } else {
                                    System.out.println("Item or its dates are null for subject: " + subject.getSubjectName());
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                                response.getWriter().println("Error: " + e.getMessage());
                            }
                        }

                        request.setAttribute("isSearching", false);
                        request.setAttribute("listData", listData);
                        transferSessionMessagesToRequest(session, request);
                        request.getRequestDispatcher("profile.jsp").forward(request, response);
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                    response.getWriter().println("Error: " + e.getMessage());
                }
            }
        } else {
            response.sendRedirect("Account");
        }

    }

    private void transferSessionMessagesToRequest(HttpSession session, HttpServletRequest request) {
        if (session.getAttribute("passwordError") != null) {
            request.setAttribute("passwordError", session.getAttribute("passwordError"));
            session.removeAttribute("passwordError");
        }
        if (session.getAttribute("passwordSuccess") != null) {
            request.setAttribute("passwordSuccess", session.getAttribute("passwordSuccess"));
            session.removeAttribute("passwordSuccess");
        }
        if (session.getAttribute("profileUpdateSuccess") != null) {
            request.setAttribute("profileUpdateSuccess", session.getAttribute("profileUpdateSuccess"));
            session.removeAttribute("profileUpdateSuccess");
        }
        if (session.getAttribute("error") != null) {
            request.setAttribute("error", session.getAttribute("error"));
            session.removeAttribute("error");
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

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
